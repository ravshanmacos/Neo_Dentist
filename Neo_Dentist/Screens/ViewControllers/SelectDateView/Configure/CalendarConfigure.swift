//
//  CalendarConfigure.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 31/12/23.
//

import Foundation

enum WeekDayName {
    case mon, tue, wed, thu, fri
}

class CalendarConfigure {
    static let shared = CalendarConfigure()
    private let calendar = Calendar(identifier: .gregorian)
    private let dateFormatter = DateFormatter()
    
    func getYear(date: Date = Date()) -> Int? {
        dateFormatter.dateFormat = "YYYY"
        let yearString = dateFormatter.string(from: date)
        return Int(yearString)
    }
    
    func getMonth(date: Date = Date()) -> Int? {
        dateFormatter.dateFormat = "MM"
        let yearString = dateFormatter.string(from: date)
        return Int(yearString)
    }
    
    func getDateFormattedString(_ date: Date = Date()) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL yyyy"
        return dateFormatter.string(from: date)
    }
    
    func getDateFormattedStringForTimeSlot(_ date: Date = Date()) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LL.YYYY"
        return dateFormatter.string(from: date)
    }
    
    func getWeekdaySymbols() -> [String] {
        var monToSun = calendar.shortWeekdaySymbols
        let firstElement = monToSun.removeFirst()
        monToSun.append(firstElement)
        return monToSun
    }
    
    func getWeekendDays() -> [Int] {
        let days = [5, 6, 12,  13, 19, 20, 26, 27, 33, 34]
        return days
    }
    
    func getOffDay(for weekdayName: WeekDayName) -> [Int] {
        switch weekdayName {
        case .mon: return [0, 7,  14, 21, 28]
        case .tue: return [1, 8,  15, 22, 29]
        case .wed: return [2, 9,  16, 23, 30]
        case .thu: return [3, 10, 17, 24, 31]
        case .fri: return [4, 11, 18, 25, 32]
            
        }
    }
    
    func isOffDayIncludes(currentDay: Int, weekdayName: WeekDayName) -> Bool {
        var result = false
        for day in getOffDay(for: weekdayName) {
            if currentDay == day {
                result = true
                break
            }
        }
        return result
    }
    
    func isTodayOFFDay(daySymbols: [String], currentDay: Int) -> Bool {
        var result = false
        for daySymbol in daySymbols {
            if daySymbol == "Пн" {
                if isOffDayIncludes(currentDay: currentDay, weekdayName: .mon) {
                    result = true
                    break
                }
            } else if daySymbol == "Вт"{
                if isOffDayIncludes(currentDay: currentDay, weekdayName: .tue) {
                    result = true
                    break
                }
            } else if daySymbol == "Ср"{
                if isOffDayIncludes(currentDay: currentDay, weekdayName: .wed) {
                    result = true
                    break
                }
            } else if daySymbol == "Чт"{
                if isOffDayIncludes(currentDay: currentDay, weekdayName: .thu) {
                    result = true
                    break
                }
            } else if daySymbol == "Пт"{
                if isOffDayIncludes(currentDay: currentDay, weekdayName: .fri) {
                    result = true
                    break
                }
            }
        }
        return result
    }
    
    func getMonthName(date: Date = Date()) -> String {
        dateFormatter.dateFormat = "LLL"
        return dateFormatter.string(from: date)
    }
    
    func getYearName(date: Date) -> String {
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: date)
    }
    
    func getDayOfMonth(date: Date = Date()) -> Int {
        let components = calendar.dateComponents([.day], from: date)
        return components.day!
    }
    
    func getDaysOfCurrentMonth(date: Date = Date()) -> Int {
        let range = calendar.range(of: .day, in: .month, for: date)
        return range!.count
    }
    
    func getDaysOfPreviousMonth() -> Int {
        let lastMonth = changeToPreviousMonth()
        let range = calendar.range(of: .day, in: .month, for: lastMonth)
        return range!.count
    }
    
    func getFirstDayOfMonth(date: Date = Date()) -> Int{
        let components = calendar.dateComponents([.year, .month], from: date)
        let day = calendar.date(from: components)
        return getWeekday(date: day!)
    }
    
    func getWeekday(date: Date = Date())->Int{
        let components = calendar.dateComponents([.weekday], from: date)
        return components.weekday!-1
    }
    
    func changeToNextMonth(date: Date = Date())->Date{
        return calendar.date(byAdding: .month, value: 1, to: date)!
    }
    
    func changeToPreviousMonth(date: Date = Date())->Date{
        return calendar.date(byAdding: .month, value: -1, to: date)!
    }
    
}

//MARK: Encoding and Deconding
enum DecodingStyle {
    case normal
    case original
}
extension CalendarConfigure {
    func decodeAppointmentTimeSlot(dateString: String, style: DecodingStyle = .normal) -> String? {
        switch style {
        case .normal:
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        case .original:
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        }
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        if let date = dateFormatter.date(from: dateString) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "dd.MM.yyyy, HH:mm"
            return outputFormatter.string(from: date)
        } else {
            return nil
        }
    }
    
    func encodeAppointmentTimeSlot(year: Int?, month: Int?, day: Int?, timeString: String) -> String? {
        let timeSlot = timeString.extractHourAndMinutes()
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        dateComponents.hour = timeSlot.hour
        dateComponents.minute = timeSlot.minute
        var encodedDate: String?
        if let date = calendar.date(from: dateComponents) {
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
            encodedDate = dateFormatter.string(from: date)
        }
        return encodedDate
    }
}
