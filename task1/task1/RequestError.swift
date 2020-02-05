//
//  Constants.swift
//  task1
//
//  Created by Body Block on 06/02/2020.
//  Copyright © 2020 Body Block. All rights reserved.
//

enum RequestError : Error {
    case noInternetConnection
    case notFound
    case unknownError(description: String)
}

