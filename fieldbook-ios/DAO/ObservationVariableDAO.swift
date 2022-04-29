//
//  ObservationVariableDAO.swift
//  fieldbook-ios
//
//  Created by Tim Parsons on 4/25/22.
//

import Foundation
import SQLite

class ObservationVariableDAO {
    private let database: Database
    
    init(database: Database) {
        self.database = database
    }
    
    func saveObservationVariable(_ variable: ObservationVariable) throws -> ObservationVariable? {
        let savedObservationVariable = try self.getObservationVariableByName(variable.name)
        if (savedObservationVariable != nil && savedObservationVariable?.internalId != variable.internalId) {
            throw FieldBookError.nameConflictError(message: "Trait with name \"\(variable.name)\" already exists")
        } else {
            let insert = ObservationVariablesTable.TABLE.upsert(
                ObservationVariablesTable.INTERNAL_ID_OBSERVATION_VARIABLE <- variable.internalId,
                ObservationVariablesTable.OBSERVATION_VARIABLE_NAME <- variable.name,
                ObservationVariablesTable.OBSERVATION_VARIABLE_FIELD_BOOK_FORMAT <- variable.fieldBookFormat?.get(),
                ObservationVariablesTable.DEFAULT_VALUE <- variable.defaultValue,
                ObservationVariablesTable.VISIBLE <- variable.visible,
                ObservationVariablesTable.POSITION <- variable.position,
                ObservationVariablesTable.EXTERNAL_DB_ID <- variable.externalDbId,
                ObservationVariablesTable.TRAIT_DATA_SOURCE <- variable.traitDataSource,
                ObservationVariablesTable.ADDITIONAL_INFO <- variable.additionalInfo?.toJsonString(),
                ObservationVariablesTable.COMMON_CROP_NAME <- variable.commonCropName,
                ObservationVariablesTable.LANGUAGE <- variable.language,
                ObservationVariablesTable.DATA_TYPE <- variable.dataType,
                ObservationVariablesTable.OBSERVATION_VARIABLE_DB_ID <- variable.observationVariableDbId,
                ObservationVariablesTable.ONTOLOGY_DB_ID <- variable.ontologyDbId,
                ObservationVariablesTable.ONTOLOGY_NAME <- variable.ontologyName,
                ObservationVariablesTable.OBSERVATION_VARIABLE_DETAILS <- variable.details, onConflictOf: ObservationVariablesTable.INTERNAL_ID_OBSERVATION_VARIABLE)
            
            do {
                let variableId = try database.db.run(insert)
                
                if (variableId > -1) {
                    try saveAttributes(variableId, variable.attributes)
                }
                
                return try getObservationVariable(variableId)
            } catch let Result.error(message, code, statement) {
                throw FieldBookError.daoError(message: "failure saving observationVariable -> code: \(code), error: \(message), in \(String(describing: statement))")
            }
        }
    }
    
    func getObservationVariable(_ internalId: Int64) throws -> ObservationVariable? {
        do {
            if let record = try database.db.pluck(ObservationVariablesTable.TABLE.filter(ObservationVariablesTable.INTERNAL_ID_OBSERVATION_VARIABLE == internalId)) {
                let variable = populateRecord(record)
                try variable.attributes = fetchAttributes(internalId)
                return variable
            }
        } catch let Result.error(message, code, statement) {
            throw FieldBookError.daoError(message: "failure getting observationVariable -> code: \(code), error: \(message), in \(String(describing: statement))")
        }
        
        return nil
    }
    
    func getObservationVariableByName(_ name: String) throws -> ObservationVariable? {
        do {
            if let record = try database.db.pluck(ObservationVariablesTable.TABLE.filter(ObservationVariablesTable.OBSERVATION_VARIABLE_NAME == name)) {
                let variable = populateRecord(record)
                try variable.attributes = fetchAttributes(variable.internalId!)
                return variable
            }
        } catch let Result.error(message, code, statement) {
            throw FieldBookError.daoError(message: "failure getting observationVariable -> code: \(code), error: \(message), in \(String(describing: statement))")
        }
        
        return nil
    }
    
    func getObservationVariables() throws -> [ObservationVariable] {
        var ret: [ObservationVariable] = []
        do {
            for record in try database.db.prepare(ObservationVariablesTable.TABLE) {
                let variable = populateRecord(record)
                try variable.attributes = fetchAttributes(variable.internalId!)
                ret.append(variable)
            }
        } catch let Result.error(message, code, statement) {
            throw FieldBookError.daoError(message: "failure getting observationVariables -> code: \(code), error: \(message), in \(String(describing: statement))")
        }
        
        return ret
    }
    
    func deleteObservationVariables(_ variableIds: [Int64]) throws -> Int {
        do {
            _ = try database.db.run(ObservationVariableValuesTable.TABLE.filter(variableIds.contains(ObservationVariableValuesTable.OBSERVATION_VARIABLE_DB_ID)).delete())
            return try database.db.run(ObservationVariablesTable.TABLE.filter(variableIds.contains(ObservationVariablesTable.INTERNAL_ID_OBSERVATION_VARIABLE)).delete())
        } catch let Result.error(message, code, statement) {
            throw FieldBookError.daoError(message: "failure deleting observationVariables -> code: \(code), error: \(message), in \(String(describing: statement))")
        }
    }
    
    private func populateRecord(_ record:Row) -> ObservationVariable {
        let variable = ObservationVariable(
            name: record[ObservationVariablesTable.OBSERVATION_VARIABLE_NAME],
            dataType: record[ObservationVariablesTable.DATA_TYPE])
        variable.internalId = record[ObservationVariablesTable.INTERNAL_ID_OBSERVATION_VARIABLE]
        variable.fieldBookFormat = TraitFormat.from(record[ObservationVariablesTable.OBSERVATION_VARIABLE_FIELD_BOOK_FORMAT])
        variable.defaultValue = record[ObservationVariablesTable.DEFAULT_VALUE]
        variable.visible = record[ObservationVariablesTable.VISIBLE]
        variable.position = record[ObservationVariablesTable.POSITION]
        variable.externalDbId = record[ObservationVariablesTable.EXTERNAL_DB_ID]
        variable.traitDataSource = record[ObservationVariablesTable.TRAIT_DATA_SOURCE]
        variable.additionalInfo = Utilities.convertToDictionary(record[ObservationVariablesTable.ADDITIONAL_INFO])
        variable.commonCropName = record[ObservationVariablesTable.COMMON_CROP_NAME]
        variable.language = record[ObservationVariablesTable.LANGUAGE]
        variable.observationVariableDbId = record[ObservationVariablesTable.OBSERVATION_VARIABLE_DB_ID]
        variable.ontologyDbId = record[ObservationVariablesTable.ONTOLOGY_DB_ID]
        variable.ontologyName = record[ObservationVariablesTable.ONTOLOGY_NAME]
        variable.details = record[ObservationVariablesTable.OBSERVATION_VARIABLE_DETAILS]
        variable.attributes = [:]
        
        return variable
    }
    
    private func saveAttributes(_ variableId: Int64, _ attributes: [ObservationVariableAttribute:ObservationVariableAttributeValue]?) throws {
        try database.db.run(ObservationVariableValuesTable.TABLE.filter(ObservationVariableValuesTable.OBSERVATION_VARIABLE_DB_ID == variableId).delete())
        
        if(!(attributes?.isEmpty ?? false)) {
            try attributes?.forEach{ (key: ObservationVariableAttribute, value: ObservationVariableAttributeValue) in
                var attrId: Int64 = -1
                if let attrRecord = try database.db.pluck(ObservationVariableAttributesTable.TABLE.filter(ObservationVariableAttributesTable.OBSERVATION_VARIABLE_ATTRIBUTE_NAME == key.attributeName)) {
                    attrId = attrRecord[ObservationVariableAttributesTable.INTERNAL_ID_OBSERVATION_VARIABLE_ATTRIBUTE]
                } else {
                    attrId = try database.db.run(ObservationVariableAttributesTable.TABLE.insert(ObservationVariableAttributesTable.OBSERVATION_VARIABLE_ATTRIBUTE_NAME <- key.attributeName))
                }
                
                try database.db.run(ObservationVariableValuesTable.TABLE.insert(ObservationVariableValuesTable.OBSERVATION_VARIABLE_DB_ID <- variableId, ObservationVariableValuesTable.OBSERVATION_VARIABLE_ATTRIBUTE_DB_ID <- attrId, ObservationVariableValuesTable.OBSERVATION_VARIABLE_ATTRIBUTE_VALUE <- value.value))
            }
        }
    }
    
    private func fetchAttributes(_ variableId: Int64) throws -> [ObservationVariableAttribute:ObservationVariableAttributeValue] {
        var ret: [ObservationVariableAttribute:ObservationVariableAttributeValue] = [:]
        
        for record in try database.db.prepare(ObservationVariableAttributesTable.TABLE.join(ObservationVariableValuesTable.TABLE, on: ObservationVariableValuesTable.OBSERVATION_VARIABLE_ATTRIBUTE_DB_ID == ObservationVariableAttributesTable.INTERNAL_ID_OBSERVATION_VARIABLE_ATTRIBUTE).filter(ObservationVariableValuesTable.OBSERVATION_VARIABLE_DB_ID == variableId)) {
            
            let attribute = ObservationVariableAttribute(attributeName: record[ObservationVariableAttributesTable.OBSERVATION_VARIABLE_ATTRIBUTE_NAME])
            attribute.internalId = record[ObservationVariableAttributesTable.INTERNAL_ID_OBSERVATION_VARIABLE_ATTRIBUTE]
            
            let value = ObservationVariableAttributeValue(value: record[ObservationVariableValuesTable.OBSERVATION_VARIABLE_ATTRIBUTE_VALUE])
            value.internalId = record[ObservationVariableValuesTable.INTERNAL_ID_OBSERVATION_VARIABLE_VALUE]
            value.observationVariableId = record[ObservationVariableValuesTable.OBSERVATION_VARIABLE_DB_ID]
            value.attributeId = attribute.internalId
            
            ret[attribute] = value
        }
        
        return ret
    }
}
