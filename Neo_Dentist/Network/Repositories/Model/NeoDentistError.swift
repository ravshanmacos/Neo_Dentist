//
//  NeoDentistError.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 03/02/24.
//

import Foundation

enum NeoDentistError: Error {
    case failedToSignIn
    case failedToGetServices
    case failedToGetService
    case failedToGetDoctors
    case failedToGetDoctor
}
