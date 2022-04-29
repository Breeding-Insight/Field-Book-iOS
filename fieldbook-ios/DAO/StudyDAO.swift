//
//  StudyDAO.swift
//  fieldbook-ios
//
//  Created by Tim Parsons on 4/25/22.
//

import Foundation
import SQLite

class StudyDAO {
    private let database: Database
    
    init(database:Database) {
        self.database = database
    }
    
    func saveStudy(_ study: Study) throws -> Study? {
        let savedStudy = try self.getStudyByName(study.name)
        if (savedStudy != nil && savedStudy?.internalId != study.internalId) {
            throw FieldBookError.nameConflictError(message: "Study with name \"\(study.name)\" already exists")
        } else {
            let insert = StudiesTable.TABLE.upsert(StudiesTable.INTERNAL_ID_STUDY <- study.internalId,
                                                   StudiesTable.STUDY_DB_ID <- study.studyDbId,
                                                   StudiesTable.STUDY_NAME <- study.name,
                                                   StudiesTable.STUDY_ALIAS <- study.alias,
                                                   StudiesTable.STUDY_UNIQUE_ID_NAME <- study.uniqueIdName,
                                                   StudiesTable.STUDY_PRIMARY_ID_NAME <- study.primaryIdName,
                                                   StudiesTable.STUDY_SECONDARY_ID_NAME <- study.secondaryIdName,
                                                   StudiesTable.EXPERIMENTAL_DESIGN <- study.experimentalDesign,
                                                   StudiesTable.COMMON_CROP_NAME <- study.commonCropName,
                                                   StudiesTable.STUDY_SORT_NAME <- study.sortName,
                                                   StudiesTable.DATE_IMPORT <- study.dateImport,
                                                   StudiesTable.DATE_EDIT <- study.dateEdit,
                                                   StudiesTable.DATE_EXPORT <- study.dateExport,
                                                   StudiesTable.STUDY_SOURCE <- study.source,
                                                   StudiesTable.ADDITIONAL_INFO <- study.additionalInfo,
                                                   StudiesTable.LOCATION_DB_ID <- study.locationDbId,
                                                   StudiesTable.LOCATION_NAME <- study.locationName,
                                                   StudiesTable.OBSERVATION_LEVELS <- study.observationLevels,
                                                   StudiesTable.SEASONS <- study.seasons,
                                                   StudiesTable.START_DATE <- study.startDate,
                                                   StudiesTable.STUDY_CODE <- study.code,
                                                   StudiesTable.STUDY_DESCRIPTION <- study.description,
                                                   StudiesTable.STUDY_TYPE <- study.type,
                                                   StudiesTable.TRIAL_DB_ID <- study.trialDbId,
                                                   StudiesTable.TRIAL_NAME <- study.trialName,
                                                   StudiesTable.COUNT <- study.count, onConflictOf: StudiesTable.INTERNAL_ID_STUDY)
            
            do {
                var studyId: Int64 = -1
                studyId = try database.db.run(insert)
                
                return try getStudy(studyId)
            } catch let Result.error(message, code, statement) {
                throw FieldBookError.daoError(message: "Failure saving study -> code: \(code), error: \(message), in \(String(describing: statement))")
            }
        }
    }
    
    func getStudy(_ internalId: Int64) throws -> Study? {
        do {
            if let record = try database.db.pluck(StudiesTable.TABLE.filter(StudiesTable.INTERNAL_ID_STUDY == internalId)) {
                return populateRecord(record)
            }
        } catch let Result.error(message, code, statement) {
            throw FieldBookError.daoError(message: "failure getting study -> code: \(code), error: \(message), in \(String(describing: statement))")
        }
        
        return nil
    }
    
    func getStudyByName(_ studyName: String) throws -> Study? {
        do {
            if let record = try database.db.pluck(StudiesTable.TABLE.filter(StudiesTable.STUDY_NAME == studyName)) {
                return populateRecord(record)
            }
        } catch let Result.error(message, code, statement) {
            throw FieldBookError.daoError(message: "failure getting study -> code: \(code), error: \(message), in \(String(describing: statement))")
        }
        
        return nil
    }
    
    func getStudies() throws -> [Study] {
        var ret: [Study] = []
        do {
            for record in try database.db.prepare(StudiesTable.TABLE) {
                ret.append(populateRecord(record))
            }
            
            return ret
        } catch let Result.error(message, code, statement) {
            throw FieldBookError.daoError(message: "Failure getting studies -> code: \(code), error: \(message), in \(String(describing: statement))")
        }
    }
    
    func deleteStudies(_ studyIds: [Int64]) throws -> Int {
        do {
            return try database.db.run(StudiesTable.TABLE.filter(studyIds.contains(StudiesTable.INTERNAL_ID_STUDY)).delete())
        } catch let Result.error(message, code, statement) {
            throw FieldBookError.daoError(message: "failure deleting study -> code: \(code), error: \(message), in \(String(describing: statement))")
        }
    }
    
    private func populateRecord(_ record: Row) -> Study {
        let study = Study(name: record[StudiesTable.STUDY_NAME])
        study.internalId = record[StudiesTable.INTERNAL_ID_STUDY]
        study.studyDbId = record[StudiesTable.STUDY_DB_ID]
        study.alias = record[StudiesTable.STUDY_ALIAS]
        study.uniqueIdName = record[StudiesTable.STUDY_UNIQUE_ID_NAME]
        study.primaryIdName = record[StudiesTable.STUDY_PRIMARY_ID_NAME]
        study.secondaryIdName = record[StudiesTable.STUDY_SECONDARY_ID_NAME]
        study.experimentalDesign = record[StudiesTable.EXPERIMENTAL_DESIGN]
        study.commonCropName = record[StudiesTable.COMMON_CROP_NAME]
        study.sortName = record[StudiesTable.STUDY_SORT_NAME]
        study.dateImport = record[StudiesTable.DATE_IMPORT]
        study.dateEdit = record[StudiesTable.DATE_EDIT]
        study.dateExport = record[StudiesTable.DATE_EXPORT]
        study.source = record[StudiesTable.STUDY_SOURCE]
        study.additionalInfo = record[StudiesTable.ADDITIONAL_INFO]
        study.locationDbId = record[StudiesTable.LOCATION_DB_ID]
        study.locationName = record[StudiesTable.LOCATION_NAME]
        study.observationLevels = record[StudiesTable.OBSERVATION_LEVELS]
        study.seasons = record[StudiesTable.SEASONS]
        study.startDate = record[StudiesTable.START_DATE]
        study.code = record[StudiesTable.STUDY_CODE]
        study.description = record[StudiesTable.STUDY_DESCRIPTION]
        study.type = record[StudiesTable.STUDY_TYPE]
        study.trialDbId = record[StudiesTable.TRIAL_DB_ID]
        study.trialName = record[StudiesTable.TRIAL_DB_ID]
        study.count = record[StudiesTable.COUNT]
        
        return study
    }
}
