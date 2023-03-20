//
//  ObservationDAO.swift
//  fieldbook-ios
//
//  Created by Tim Parsons on 4/25/22.
//

import Foundation
import SQLite

class ObservationDAO {
    private let database: Database
    
    init(database:Database) {
        self.database = database
    }
    
    func saveObservation(_ observation: Observation) throws -> Observation? {
        let savedObservation = try self.getObservation(observation.internalId)
        if(savedObservation != nil) {
            let update = ObservationsTable.TABLE.filter(ObservationsTable.INTERNAL_ID_OBSERVATION == observation.internalId).update(ObservationsTable.VALUE <- observation.value)
            
            do {
                try database.db.run(update)
                
                return observation
            } catch let Result.error(message, code, statement) {
                throw FieldBookError.daoError(message: "Failure saving observation -> code: \(code), error: \(message), in \(String(describing: statement))")
            }
        } else {
            let insert = ObservationsTable.TABLE.insert(ObservationsTable.OBSERVATION_UNIT_ID <- observation.observationUnitId, ObservationsTable.STUDY_ID <- observation.studyId, ObservationsTable.OBSERVATION_VARIABLE_DB_ID <- observation.observationVariableId, ObservationsTable.VALUE <- observation.value, ObservationsTable.OBSERVATION_TIME_STAMP <- Date(),
                ObservationsTable.COLLECTOR <- observation.collector,
                ObservationsTable.GEOCOORDINATES <- observation.geoCoordinates,
                ObservationsTable.OBSERVATION_DB_ID <- observation.observationDbId,
                ObservationsTable.LAST_SYNCED_TIME <- observation.lastSyncedTime,
                ObservationsTable.ADDITIONAL_INFO <- observation.additionalInfo,
                ObservationsTable.REP <- observation.rep,
                ObservationsTable.NOTES <- observation.notes)
            
            do {
                var observationId: Int64 = -1
                observationId = try database.db.run(insert)
                
                return try getObservation(observationId)
            } catch let Result.error(message, code, statement) {
                throw FieldBookError.daoError(message: "Failure saving observation -> code: \(code), error: \(message), in \(String(describing: statement))")
            }
        }
    }
    
    func getObservation(_ internalId: Int64?) throws -> Observation? {
        if(internalId != nil) {
            do {
                if let record = try database.db.pluck(ObservationsTable.TABLE.filter(ObservationsTable.INTERNAL_ID_OBSERVATION == internalId)) {
                    return populateRecord(record)
                }
            } catch let Result.error(message, code, statement) {
                throw FieldBookError.daoError(message: "failure getting observation -> code: \(code), error: \(message), in \(String(describing: statement))")
            }
        }
        
        return nil
    }
    
    func getObservations(_ studyId: Int64) throws -> [Observation] {
        var ret: [Observation] = []
        do {
            for record in try database.db.prepare(ObservationsTable.TABLE.filter(ObservationsTable.STUDY_ID == studyId)) {
                let obs = populateRecord(record)
                ret.append(obs)
            }
        } catch let Result.error(message, code, statement) {
            throw FieldBookError.daoError(message: "failure getting observations -> code: \(code), error: \(message), in \(String(describing: statement))")
        }
        
        return ret
    }
    
    func deleteObservation(observationIds: [Int64]? = nil, studyId: Int64? = nil) throws -> Int {
        var removed = 0
        do {
            //TODO delete attributes and values
            if(studyId == nil && observationIds != nil) {
                removed = try database.db.run(ObservationsTable.TABLE.filter(observationIds!.contains(ObservationsTable.INTERNAL_ID_OBSERVATION)).delete())
            } else if(studyId != nil) {
                removed = try database.db.run(ObservationsTable.TABLE.filter(ObservationsTable.STUDY_ID == studyId!).delete())
            } else {
                throw FieldBookError.daoError(message: "Must supply either observationIds or studyId")
            }
        } catch let Result.error(message, code, statement) {
            throw FieldBookError.daoError(message: "failure deleting observations -> code: \(code), error: \(message), in \(String(describing: statement))")
        }
        
        return removed
    }
    
    private func populateRecord(_ record: Row) -> Observation {
        let observation = Observation(observationUnitId: record[ObservationsTable.OBSERVATION_UNIT_ID], studyId: record[ObservationsTable.STUDY_ID], observationVariableId: record[ObservationsTable.OBSERVATION_VARIABLE_DB_ID])
        observation.internalId = record[ObservationsTable.INTERNAL_ID_OBSERVATION]
        observation.observationVariableName = record[ObservationsTable.OBSERVATION_VARIABLE_NAME]
        observation.observationVariableFieldBookFormat = record[ObservationsTable.OBSERVATION_VARIABLE_FIELD_BOOK_FORMAT]
        observation.value = record[ObservationsTable.VALUE]
        observation.observationTimeStamp = record[ObservationsTable.OBSERVATION_TIME_STAMP]
        observation.collector = record[ObservationsTable.COLLECTOR]
        observation.geoCoordinates = record[ObservationsTable.GEOCOORDINATES]
        observation.observationDbId = record[ObservationsTable.OBSERVATION_DB_ID]
        observation.lastSyncedTime = record[ObservationsTable.LAST_SYNCED_TIME]
        observation.additionalInfo = record[ObservationsTable.ADDITIONAL_INFO]
        observation.rep = record[ObservationsTable.REP]
        observation.notes = record[ObservationsTable.NOTES]
        
        return observation
    }
}
