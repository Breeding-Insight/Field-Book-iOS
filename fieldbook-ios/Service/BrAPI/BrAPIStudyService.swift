//
//  BrAPIStudyService.swift
//  fieldbook-ios
//
//  Created by Tim Parsons on 4/25/22.
//

import Foundation
import os

class BrAPIStudyService {
    private let logger = Logger(subsystem: "org.phenoapps.fieldbook", category: "BrAPIStudyService")
    private let studyService: StudyService
    
    init(studyService: StudyService) {
        self.studyService = studyService
    }
    
    func fetchStudiesFromRemote(programDbId: String? = nil, trialDbId: String? = nil, page: Int? = 0) async throws -> [Study]{
        let brapiClient = BrAPIClientAPI()
        let brapiStudyAPI = StudiesAPI(brAPIClientAPI: brapiClient)
        print("fetching studies")
        
        let (data, error) = await withCheckedContinuation { continuation in
            brapiStudyAPI.studiesGet(programDbId: programDbId, trialDbId: trialDbId, page: page, pageSize: SettingsUtilities.getBrAPIPageSize(), authorization: SettingsUtilities.getBrAPIToken()) { data, error in
                continuation.resume(returning: (data, error))
            }
        }
        
        if(error == nil && data != nil) {
            var ret: [Study] = []
            for brapiStudy in data!.result.data {
                ret.append(self.convertBrAPIStudy(brapiStudy))
            }
            return ret
        } else if(error != nil && error is ErrorResponse) {
            let errorResponse = error! as! ErrorResponse
            switch errorResponse {
            case .error(let code, let data, let error):
                let message = data?.debugDescription ?? ""
                print("Error fetching studies: code: \(code), message: \(message)")
                throw error
            }
        }
        
        throw BrAPIError.unknownCallFailure;
    }
    
    func fetchStudyDetails(studyDbId: String, observationLevel: String? = nil) async throws -> Study {
        let brapiClient = BrAPIClientAPI()
        let brapiStudyAPI = StudiesAPI(brAPIClientAPI: brapiClient)
        
        let (data, error) = await withCheckedContinuation { continuation in
            brapiStudyAPI.studiesStudyDbIdGet(studyDbId: studyDbId, authorization: SettingsUtilities.getBrAPIToken()) { data, error in
                continuation.resume(returning: (data, error))
            }
        }

        if(error == nil) {
            let study = self.convertBrAPIStudy(data!.result)
            do {
                let (obsUnits, attributes) = try await self.fetchObservationUnits(studyDbId: studyDbId, observationLevel: observationLevel);
                study.observationUnits = obsUnits
                study.attributes = attributes
                study.observationVariables = try await self.fetchAssociatedObservationVariables(studyDbId: studyDbId)
                return study
            } catch {
                throw error
            }
        } else {
            print("error fetching BrAPIStudy: \(error!.localizedDescription)")
            throw error!
        }
    }
    
    func fetchObservationUnits(studyDbId: String, observationLevel: String? = nil) async throws -> ([ObservationUnit], Set<String>) {
        let brapiClient = BrAPIClientAPI()
        let brapiObservationUnitAPI = ObservationUnitsAPI(brAPIClientAPI: brapiClient)
        
        var ret: [ObservationUnit] = []
        var studyAttrs: Set<String> = []
        var (data, totalPages, attributes, error) = try await fetchObservationUnitsPage(brapiObservationUnitAPI: brapiObservationUnitAPI, studyDbId: studyDbId, page: 0, observationLevel: observationLevel)
        
        if(error == nil) {
            ret.append(contentsOf: data)
            attributes.forEach { attr in
                studyAttrs.insert(attr)
            }
            for i in 1..<(totalPages < 1 ? 1 : totalPages) {
                (data, _, attributes, error) = try await fetchObservationUnitsPage(brapiObservationUnitAPI: brapiObservationUnitAPI, studyDbId: studyDbId, page: i, observationLevel: observationLevel)
                if(error == nil) {
                    ret.append(contentsOf: data)
                    
                    attributes.forEach { attr in
                        studyAttrs.insert(attr)
                    }
                } else {
                    print("error fetching BrAPIObservationUnits: \(String(describing: error))")
                    throw error!
                }
            }
            return (ret, studyAttrs)
        } else {
            print("error fetching BrAPIObservationUnits: \(String(describing: error))")
            throw error!
        }
    }
    
    func fetchAssociatedObservationVariables(studyDbId: String) async throws -> [ObservationVariable] {
        let brapiClient = BrAPIClientAPI()
        let brapiObservationVariablesAPI = ObservationVariablesAPI(brAPIClientAPI: brapiClient)
        
        //todo handle pagination to fetch all
        let (data, error) = await withCheckedContinuation { continuation in
            brapiObservationVariablesAPI.variablesGet(studyDbId: studyDbId, page: 0, pageSize: SettingsUtilities.getBrAPIPageSize(), authorization: SettingsUtilities.getBrAPIToken()) { data, error in
                continuation.resume(returning: (data, error))
            }
        }
        
        if(error == nil) {
            var ret: [ObservationVariable] = []
            for brapiVariable in data!.result.data {
                let (data, error) = convertBrAPIObservationVariable(brapiVariable)
                if(error == nil) {
                    ret.append(data!)
                }
            }
            return ret
        } else {
            print("error fetching BrAPIObservationVariables: \(String(describing: error))")
            throw error!
        }
    }
    
    func fetchAvailableObservationLevels(studyDbId: String? = nil, programDbId: String? = nil) async throws -> [String] {
        let brapiClient = BrAPIClientAPI()
        let brapiObservationUnitAPI = ObservationUnitsAPI(brAPIClientAPI: brapiClient)
        
        let (data, error) = await withCheckedContinuation { continuation in
            brapiObservationUnitAPI.observationlevelsGet(studyDbId: studyDbId, programDbId: programDbId, page: 0, pageSize: SettingsUtilities.getBrAPIPageSize(), authorization: SettingsUtilities.getBrAPIToken()) { data, error in
                continuation.resume(returning: (data, error))
            }
        }
        
        if(error == nil) {
            var ret: [String] = []
            for level in data!.result.data {
                if(level.levelName != nil) {
                    ret.append(level.levelName!)
                }
            }
            
            return ret
        } else {
            print("error fetching available BrAPIObservationLevels: \(String(describing: error))")
            throw error!
        }
    }
    
    private func convertBrAPIStudy(_ brapiStudy: BrAPIStudy) -> Study {
        let study = Study(name: brapiStudy.studyName ?? "")
        study.studyDbId = brapiStudy.studyDbId
        study.commonCropName = brapiStudy.commonCropName
        
        
        study.additionalInfo = brapiStudy.additionalInfo?.toJsonString()
        study.locationDbId = brapiStudy.locationDbId
        study.locationName = brapiStudy.locationName
        study.observationLevels = brapiStudy.observationLevels?.map({ $0.levelName! }).joined(separator: ",")
        study.seasons = brapiStudy.seasons?.joined(separator: ",")
        study.startDate = brapiStudy.startDate
        study.code = brapiStudy.studyCode
        study.description = brapiStudy.studyDescription
        study.type = brapiStudy.studyType
        study.trialDbId = brapiStudy.trialDbId
        study.trialName = brapiStudy.trialName
        
        return study
    }
    
    private func convertBrAPIObservationUnit(_ brapiOU: BrAPIObservationUnit) -> (ObservationUnit, [String]) {
        let ou = ObservationUnit()
        ou.germplasmName = brapiOU.germplasmName
        ou.observationunitDbId = brapiOU.observationUnitDbId
        ou.positionCoordinateX = brapiOU.observationUnitPosition?.positionCoordinateX
        ou.positionCoordinateY = brapiOU.observationUnitPosition?.positionCoordinateY
        ou.positionCoordinateXType = brapiOU.observationUnitPosition?.positionCoordinateXType?.get()
        ou.positionCoordinateYType = brapiOU.observationUnitPosition?.positionCoordinateYType?.get()
        ou.primaryId = brapiOU.observationUnitPosition?.positionCoordinateX
        ou.secondaryId = brapiOU.observationUnitPosition?.positionCoordinateY
        ou.observationLevel = brapiOU.observationUnitPosition?.observationLevel?.levelName ?? "plot"
        ou.additionalInfo = brapiOU.additionalInfo
        
        var attributes: [String] =  []
        let pos = brapiOU.observationUnitPosition
        if(pos != nil) {
            var levelRelationships = pos!.observationLevelRelationships
            levelRelationships?.append(pos!.observationLevel!)
            
            if(levelRelationships != nil) {
                for level in levelRelationships! {
                    let attr = ObservationUnitAttribute(attributeName: (level.levelName!.prefix(1).uppercased() + level.levelName!.dropFirst()))
                    let val = ObservationUnitAttributeValue(value: String(level.levelOrder!))
                    ou.attributes![attr] = val
                    attributes.append(attr.attributeName)
                }
            }
            
            if(pos?.positionCoordinateX != nil) {
                let attr = ObservationUnitAttribute(attributeName: getPositionTypeStr(pos!.positionCoordinateXType ?? .longitude))
                let val = ObservationUnitAttributeValue(value: pos!.positionCoordinateX!)
                ou.attributes![attr] = val
                attributes.append(attr.attributeName)
            }
            
            if(pos?.positionCoordinateY != nil) {
                let attr = ObservationUnitAttribute(attributeName: getPositionTypeStr(pos!.positionCoordinateYType ?? .latitude))
                let val = ObservationUnitAttributeValue(value: pos!.positionCoordinateY!)
                ou.attributes![attr] = val
                attributes.append(attr.attributeName)
            }
            
            if(pos?.entryType != nil) {
                let attr = ObservationUnitAttribute(attributeName: "EntryType")
                let val = ObservationUnitAttributeValue(value: pos!.entryType!.get())
                ou.attributes![attr] = val
                attributes.append(attr.attributeName)
            }
            
            if(brapiOU.germplasmName != nil) {
                let attr = ObservationUnitAttribute(attributeName: "Germplasm")
                let val = ObservationUnitAttributeValue(value: brapiOU.germplasmName!)
                ou.attributes![attr] = val
                attributes.append(attr.attributeName)
            }
            
            if(brapiOU.observationUnitDbId != nil) {
                let attr = ObservationUnitAttribute(attributeName: "ObservationUnitDbId")
                let val = ObservationUnitAttributeValue(value: brapiOU.observationUnitDbId!)
                ou.attributes![attr] = val
                attributes.append(attr.attributeName)
            }
            
            if(brapiOU.observationUnitName != nil) {
                let attr = ObservationUnitAttribute(attributeName: "ObservationUnitName")
                let val = ObservationUnitAttributeValue(value: brapiOU.observationUnitName!)
                ou.attributes![attr] = val
                attributes.append(attr.attributeName)
            }
        }
        
        return (ou, attributes)
    }
    
    private func getPositionTypeStr(_ type: BrAPIObservationUnitPosition.PositionCoordinateType) -> String {
        switch type {
        case .longitude, .plantedRow, .gridRow, .measuredRow:
            return "Row"
        case .latitude, .plantedIndividual, .gridCol, .measuredCol:
            return "Column"
        }
    }
    
    private func convertBrAPIObservationVariable(_ brapiVariable: BrAPIObservationVariable) -> (ObservationVariable?, Error?) {
        let name = Utilities.getFirstNonNil([brapiVariable.synonyms?[0], brapiVariable.trait?.traitName, brapiVariable.observationVariableName])
        if(name == nil) {
            return (nil, FieldBookError.serviceError(message: "Missing variable name"))
        }
        
        let variable = ObservationVariable(name: name!, dataType: brapiVariable.scale!.dataType!.get())
        
        if(brapiVariable.scale?.dataType != nil) {
            variable.fieldBookFormat = convertBrAPIScaleType(type: brapiVariable.scale!.dataType!)
        } else {
            variable.fieldBookFormat = TraitFormat.text
        }
        variable.commonCropName = brapiVariable.commonCropName
        variable.defaultValue = brapiVariable.defaultValue
        variable.observationVariableDbId = brapiVariable.observationVariableDbId
        variable.traitDataSource = SettingsUtilities.getBrAPIUrl()
        variable.language = brapiVariable.language
        variable.ontologyDbId = brapiVariable.ontologyReference?.ontologyDbId
        variable.ontologyName = brapiVariable.ontologyReference?.ontologyName
        variable.externalDbId = brapiVariable.observationVariableDbId
        
        var details = brapiVariable.trait?.traitDescription ?? ""
        var additionalInfo: [String:String] = brapiVariable.additionalInfo != nil ? brapiVariable.additionalInfo! : [:]
        var categories: [[String:String]] = []
        if(variable.fieldBookFormat == TraitFormat.categorical && brapiVariable.scale?.validValues?.categories != nil) {
            if(details.count > 0) {
                details += "\nCategories: "
            }
            for (catIdx, cat) in brapiVariable.scale!.validValues!.categories!.enumerated() {
                details += cat.value! + (cat.label != nil ? "=" + cat.label! : "")
                if(catIdx + 1 < brapiVariable.scale!.validValues!.categories!.count) {
                    details += "\n"
                }
                var categoriesDict: [String:String] = [:]
                categoriesDict["value"] = cat.value!
                categoriesDict["label"] = cat.label ?? ""
                categories.append(categoriesDict)
            }
            
            additionalInfo["catValueLabel"] = categories.toJsonString()
            
            let catAttr = ObservationVariableAttribute(attributeName: "category")
            let catAttrVal = ObservationVariableAttributeValue(value: additionalInfo["catValueLabel"]!)
            variable.attributes![catAttr] = catAttrVal
        }
        
        variable.details = details
        variable.additionalInfo = additionalInfo
        
        if(brapiVariable.scale?.validValues?.min != nil) {
            let catValidValMin = ObservationVariableAttribute(attributeName: "validValMin")
            let catValidValMinVal = ObservationVariableAttributeValue(value: String(brapiVariable.scale!.validValues!.min!))
            variable.attributes![catValidValMin] = catValidValMinVal
        }
        
        if(brapiVariable.scale?.validValues?.max != nil) {
            let catValidValMax = ObservationVariableAttribute(attributeName: "validValMax")
            let catValidValMaxVal = ObservationVariableAttributeValue(value: String(brapiVariable.scale!.validValues!.max!))
            variable.attributes![catValidValMax] = catValidValMaxVal
        }
        
        return (variable, nil)
    }
    
    private func convertBrAPIScaleType(type: BrAPIScale.DataType) -> TraitFormat {
        switch type {
        case .date:
            return TraitFormat.date
        case .nominal, .ordinal:
            return TraitFormat.categorical
        case .numerical, .duration:
            return TraitFormat.numeric
        case .code, .text:
            fallthrough
        default:
            return TraitFormat.text
        }
    }
    
    private func fetchObservationUnitsPage(brapiObservationUnitAPI: ObservationUnitsAPI, studyDbId: String, page: Int, observationLevel: String? = nil) async throws -> ([ObservationUnit], Int, Set<String>, Error?) {
        let (data, error) = await withCheckedContinuation { continuation in
            brapiObservationUnitAPI.observationunitsGet(studyDbId: studyDbId, page: page, pageSize: SettingsUtilities.getBrAPIPageSize(), authorization: SettingsUtilities.getBrAPIToken()) { data, error in
                continuation.resume(returning: (data, error))
            }
        }
        if(error == nil) {
            var ret: [ObservationUnit] = []
            var studyAttrs: Set<String> = []
            for brapiOU in data!.result.data {
                let (data, attributes) = convertBrAPIObservationUnit(brapiOU)
                ret.append(data)
                
                attributes.forEach { attr in
                    studyAttrs.insert(attr)
                }
            }
            return (ret, data!.metadata.pagination!.totalPages!, studyAttrs, nil)
        } else {
            return ([], 0, [], error)
        }
    }
}
