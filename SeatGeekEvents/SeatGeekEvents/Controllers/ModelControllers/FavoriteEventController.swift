//
//  FavoriteEventController.swift
//  SeatGeekEvents
//
//  Created by Lee on 4/29/21.
//

import Foundation

class FavoriteEventController {
    static let shared = FavoriteEventController()
    var favoriteEvents: [Event] = []
    
    func addFavoriteEvents(_ event: Event) {
        favoriteEvents.append(event)
        saveToPersistence()
    }
    
    func deleteFavoriteEvents(_ event: Event) {
        guard let index = favoriteEvents.firstIndex(of: event) else {return}
        favoriteEvents.remove(at: index)
        saveToPersistence()
    }
    
}

extension FavoriteEventController {
    // MARK: - Persistence
    // CREATE
    func createFileForPersistence() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = urls[0].appendingPathComponent("Event.json")
        return fileURL
    }
    
    // SAVE
    func saveToPersistence() {
        do {
            let data = try JSONEncoder().encode(favoriteEvents)
            try data.write(to: createFileForPersistence())
            print("\n===================SUCCESFULLY! Saved Favorite Events in FileURL IN\(#function) ======================\n")
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
    
    // LOAD
    func loadFromPersistance() {
        do {
            let data = try Data(contentsOf: createFileForPersistence())
            let events = try JSONDecoder().decode([Event].self, from: data)
            favoriteEvents = events
            print("\n===================SUCCESFULLY! Loaded Favorite event form Persistance store !! \(favoriteEvents.count) IN\(#function) ======================\n")
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
}

