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
                    var savedVariables : Set<ObservationVariable> = []
                    for variable in study.observationVariables {
                        do {
                            savedVariables.insert(try observationVariableDAO.saveObservationVariable(variable)!)
                        } catch FieldBookError.nameConflictError {
                            print("variable already exists, fetching existing variable")
                            savedVariables.insert(try observationVariableDAO.getObservationVariableByName(variable.name)!)
                        }
                    }
                    
                    //                    if(savedVariables.count != study.observationVariables.count) {
                    //                        throw FieldBookError.serviceError(message: "Some observationVariables were not saved")
                    //                    } else {
                    savedStudy?.observationVariables = Array(savedVariables)
                    //                    }
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
    
    func getStudyByName(_ name: String) throws -> Study? {
        do {
            let study = try studyDAO.getStudyByName(name)
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
    
    func setActiveStudy(_ studyId: Int64?) throws {
        let observationUnitPropertyTableName = "ObservationUnitProperty"
        do {
            try database.db.transaction {
                try database.db.execute("DROP TABLE IF EXISTS \(observationUnitPropertyTableName)")

                if let studyId = studyId {
                    let observationUnitAttrs = try observationUnitDAO.getObservationUnitAttributes(studyId)
                    
                    let selects = observationUnitAttrs.map{ attr in
                        return "MAX(CASE WHEN attr.observation_unit_attribute_name = '\(attr.attributeName)' THEN vals.observation_unit_value_name ELSE NULL END) AS \"\(attr.attributeName)\""
                    }
                    
                    var selectStmt = ""
                    if(!selects.isEmpty) {
                        selectStmt = ", " + selects.joined(separator: ", ")
                    }
                    
                    let query = """
                    CREATE TABLE IF NOT EXISTS \(observationUnitPropertyTableName) AS
                    SELECT units.\(ObservationUnitsTable.INTERNAL_ID_OBSERVATION_UNIT.getName) AS id \(selectStmt)
                    FROM \(ObservationUnitsTable.TABLE.getName) AS units
                    LEFT JOIN \(ObservationUnitValuesTable.TABLE.getName) AS vals ON units.\(ObservationUnitsTable.INTERNAL_ID_OBSERVATION_UNIT.getName) = vals.\(ObservationUnitValuesTable.OBSERVATION_UNIT_ID.getName)
                    LEFT JOIN \(ObservationUnitAttributesTable.TABLE.getName) AS attr on vals.\(ObservationUnitValuesTable.OBSERVATION_UNIT_ATTRIBUTE_DB_ID.getName) = attr.\(ObservationUnitAttributesTable.INTERNAL_ID_OBSERVATION_UNIT_ATTRIBUTE.getName)
                    WHERE units.\(ObservationUnitsTable.STUDY_ID.getName) = ?
                    GROUP BY units.\(ObservationUnitsTable.INTERNAL_ID_OBSERVATION_UNIT.getName)
                    """
                    
                    try database.db.run(query, studyId)
                }
            }
        } catch let FieldBookError.daoError(message) {
            throw FieldBookError.serviceError(message: message)
        }
    }
}
