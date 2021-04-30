//
//  Event.swift
//  SeatGeekEvents
//
//  Created by Lee on 4/29/21.
//
import Foundation

struct Events: Codable {
    let events: [Event]
}

struct Event: Codable {
    let title: String
    let shortTitle: String
    let date: String
    let venue: Venue
    let performers: [Performer]
    
    enum CodingKeys: String, CodingKey {
        case title, performers, venue
        case shortTitle = "short_title"
        case date = "datetime_local"
    }
}

struct Performer: Codable {
    let image: URL
}

struct Venue: Codable {
    let location: String
    
    enum CodingKeys: String, CodingKey {
        case location = "display_location"
    }
}

extension Event: Equatable {
    static func == (lhs: Event, rhs: Event) -> Bool {
        lhs.title == rhs.title && lhs.shortTitle == rhs.shortTitle && lhs.date == rhs.date 
    }
}
