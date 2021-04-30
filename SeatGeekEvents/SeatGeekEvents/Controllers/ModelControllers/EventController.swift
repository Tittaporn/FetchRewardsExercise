//
//  EventController.swift
//  SeatGeekEvents
//
//  Created by Lee on 4/29/21.
//

import UIKit

class EventController {
    
    // MARK: - URL Properties
    static let baseURL = URL(string: "https://api.seatgeek.com/2")
    static let eventsConponent = "events"
    static let clientId = "client_id"
    static let clientIdValue = "MjE4MTM2NjV8MTYxOTcxNzgxMC4yMTUyMTM1"
    static let searchEventKey = "q"
    
    // MARK: - FetchEvents
    static func fetchEvents(searchTerm: String, completion: @escaping (Result<[Event],EventError>) -> Void) {
        guard let baseURL = baseURL else {return completion(.failure(.invalidURL))}
        let eventsURL = baseURL.appendingPathComponent(eventsConponent)
        var components = URLComponents(url: eventsURL, resolvingAgainstBaseURL: true)
        let clientQuery = URLQueryItem(name: clientId, value: clientIdValue)
        let searchEventQuery = URLQueryItem(name: searchEventKey, value: searchTerm)
        components?.queryItems = [clientQuery,searchEventQuery]
        
        guard let finalURL = components?.url else {return completion(.failure(.invalidURL))}
        print("\nFinalURL for FetchEvent ::: \(finalURL)\n")
        
        URLSession.shared.dataTask(with: finalURL) { (data, response, error) in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            
            if let response = response as? HTTPURLResponse {
                print("FETCH EVENT STATUS CODE: \(response.statusCode)")
            }
            
            guard let data = data else {return completion(.failure(.noData))}
            do {
                let events = try JSONDecoder().decode(Events.self, from: data)
                let fetchedEvents = events.events
                return completion(.success(fetchedEvents))
            } catch {
                return completion(.failure(.thrownError(error)))
            }
        }.resume()
    }
    
    // MARK: - FetchImage
    static func fetchImage(with eventImageURL: URL, completion: @escaping (Result<UIImage,EventError>) -> Void) {
        URLSession.shared.dataTask(with: eventImageURL) { (data, response, error) in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            
            if let response = response as? HTTPURLResponse {
                print("FETCH IMAGE'S EVENT STATUS CODE : \(response.statusCode)")
            }
            
            guard let data = data else {return completion(.failure(.noData))}
            guard let fetchedImage = UIImage(data: data) else {return completion(.failure(.unableToDecode))}
            completion(.success(fetchedImage))
        }.resume()
    }
}
