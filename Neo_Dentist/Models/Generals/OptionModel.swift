//
//  OptionModel.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 05/01/24.
//

import Foundation

struct SpecializationModel {
    let id: Int
    let name: String
    var isActive: Bool = false
}

struct ExperienceModel {
    let name: String
    var isActive: Bool = false
}

extension SpecializationModel {
    static func mockSpecializationData()->[SpecializationModel] {
        return [
            .init(id: 5, name: "Терапевт"),
            .init(id: 1, name: "Ортодонт"),
            .init(id: 6, name: "Оральный хирург"),
            .init(id: 4, name: "Пародонтолог"),
            .init(id: 7, name: "Эндодонт"),
            .init(id: 2, name: "Детский стоматолог"),
            .init(id: 3, name: "Хирург-имплантолог"),
            .init(id: 8, name: "Протезный стоматолог"),
            .init(id: 9, name: "Косметический стоматолог"),
        ]
    }
}

extension ExperienceModel {
    static func mockExperienceData() -> [ExperienceModel] {
        return [
            .init(name: "От 1 года и выше"),
            .init(name: "От 3 лет и выше"),
            .init(name: "От 5 лет и выше"),
            .init(name: "От 7 лет и выше"),
            .init(name: "От 10 лет и выше")
        ]
    }
}

extension SpecializationModel: Equatable {
    static func ==(lhs: SpecializationModel, rhs: SpecializationModel) -> Bool {
        return lhs.isActive == rhs.isActive
    }
}
