//
//  TraitService.swift
//  fieldbook-ios
//
//  Created by Tim Parsons on 4/25/22.
//

import Foundation
import os

class ObservationVariableService {
    private let logger = Logger(subsystem: "org.phenoapps.fieldbook", category: "ObservationVariableService")
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
    
    func saveObservationVariables(_ observationVariables: [ObservationVariable], transaction: Bool = true) throws -> [ObservationVariable]? {
        var savedVariables: [ObservationVariable] = []
        if transaction {
            try database.db.transaction {
                savedVariables = try self._saveObservationVariables(observationVariables) ?? []
            }
        } else {
            savedVariables = try self._saveObservationVariables(observationVariables) ?? []
        }
        
        return savedVariables
    }
    
    private func _saveObservationVariables(_ observationVariables: [ObservationVariable]) throws -> [ObservationVariable]? {
        var savedVariables : Set<ObservationVariable> = []
        for variable in observationVariables {
            logger.debug("saving variable: \(variable.name)")
            do {
                savedVariables.insert(try observationVariableDAO.saveObservationVariable(variable)!)
            } catch FieldBookError.nameConflictError {
                logger.warning("variable already exists, fetching existing variable")
                savedVariables.insert(try observationVariableDAO.getObservationVariableByName(variable.name)!)
            }
        }
        
        return Array(savedVariables)
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
