//
//  ExtensionHelper.swift
//  SeatGeekEvents
//
//  Created by Lee on 4/29/21.
//

import Foundation

extension String {
    func stringDateToDate() -> Date {
       // let isoDate = "2016-04-14T10:44:00+0000
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        guard let date = dateFormatter.date(from: self) else {return Date()}
        return date
    }
}

extension Date {
        enum DateFormatType: String {
            case dateWithDay = "EEEE, d MMM yyyy"
            case fullWithTime = "EEEE, d MMM yyyy 'at' HH:mm a"
            case fullNumeric = "MM/dd/yyyy"
            case fullNumericTimestamp = "yyyy-MM-dd HH:mm"
            case monthDayTimestamp = "MMM d, h:mm a"
            case monthYear = "MMMM yyyy"
            case monthDayYear = "MMM d, yyyy"
            case fullWithTimezone = "E, d MMM yyyy HH:mm:ss Z"
            case fullNumericWithTimezone = "yyyy-MM-dd'T'HH:mm:ssZ"
            case short = "dd.MM.yy"
            case timestamp = "HH:mm:ss.SSS"
            case time = "HH:mm a"
        }
        
        func dateToString(format: DateFormatType) -> String{
            let formatter = DateFormatter()
            formatter.dateFormat = format.rawValue
            return formatter.string(from: self)
        }
}
