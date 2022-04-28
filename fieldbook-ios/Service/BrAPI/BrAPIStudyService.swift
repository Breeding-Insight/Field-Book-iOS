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
    
    func fetchStudiesFromRemote(programDbId: String? = nil, trialDbId: String? = nil) async throws -> [Study]{
        let brapiClient = BrAPIClientAPI()
        let brapiStudyAPI = StudiesAPI(brAPIClientAPI: brapiClient)
        print("fetching studies")
        
        let (data, error) = await withCheckedContinuation { continuation in
            brapiStudyAPI.studiesGet(programDbId: programDbId, trialDbId: trialDbId, pageSize: PreferencesUtilities.getBrAPIPageSize(), authorization: PreferencesUtilities.getBrAPIToken()) { data, error in
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
            brapiStudyAPI.studiesStudyDbIdGet(studyDbId: studyDbId, authorization: PreferencesUtilities.getBrAPIToken()) { data, error in
                continuation.resume(returning: (data, error))
            }
        }

        if(error == nil) {
            let study = self.convertBrAPIStudy(data!.result)
            do {
                study.observationUnits = try await self.fetchObservationUnits(studyDbId: studyDbId, observationLevel: observationLevel);
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
    
    func fetchObservationUnits(studyDbId: String, observationLevel: String? = nil) async throws -> [ObservationUnit] {
        let brapiClient = BrAPIClientAPI()
        let brapiObservationUnitAPI = ObservationUnitsAPI(brAPIClientAPI: brapiClient)
        
        let (data, error) = await withCheckedContinuation { continuation in
            brapiObservationUnitAPI.observationunitsGet(studyDbId: studyDbId, page: 0, pageSize: PreferencesUtilities.getBrAPIPageSize(), authorization: PreferencesUtilities.getBrAPIToken()) { data, error in
                continuation.resume(returning: (data, error))
            }
        }
        
        if(error == nil) {
            var ret: [ObservationUnit] = []
            for brapiOU in data!.result.data {
                ret.append(convertBrAPIObservationUnit(brapiOU))
            }
            return ret
        } else {
            print("error fetching BrAPIObservationUnits: \(error!.localizedDescription)")
            throw error!
        }
    }
    
    func fetchAssociatedObservationVariables(studyDbId: String) async throws -> [ObservationVariable] {
        let brapiClient = BrAPIClientAPI()
        let brapiObservationVariablesAPI = ObservationVariablesAPI(brAPIClientAPI: brapiClient)
        
        let (data, error) = await withCheckedContinuation { continuation in
            brapiObservationVariablesAPI.variablesGet(studyDbId: studyDbId, page: 0, pageSize: PreferencesUtilities.getBrAPIPageSize(), authorization: PreferencesUtilities.getBrAPIToken()) { data, error in
                continuation.resume(returning: (data, error))
            }
        }
        
        if(error == nil) {
            var ret: [ObservationVariable] = []
            for brapiVariable in data!.result.data {
                ret.append(convertBrAPIObservationVariable(brapiVariable))
            }
            return ret
        } else {
            print("error fetching BrAPIObservationVariables: \(error!.localizedDescription)")
            throw error!
        }
    }
    
    func fetchAvailableObservationLevels(studyDbId: String? = nil, programDbId: String? = nil) async throws -> [String] {
        let brapiClient = BrAPIClientAPI()
        let brapiObservationUnitAPI = ObservationUnitsAPI(brAPIClientAPI: brapiClient)
        
        let (data, error) = await withCheckedContinuation { continuation in
            brapiObservationUnitAPI.observationlevelsGet(studyDbId: studyDbId, programDbId: programDbId, page: 0, pageSize: PreferencesUtilities.getBrAPIPageSize(), authorization: PreferencesUtilities.getBrAPIToken()) { data, error in
                continuation.resume(returning: (data, error))
            }
        }
        
        if(error == nil) {
            var ret: [String] = []
            for level in data!.result.data {
                if(level.levelName != nil) {
                    ret.append(level.levelName!.get())
                }
            }
            
            return ret
        } else {
            print("error fetching available BrAPIObservationLevels: \(error!.localizedDescription)")
            throw error!
        }
    }
    
    func saveStudy(_ study: Study) async {
        //todo
    }
    
    private func convertBrAPIStudy(_ brapiStudy: BrAPIStudy) -> Study {
        let study = Study(name: brapiStudy.studyName ?? "")
        study.studyDbId = brapiStudy.studyDbId
        study.commonCropName = brapiStudy.commonCropName
        
        let additionalInfoStr: String? = brapiStudy.additionalInfo?.map {"\"" + $0 + "\":\"" + $1 + "\""}.joined(separator: ",")
        if(additionalInfoStr != nil) {
            study.additionalInfo = "{" + additionalInfoStr! + "}"
        }
        study.locationDbId = brapiStudy.locationDbId
        study.locationName = brapiStudy.locationName
        study.observationLevels = brapiStudy.observationLevels?.map({ $0.levelName!.rawValue }).joined(separator: ",")
        study.seasons = brapiStudy.seasons?.joined(separator: ",")
        study.startDate = brapiStudy.startDate
        study.code = brapiStudy.studyCode
        study.description = brapiStudy.studyDescription
        study.type = brapiStudy.studyType
        study.trialDbId = brapiStudy.trialDbId
        study.trialName = brapiStudy.trialName
        
        return study
    }
    
    private func convertBrAPIObservationUnit(_ brapiOU: BrAPIObservationUnit) -> ObservationUnit {
        let ou = ObservationUnit()
        ou.germplasmName = brapiOU.germplasmName
        ou.observationunitDbId = brapiOU.observationUnitDbId
        ou.positionCoordinateX = brapiOU.observationUnitPosition?.positionCoordinateX
        ou.positionCoordinateY = brapiOU.observationUnitPosition?.positionCoordinateY
        ou.positionCoordinateXType = brapiOU.observationUnitPosition?.positionCoordinateXType?.get()
        ou.positionCoordinateYType = brapiOU.observationUnitPosition?.positionCoordinateYType?.get()
        ou.primaryId = brapiOU.observationUnitPosition?.positionCoordinateX
        ou.secondaryId = brapiOU.observationUnitPosition?.positionCoordinateY
        ou.observationLevel = brapiOU.observationUnitPosition?.observationLevel?.levelName?.get() ?? "plot"
//        ou.additionalInfo
//        ou.attributes
        
        return ou
    }
    
    private func convertBrAPIObservationVariable(_ brapiVariable: BrAPIObservationVariable) -> ObservationVariable {
        let variable = ObservationVariable(name: brapiVariable.observationVariableName, dataType: brapiVariable.scale!.dataType!.get())
        variable.commonCropName = brapiVariable.commonCropName
        variable.defaultValue = brapiVariable.defaultValue
        variable.observationVariableDbId = brapiVariable.observationVariableDbId
        variable.traitDataSource = "BrAPI"
        variable.language = brapiVariable.language
        variable.ontologyDbId = brapiVariable.ontologyReference?.ontologyDbId
        variable.ontologyName = brapiVariable.ontologyReference?.ontologyName
//        variable.fieldBookFormat
//        variable.details = brapiVariable.
//        variable.additionalInfo
//        variable.attributes =
        
        return variable
    }
}
