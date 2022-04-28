//
//  StudyServiceProvider.swift
//  fieldbook-ios
//
//  Created by Tim Parsons on 4/26/22.
//

import Foundation

public class InjectionProvider {
    
    static func getStudyService() -> StudyService {
        return StudyService(database: Database.instance!, studyDAO: getStudyDAO(), observationUnitDAO: getObservationUnitDAO(), observationVariableDAO: getObservationVariableDAO())
    }
    
    static func getObservationVariableService() -> ObservationVariableService {
        return ObservationVariableService(database: Database.instance!, observationVariableDAO: getObservationVariableDAO())
    }
    
    static func getBrAPIStudyService() -> BrAPIStudyService {
        return BrAPIStudyService(studyService: getStudyService())
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
}
