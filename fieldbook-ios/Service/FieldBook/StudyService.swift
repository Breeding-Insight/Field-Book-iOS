//
//  StudyService.swift
//  fieldbook-ios
//
//  Created by Tim Parsons on 4/25/22.
//

import Foundation

class StudyService {
    private let database: Database
    private let studyDAO: StudyDAO
    private let observationUnitDAO: ObservationUnitDAO
    private let observationVariableDAO: ObservationVariableDAO
    
    init(database: Database, studyDAO: StudyDAO, observationUnitDAO: ObservationUnitDAO, observationVariableDAO: ObservationVariableDAO) {
        self.database = database
        self.studyDAO = studyDAO
        self.observationUnitDAO = observationUnitDAO
        self.observationVariableDAO = observationVariableDAO
    }
    
    func saveStudy(study: Study) throws -> Study? {
        do {
            var savedStudy: Study? = nil
            try database.db.transaction {
                savedStudy = try studyDAO.saveStudy(study)
                
                if(!study.observationUnits.isEmpty) {
                    var savedOus: [ObservationUnit] = []
                    for ou in study.observationUnits {
                        ou.studyId = savedStudy!.internalId!
                        savedOus.append(try observationUnitDAO.saveObservationUnit(ou)!)
                    }
                    
                    if(savedOus.count != study.observationUnits.count) {
                        throw FieldBookError.serviceError(message: "Some observationUnits were not saved")
                    } else {
                        savedStudy?.observationUnits = savedOus
                    }
                }
                
                if(!study.observationVariables.isEmpty) {
                    var savedVariables : [ObservationVariable] = []
                    for variable in study.observationVariables {
                        savedVariables.append(try observationVariableDAO.saveObservationVariable(variable)!)
                    }
                    
                    if(savedVariables.count != study.observationVariables.count) {
                        throw FieldBookError.serviceError(message: "Some observationVariables were not saved")
                    } else {
                        savedStudy?.observationVariables = savedVariables
                    }
                }
            }
            return savedStudy
        } catch let FieldBookError.daoError(message) {
            throw FieldBookError.serviceError(message: message)
        }
    }
    
    func getStudy(_ internalId: Int64) throws -> Study? {
        do {
            let study = try studyDAO.getStudy(internalId)
            
            study?.observationUnits = try observationUnitDAO.getObservationUnits(studyId: internalId)
            
            return study
        } catch let FieldBookError.daoError(message) {
            throw FieldBookError.serviceError(message: message)
        }
    }
    
    func getAllStudies(full: Bool = false) throws -> [Study] {
        do {
            let studies = try studyDAO.getStudies()
            
            if(full) {
                for study in studies {
                    study.observationUnits = try observationUnitDAO.getObservationUnits(studyId: study.internalId!)
                }
            }
            
            return studies
        } catch let FieldBookError.daoError(message) {
            throw FieldBookError.serviceError(message: message)
        }
    }
    
    func deleteStudy(_ studyIds: [Int64]) throws -> Int {
        var deletedCount = 0
        do {
            try database.db.transaction {
                for studyId in studyIds {
                    _ = try observationUnitDAO.deleteObservationUnits(studyId: studyId)
                }
                
                deletedCount = try studyDAO.deleteStudies(studyIds)
            }
        } catch let FieldBookError.daoError(message) {
            throw FieldBookError.serviceError(message: message)
        }
        
        return deletedCount
    }
}
