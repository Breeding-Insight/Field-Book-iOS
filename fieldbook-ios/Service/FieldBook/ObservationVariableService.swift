//
//  TraitService.swift
//  fieldbook-ios
//
//  Created by Tim Parsons on 4/25/22.
//

import Foundation

class ObservationVariableService {
    private let database: Database
    private let observationVariableDAO: ObservationVariableDAO
    
    init(database: Database, observationVariableDAO: ObservationVariableDAO) {
        self.database = database
        self.observationVariableDAO = observationVariableDAO
    }
    
    func saveObservationVariable(_ observationVariable: ObservationVariable) throws -> ObservationVariable? {
        var ret: ObservationVariable? = nil
        do {
            try database.db.transaction {
                ret = try observationVariableDAO.saveObservationVariable(observationVariable)
            }
        } catch let FieldBookError.daoError(message) {
            throw FieldBookError.serviceError(message: message)
        }
        return ret
    }
    
    func getObservationVariable(_ internalId: Int64) throws -> ObservationVariable? {
        do {
            return try observationVariableDAO.getObservationVariable(internalId)
        } catch let FieldBookError.daoError(message) {
            throw FieldBookError.serviceError(message: message)
        }
    }
    
    func getAllObservationVariables() throws -> [ObservationVariable] {
        do {
            return try observationVariableDAO.getObservationVariables()
        } catch let FieldBookError.daoError(message) {
            throw FieldBookError.serviceError(message: message)
        }
    }
    
    func deleteObservationVariables(_ internalIds: [Int64]) throws -> Int {
        var removed = 0
        do {
            try database.db.transaction {
                removed = try observationVariableDAO.deleteObservationVariables(internalIds)
            }
        } catch let FieldBookError.daoError(message) {
            throw FieldBookError.serviceError(message: message)
        }
        
        return removed
    }
}
