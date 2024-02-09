//
//  InputFieldErrors.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 25/12/23.
//

import Foundation

enum InputFieldErrors: String, Error {
    case invalidEmail = "Неверный электронной почты"
    case invalidPassword = "Пароль меньше 8 символов"
    case passwordsDidNotMatch  = "Пароли не совпали"
}
