//
//  MainScreenViewState.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 08/02/24.
//

import Foundation

enum MainScreenViewState {
    case initial
    case clinicServicesListView
    case clinicServiceView
    case doctorsListView
    case doctorView
    case selectDateView
    case appointmentDetailsView
}

extension MainScreenViewState: Equatable {
    static func ==(lhs: MainScreenViewState, rhs: MainScreenViewState) -> Bool {
        switch (lhs, rhs) {
        case (.initial, .initial):
            return true
        case (.clinicServicesListView, .clinicServicesListView):
            return true
        case (.clinicServiceView, .clinicServiceView):
            return true
        case (.doctorsListView, .doctorsListView):
            return true
        case (.doctorView, .doctorView):
            return true
        case (.selectDateView, .selectDateView):
            return true
        case (.appointmentDetailsView, .appointmentDetailsView):
            return true
        case
            (.initial, _),
            (.clinicServicesListView, _),
            (.clinicServiceView, _),
            (.doctorsListView, _),
            (.doctorView, _),
            (.selectDateView, _),
            (.appointmentDetailsView, _):
            return false
        }
    }
}
