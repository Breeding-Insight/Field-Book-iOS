//
//  Errors.swift
//  fieldbook-ios
//
//  Created by Tim Parsons on 4/27/22.
//

import Foundation

enum BrAPIError: Error {
    case unknownCallFailure
}

enum FieldBookError: Error {
    case daoError(message: String?)
    case serviceError(message: String?)
    case nameConflictError(message: String?)
}
