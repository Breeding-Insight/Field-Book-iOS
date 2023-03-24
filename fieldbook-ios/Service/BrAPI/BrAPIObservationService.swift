//
//  BrAPIObservationService.swift
//  fieldbook-ios
//
//  Created by Tim Parsons on 4/25/22.
//

import Foundation
import os

class BrAPIObservationService {
    private let logger = Logger(subsystem: "org.phenoapps.fieldbook", category: "BrAPIObservationVariableService")
    
    private let FIELD_BOOK_REFERENCE_SOURCE = "Field Book Upload"
    
    private let studyDAO: StudyDAO
    private let variableDAO: ObservationVariableDAO
    private let observationUnitDAO: ObservationUnitDAO
    private let observationDAO: ObservationDAO
    
    init(studyDAO: StudyDAO, variableDAO: ObservationVariableDAO, observationUnitDAO: ObservationUnitDAO, observationDAO: ObservationDAO) {
        self.studyDAO = studyDAO
        self.variableDAO = variableDAO
        self.observationUnitDAO = observationUnitDAO
        self.observationDAO = observationDAO
    }
    
    
    public func exportObservation(_ observation: Observation) async throws -> Observation? {
        do {
            let study = try studyDAO.getStudy(observation.studyId!)
            let variable = try variableDAO.getObservationVariable(observation.observationVariableId!)
            let obsUnit = try observationUnitDAO.getObservationUnit(observation.observationUnitId!)
            
            var brapiObservation = BrAPIObservation()
            
            var xref = BrAPIExternalReferencesInner()
            xref.referenceID = "\(observation.internalId!)"
            xref.referenceSource = FIELD_BOOK_REFERENCE_SOURCE
            brapiObservation.externalReferences = [xref]
            
            brapiObservation.collector = observation.collector
            brapiObservation.observationTimeStamp = observation.observationTimeStamp
            brapiObservation.observationUnitDbId = obsUnit?.observationunitDbId
            brapiObservation.studyDbId = study?.studyDbId
            brapiObservation.observationVariableDbId = variable?.observationVariableDbId
            brapiObservation.value = observation.value
            
            let brapiClient = InjectionProvider.getBrAPIClient()
            let brapiObservationsAPI = ObservationsAPI(brAPIClientAPI: brapiClient)
            
            if(observation.observationDbId != nil) {
                brapiObservation.observationDbId = observation.observationDbId!
                
                let (data, error) = await withCheckedContinuation { continuation in
                    brapiObservationsAPI.observationsPut(body: [observation.observationDbId!: brapiObservation]) { data, error in
                        continuation.resume(returning: (data, error))
                    }
                }
                
                let errorMsg = self.validResponse(data: data, error: error, observation: observation)
                if errorMsg != nil {
                    throw FieldBookError.serviceError(message: errorMsg)
                }
            } else {
                let (data, error) = await withCheckedContinuation { continuation in
                    brapiObservationsAPI.observationsPost(body: [brapiObservation]) { data, error in
                        continuation.resume(returning: (data, error))
                    }
                }
                
                let errorMsg = self.validResponse(data: data, error: error, observation: observation)
                if errorMsg != nil {
                    throw FieldBookError.serviceError(message: errorMsg)
                } else {
                    observation.observationDbId = data!.result.data[0].observationDbId
                }
            }
            
            _ = try observationDAO.saveObservation(observation)
            
            return observation
        } catch {
            logger.error("Error exporting observations: \(error.localizedDescription)")
            throw FieldBookError.serviceError(message: error.localizedDescription)
        }
        
    }
    
    private func validResponse(data: BrAPIObservationListResponse?, error: Error?, observation: Observation) -> String? {
        if(error == nil) {
//            if data != nil && data!.result.data[0].externalReferences != nil {
//                let updatedObs = data!.result.data[0]
//                var hasXref = false
//                for xref in updatedObs.externalReferences! {
//                    if xref.referenceSource == FIELD_BOOK_REFERENCE_SOURCE && xref.referenceID! == "\(observation.internalId!)" {
//                        hasXref = true
//                        break
//                    }
//                }
//
//                if !hasXref {
//                    return "BrAPI Error: saved observation does not have matching xref, cannot validate save was successful"
//                }
//            } else {
            if data == nil || data!.result.data.count != 1 {
                return "BrAPI Error: saved observation was not returned.  Cannot validate save was successful"
            }
        } else {
            logger.error("error saving BrAPIObservation: \(String(describing: error))")
            return (String(describing: error))
        }
        
        return nil
    }
}
