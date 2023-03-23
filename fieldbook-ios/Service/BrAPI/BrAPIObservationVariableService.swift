//
//  BrAPIObservationVariableService.swift
//  fieldbook-ios
//
//  Created by Tim Parsons on 4/25/22.
//

import Foundation
import os

class BrAPIObservationVariableService {
    private let logger = Logger(subsystem: "org.phenoapps.fieldbook", category: "BrAPIObservationVariableService")
    private let variableService: ObservationVariableService
    
    init(variableService: ObservationVariableService) {
        self.variableService = variableService
    }
    
    func fetchAvailableObservationVariables() async throws -> [ObservationVariable] {
        return try await self.fetchObservationVariables(studyDbId: nil)
    }
    
    func fetchAssociatedObservationVariables(studyDbId: String) async throws -> [ObservationVariable] {
        return try await self.fetchObservationVariables(studyDbId: studyDbId)
    }
    
    private func fetchObservationVariables(studyDbId: String?) async throws -> [ObservationVariable] {
        let brapiClient = InjectionProvider.getBrAPIClient()
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
            logger.error("error fetching BrAPIObservationVariables: \(String(describing: error))")
            throw error!
        }
    }
    
    private func convertBrAPIObservationVariable(_ brapiVariable: BrAPIObservationVariable) -> (ObservationVariable?, Error?) {
        let name = Utilities.getFirstNonNil([ brapiVariable.trait?.traitName, brapiVariable.observationVariableName])
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
        var additionalInfo: [String:Any] = brapiVariable.additionalInfo?.value != nil ? brapiVariable.additionalInfo!.value as! [String: Any] : [:]
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
            let catAttrVal = ObservationVariableAttributeValue(value: additionalInfo["catValueLabel"]! as! String)
            variable.attributes![catAttr] = catAttrVal
        }
        
        variable.details = details
        variable.additionalInfo = JSONObject(value: additionalInfo)
        
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
}
