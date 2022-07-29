//
//  ExtensionDate.swift
//  NotesApp
//
//  Created by Андрей Сорокин

import UIKit

extension Date {
    var dateToString: String {
        let timeString = formatted(date: .omitted, time: .shortened)
        
        if Locale.current.calendar.isDateInToday(self) {
            let timeFormat = NSLocalizedString("Сегодня в %@", comment: "Время создания сегодня")
            return String(format: timeFormat, timeString)
        } else {
            let dateString = formatted(.dateTime.month(.wide).day())
            let dateAndTimeFormat = NSLocalizedString("%@", comment: "Дата и время создания")
            return String(format: dateAndTimeFormat, dateString)
        }
    }
}
