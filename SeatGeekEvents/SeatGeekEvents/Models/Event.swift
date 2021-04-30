//
//  Event.swift
//  SeatGeekEvents
//
//  Created by Lee on 4/29/21.
//
import Foundation



struct Events: Decodable {
    let events: [Event]
}

struct Event: Decodable {
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

struct Performer: Decodable {
    let image: URL
}

struct Venue: Decodable {
    let location: String
    
    enum CodingKeys: String, CodingKey {
        case location = "display_location"
    }
}







/*
struct Events: Decodable {
    let results: [Event]
}

struct Event: Decodable {
    let title: String
   // let shortTitle: String
    let dateAndTime: String
    let venue: Venue
    let performers: [Performer]
    
    enum CodingKeys: String, CodingKey {
        case title, venue, performers
       // case shortTitle = "short_title"
        case dateAndTime = "datetime_local"
    }
}

struct Venue: Decodable {
    let location: String
    enum CodingKeys: String, CodingKey {
        case location = "display_location"
    }
}

struct Performer: Decodable {
    let image: URL
}

 SeatGeekEvents :
 Client ID:    MjE4MTM2NjV8MTYxOTcxNzgxMC4yMTUyMTM1
 Your app secret is "4210ac4ece05bce6fe5dcb11b607230e6e182026c7bdb0a7a3cfce28601bd320" - copy now as it can't be retrieved later.
 
 
 
 Query String
 
 curl https://api.seatgeek.com/2/events?client_id=MYCLIENTID
 curl https://api.seatgeek.com/2/events?client_id=MYCLIENTID&client_secret=MYCLIENTSECRET
 
 
 //FetchEventsBySearchTerm
 https://api.seatgeek.com/2/events?client_id=MjE4MTM2NjV8MTYxOTcxNzgxMC4yMTUyMTM1&q=boston+celtics
 https://api.seatgeek.com/2/events?client_id=MjE4MTM2NjV8MTYxOTcxNzgxMC4yMTUyMTM1&q=football
 
 //FetchEventById
 https://api.seatgeek.com/2/events?client_id=MjE4MTM2NjV8MTYxOTcxNzgxMC4yMTUyMTM1&id=5381863
 
 */
