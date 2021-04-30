//
//  ExtensionHelper.swift
//  SeatGeekEvents
//
//  Created by Lee on 4/29/21.
//

import Foundation

extension String {
    func stringDateToDate() -> Date {
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
        case time = "HH:mm a"
    }
    
    func dateToString(format: DateFormatType) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        return formatter.string(from: self)
    }
}
