//
//  ObservationVariableDAO.swift
//  fieldbook-ios
//
//  Created by Tim Parsons on 4/25/22.
//

import Foundation
import SQLite

class ObservationUnitDAO {
    private let database: Database
    
    init(database: Database) {
        self.database = database
    }
    
    func saveObservationUnit(_ unit: ObservationUnit) throws -> ObservationUnit? {
        if(unit.studyId == nil) {
            throw FieldBookError.daoError(message: "Missing studyId")
        }
        
        let insert = ObservationUnitsTable.TABLE.upsert(
            ObservationUnitsTable.INTERNAL_ID_OBSERVATION_UNIT <- unit.internalId,
            ObservationUnitsTable.STUDY_ID <- unit.studyId,
            ObservationUnitsTable.OBSERVATION_UNIT_DB_ID <- unit.observationunitDbId,
            ObservationUnitsTable.PRIMARY_ID <- unit.primaryId,
            ObservationUnitsTable.SECONDARY_ID <- unit.secondaryId,
            ObservationUnitsTable.GEO_COORDINATES <- unit.geoCoordinates,
            ObservationUnitsTable.ADDITIONAL_INFO <- unit.additionalInfo,
            ObservationUnitsTable.GERMPLASM_DB_ID <- unit.germplasmDbId,
            ObservationUnitsTable.GERMPLASM_NAME <- unit.germplasmDbId,
            ObservationUnitsTable.OBSERVATION_LEVEL <- unit.observationLevel,
            ObservationUnitsTable.POSITION_COORDINATE_X <- unit.positionCoordinateX,
            ObservationUnitsTable.POSITION_COORDINATE_X_TYPE <- unit.positionCoordinateXType,
            ObservationUnitsTable.POSITION_COORDINATE_Y <- unit.positionCoordinateY,
            ObservationUnitsTable.POSITION_COORDINATE_Y_TYPE <- unit.positionCoordinateYType, onConflictOf: ObservationUnitsTable.INTERNAL_ID_OBSERVATION_UNIT)
        
        do {
            let unitId = try database.db.run(insert)
            
            if (unitId > -1) {
                try saveAttributes(unitId: unitId, studyId: unit.studyId!, attributes: unit.attributes)
            }
            
            return try getObservationUnit(unitId)
        } catch let Result.error(message, code, statement) {
            throw FieldBookError.daoError(message: "failure saving observationUnit -> code: \(code), error: \(message), in \(String(describing: statement))")
        }
    }
    
    func getObservationUnit(_ internalId: Int64) throws -> ObservationUnit? {
        do {
            if let record = try database.db.pluck(ObservationUnitsTable.TABLE.filter(ObservationUnitsTable.INTERNAL_ID_OBSERVATION_UNIT == internalId)) {
                let unit = populateRecord(record)
                try unit.attributes = fetchAttributes(internalId)
                return unit
            }
        } catch let Result.error(message, code, statement) {
            throw FieldBookError.daoError(message: "failure getting observationUnit -> code: \(code), error: \(message), in \(String(describing: statement))")
        }
        
        return nil
    }
    
    func getObservationUnits(studyId: Int64) throws -> [ObservationUnit] {
        var ret: [ObservationUnit] = []
        do {
            for record in try database.db.prepare(ObservationUnitsTable.TABLE.filter(ObservationUnitsTable.STUDY_ID == studyId)) {
                let unit = populateRecord(record)
                try unit.attributes = fetchAttributes(unit.internalId!)
                ret.append(unit)
            }
        } catch let Result.error(message, code, statement) {
            throw FieldBookError.daoError(message: "failure saving observationUnits -> code: \(code), error: \(message), in \(String(describing: statement))")
        }
        
        return ret
    }
    
    func deleteObservationUnits(unitIds: [Int64]? = nil, studyId: Int64? = nil) throws -> Int {
        var removed = 0
        do {
            if(studyId == nil && unitIds != nil) {
                removed = try database.db.run(ObservationUnitsTable.TABLE.filter(unitIds!.contains(ObservationUnitsTable.INTERNAL_ID_OBSERVATION_UNIT)).delete())
            } else if(studyId != nil) {
                removed = try database.db.run(ObservationUnitsTable.TABLE.filter(ObservationUnitsTable.STUDY_ID == studyId!).delete())
            } else {
                throw FieldBookError.daoError(message: "Must supply either unitIds or studyId")
            }
        } catch let Result.error(message, code, statement) {
            throw FieldBookError.daoError(message: "failure deleting observationUnit -> code: \(code), error: \(message), in \(String(describing: statement))")
        }
        
        return removed
    }
    
    private func populateRecord(_ record:Row) -> ObservationUnit {
        let unit = ObservationUnit()
        unit.studyId = record[ObservationUnitsTable.STUDY_ID]
        unit.primaryId = record[ObservationUnitsTable.PRIMARY_ID]
        unit.secondaryId = record[ObservationUnitsTable.SECONDARY_ID]
        unit.observationLevel = record[ObservationUnitsTable.OBSERVATION_LEVEL]
        unit.internalId = record[ObservationUnitsTable.INTERNAL_ID_OBSERVATION_UNIT]
        unit.observationunitDbId = record[ObservationUnitsTable.OBSERVATION_UNIT_DB_ID]
        unit.geoCoordinates = record[ObservationUnitsTable.GEO_COORDINATES]
        unit.additionalInfo = record[ObservationUnitsTable.ADDITIONAL_INFO]
        unit.germplasmDbId = record[ObservationUnitsTable.GERMPLASM_DB_ID]
        unit.germplasmDbId = record[ObservationUnitsTable.GERMPLASM_NAME]
        unit.positionCoordinateX = record[ObservationUnitsTable.POSITION_COORDINATE_X]
        unit.positionCoordinateXType = record[ObservationUnitsTable.POSITION_COORDINATE_X_TYPE]
        unit.positionCoordinateY = record[ObservationUnitsTable.POSITION_COORDINATE_Y]
        unit.positionCoordinateYType = record[ObservationUnitsTable.POSITION_COORDINATE_Y_TYPE]
        unit.attributes = [:]
        
        return unit
    }
    
    private func saveAttributes(unitId: Int64, studyId: Int64, attributes: [ObservationUnitAttribute:ObservationUnitAttributeValue]?) throws {
        try database.db.run(ObservationUnitValuesTable.TABLE.filter(ObservationUnitValuesTable.OBSERVATION_UNIT_ID == unitId).delete())
        
        if(!(attributes?.isEmpty ?? false)) {
            try attributes?.forEach{ (key: ObservationUnitAttribute, value: ObservationUnitAttributeValue) in
                var attrId: Int64 = -1
                if let attrRecord = try database.db.pluck(ObservationUnitAttributesTable.TABLE.filter(ObservationUnitAttributesTable.OBSERVATION_UNIT_ATTRIBUTE_NAME == key.attributeName)) {
                    attrId = attrRecord[ObservationUnitAttributesTable.INTERNAL_ID_OBSERVATION_UNIT_ATTRIBUTE]
                } else {
                    attrId = try database.db.run(ObservationUnitAttributesTable.TABLE.insert(ObservationUnitAttributesTable.OBSERVATION_UNIT_ATTRIBUTE_NAME <- key.attributeName))
                }
                
                try database.db.run(ObservationUnitValuesTable.TABLE.insert(ObservationUnitValuesTable.OBSERVATION_UNIT_ID <- unitId, ObservationUnitValuesTable.OBSERVATION_UNIT_ATTRIBUTE_DB_ID <- attrId, ObservationUnitValuesTable.OBSERVATION_UNIT_VALUE_NAME <- value.value, ObservationUnitValuesTable.STUDY_ID <- studyId))
            }
        }
    }
    
    private func fetchAttributes(_ unitId: Int64) throws -> [ObservationUnitAttribute:ObservationUnitAttributeValue] {
        var ret: [ObservationUnitAttribute:ObservationUnitAttributeValue] = [:]
        
        for record in try database.db.prepare(ObservationUnitAttributesTable.TABLE.join(ObservationUnitValuesTable.TABLE, on: ObservationUnitValuesTable.OBSERVATION_UNIT_ATTRIBUTE_DB_ID == ObservationUnitAttributesTable.INTERNAL_ID_OBSERVATION_UNIT_ATTRIBUTE).filter(ObservationUnitValuesTable.OBSERVATION_UNIT_ID == unitId)) {
            
            let attribute = ObservationUnitAttribute(attributeName: record[ObservationUnitAttributesTable.OBSERVATION_UNIT_ATTRIBUTE_NAME], studyId: record[ObservationUnitAttributesTable.STUDY_ID])
            attribute.internalId = record[ObservationUnitAttributesTable.INTERNAL_ID_OBSERVATION_UNIT_ATTRIBUTE]
            
            let value = ObservationUnitAttributeValue(value: record[ObservationUnitValuesTable.OBSERVATION_UNIT_VALUE_NAME], studyId: record[ObservationUnitValuesTable.STUDY_ID])
            value.internalId = record[ObservationUnitValuesTable.INTERNAL_ID_OBSERVATION_UNIT_VALUE]
            value.observationUnitId = record[ObservationUnitValuesTable.OBSERVATION_UNIT_ID]
            value.attributeId = attribute.internalId
            
            ret[attribute] = value
        }
        
        return ret
    }
}
