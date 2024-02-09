//
//  MainScreenViewState.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 08/02/24.
//

import Foundation

enum MainScreenViewState {
    case clinicServicesListView
    case clinicServiceView(serviceID: Int)
    case doctorsListView
    case doctorView(doctorID: Int)
    case selectDateView
    case appointmentDetailsView
}

extension MainScreenViewState: Equatable {
    static func ==(lhs: MainScreenViewState, rhs: MainScreenViewState) -> Bool {
        switch (lhs, rhs) {
        case (.clinicServicesListView, .clinicServicesListView):
            return true
        case let (.clinicServiceView(l), .clinicServiceView(r)):
            return l == r
        case (.doctorsListView, .doctorsListView):
            return true
        case let (.doctorView(l), .doctorView(r)):
            return l == r
        case (.selectDateView, .selectDateView):
            return true
        case (.appointmentDetailsView, .appointmentDetailsView):
            return true
        case (.clinicServicesListView, _),
            (.clinicServiceView, _),
            (.doctorsListView, _),
            (.doctorView, _),
            (.selectDateView, _),
            (.appointmentDetailsView, _):
            return false
        }
    }
}
