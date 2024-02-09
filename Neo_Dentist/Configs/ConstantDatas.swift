//
//  ConstantDatas.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 25/12/23.
//

import UIKit

struct ClinicService {
    let image: UIImage?
    let title: String
}
struct PhoneCode {
    let id: String
    let code: String
    let image: UIImage?
    let formatType: String
    let textPlaceHolder: String
    
    static func getPhoneByID(id: String?) -> PhoneCode? {
        guard let id else { return nil }
        var phoneCode: PhoneCode?
        ConstantDatas.countryPhoneCodes.forEach { value in
            if id == value.id {
                phoneCode = value
            }
        }
        return phoneCode
    }
}

struct ConstantDatas {
    static let countryPhoneCodes: [PhoneCode] = [
        .init(id: UUID().uuidString,
              code: "+998",
              image: R.image.uZ(),
              formatType: "## ### ## ##",
              textPlaceHolder: "-- --- -- --"),
        .init(id: UUID().uuidString,
              code: "+996",
              image: R.image.kG(),
              formatType: "### ### ###",
              textPlaceHolder: "--- --- ---"),
        .init(id: UUID().uuidString,
              code: "+7",
              image: R.image.kZ(),
              formatType: "### ### ####",
              textPlaceHolder: "--- --- ----"),
        .init(id: UUID().uuidString,
              code: "+7",
              image: R.image.rU(),
              formatType: "### ### ####",
              textPlaceHolder: "--- --- ----")
    ]
    
    static let defaultAppointmentDetailsData: [AppointmentInfo] = [
        .init(title: "Доктор", description: "Выберите врача"),
        .init(title: "Услуга", description: "Выберите услугу"),
        .init(title: "Дата и время", description: "Выберите дату и время")
    ]
    
    static let clinicServicesData: [ClinicService] = [
        .init(image: R.image.thooth_icon_1(), title: "Пломбирование \nзубов"),
        .init(image: R.image.thooth_icon_2(), title: "Чистка зубов"),
        .init(image: R.image.thooth_icon_3(), title: "Установка \nкоронок и мостов"),
        .init(image: R.image.thooth_icon_4(), title: "Имплантация \nзубов"),
        .init(image: R.image.thooth_icon_5(), title: "Лечение \nкорневых каналов"),
        .init(image: R.image.thooth_icon_6(), title: "Отбеливание \nзубов"),
    ]
    
    static let clinicServicesDataFull: [ClinicService] = [
        .init(image: R.image.thooth_icon_1(), title: "Пломбирование \nзубов"),
        .init(image: R.image.thooth_icon_2(), title: "Чистка зубов"),
        .init(image: R.image.thooth_icon_3(), title: "Установка \nкоронок и мостов"),
        .init(image: R.image.thooth_icon_4(), title: "Имплантация \nзубов"),
        .init(image: R.image.thooth_icon_5(), title: "Лечение \nкорневых каналов"),
        .init(image: R.image.thooth_icon_6(), title: "Отбеливание \nзубов"),
        .init(image: R.image.thooth_icon_7(), title: "Установка \nбрекет-систем"),
        .init(image: R.image.thooth_icon_8(), title: "Детская \nстоматология"),
        .init(image: R.image.thooth_icon_9(), title: "Профилактический \nосмотр"),
        .init(image: R.image.thooth_icon_10(), title: "Удаление \nбольных зубов"),
        .init(image: R.image.thooth_icon_11(), title: "Пародонтология"),
        .init(image: R.image.thooth_icon_12(), title: "Протезирование"),
        .init(image: R.image.thooth_icon_13(), title: "Лечение \nкариеса"),
        .init(image: R.image.thooth_icon_14(), title: "Установка \nвиниров"),
        .init(image: R.image.thooth_icon_15(), title: "Пластика десен"),
    ]
}

enum Images {
    enum TabBar{
        static func normalImage(for tab: Tabs) -> UIImage?{
            switch tab {
            case .firstTab: return UIImage(named: "tab1_unselected")
            case .secondTab: return UIImage(named: "tab2_unselected")
            case .thirdTab: return UIImage(named: "tab3_unselected")
            case .fourthTab: return UIImage(named: "tab4_unselected")
            }
        }
        
        static func selectedImage(for tab: Tabs) -> UIImage?{
            switch tab {
            case .firstTab: return UIImage(named: "tab1_selected")
            case .secondTab: return UIImage(named: "tab2_selected")
            case .thirdTab: return UIImage(named: "tab3_selected")
            case .fourthTab: return UIImage(named: "tab4_selected")
            }
        }
    }
}

