//
//  ObservationService.swift
//  fieldbook-ios
//
//  Created by Tim Parsons on 4/25/22.
//

import Foundation
import os

class ObservationService {
    private let logger = Logger(subsystem: "org.phenoapps.fieldbook", category: "ObservationService")
    private let database: Database
    private let observationDAO: ObservationDAO
    
    init(database: Database, observationDAO: ObservationDAO) {
        self.database = database
        self.observationDAO = observationDAO
    }
    
    func saveObservation(observation: Observation) throws -> Observation? {
        logger.debug("saving observation ->  ouID: \(observation.observationUnitId!)\ntrait: \(observation.observationVariableId!)")
        
        do {
            var savedObservation: Observation? = nil
            try database.db.transaction {
                savedObservation = try observationDAO.saveObservation(observation)
            }
            
            return savedObservation
        } catch let FieldBookError.daoError(message) {
            throw FieldBookError.serviceError(message: message)
        }
    }
    
    func saveObservations(observations: [Observation]) throws -> [Observation] {
        logger.debug("saving observations")
                
        do {
            var savedObservations: [Observation] = []
            try database.db.transaction {
                for observation in observations {
                    logger.debug("saving observation ->  ouID: \(observation.observationUnitId!)\ntrait: \(observation.observationVariableId!)")
                    savedObservations.append(try observationDAO.saveObservation(observation)!)
                }
            }
            
            return savedObservations
        } catch let FieldBookError.daoError(message) {
            throw FieldBookError.serviceError(message: message)
        }
    }
}
