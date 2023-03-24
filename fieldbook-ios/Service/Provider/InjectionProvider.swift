//
//  StudyServiceProvider.swift
//  fieldbook-ios
//
//  Created by Tim Parsons on 4/26/22.
//

import Foundation

public class InjectionProvider {
    
    static func getStudyService() -> StudyService {
        return StudyService(database: Database.instance!, studyDAO: getStudyDAO(), observationUnitDAO: getObservationUnitDAO(), observationVariableDAO: getObservationVariableDAO(), observationVariableService: getObservationVariableService(), observationDAO: getObservationDAO())
    }
    
    static func getObservationVariableService() -> ObservationVariableService {
        return ObservationVariableService(database: Database.instance!, observationVariableDAO: getObservationVariableDAO())
    }
    
    static func getBrAPIStudyService() -> BrAPIStudyService {
        return BrAPIStudyService(studyService: getStudyService(), brapiVariableService: getBrAPIVariableService())
    }
    
    static func getBrAPIVariableService() -> BrAPIObservationVariableService {
        return BrAPIObservationVariableService(variableService: getObservationVariableService())
    }
    
    static func getBrAPIObservationService() -> BrAPIObservationService {
        return BrAPIObservationService(studyDAO: getStudyDAO(), variableDAO: getObservationVariableDAO(), observationUnitDAO: getObservationUnitDAO(), observationDAO: getObservationDAO())
    }
    
    static func getBrAPIAuthService() -> BrAPIAuthService {
        return BrAPIAuthService()
    }
    
    static func getBrAPIClient() -> BrAPIClientAPI {
        return BrAPIClientAPI(basePath: SettingsUtilities.getBrAPIUrl()!,customHeaders: ["Authorization": "Bearer " + SettingsUtilities.getBrAPIToken()!])
    }
    
    static func getObservationVariableDAO() -> ObservationVariableDAO {
        return ObservationVariableDAO(database: Database.instance!)
    }
    
    static func getStudyDAO() -> StudyDAO {
        return StudyDAO(database: Database.instance!)
    }
    
    static func getObservationUnitDAO() -> ObservationUnitDAO {
        return ObservationUnitDAO(database: Database.instance!)
    }
    
    static func getObservationDAO() -> ObservationDAO {
        return ObservationDAO(database: Database.instance!)
    }
    
    static func getObservationService() -> ObservationService {
        return ObservationService(database: Database.instance!, observationDAO: self.getObservationDAO())
    }
}
