//
//  EventTableViewCell.swift
//  SeatGeekEvents
//
//  Created by Lee on 4/29/21.
//

import UIKit

class EventTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var favoriteImageView: UIImageView!
    
    // MARK: - Properties
    var event: Event? {
        didSet {
            updateViewCellWith(event: event!)
        }
    }
    
    // MARK: - Helper Fuctions
    func updateViewCellWith(event: Event) {
        titleLabel.text = event.shortTitle
        locationLabel.text = event.venue.location
        let eventDate = event.date.stringDateToDate()
        dateLabel.text = eventDate.dateToString(format: .dateWithDay)
        timeLabel.text = eventDate.dateToString(format: .time)
        updateImageFor(event: event)
        if FavoriteEventController.shared.favoriteEvents.contains(event) {
            favoriteImageView.isHidden = false
            favoriteImageView.image = UIImage(systemName: "heart.fill")
        } else {
            favoriteImageView.isHidden = true
        }
    }
    
    func updateImageFor(event: Event) {
        guard let imageURL = event.performers.first?.image else {return}
        EventController.fetchImage(with: imageURL) { [weak self] (results) in
            switch results {
            case .success(let eventImage):
                DispatchQueue.main.async {
                    self?.eventImageView.image = eventImage
                    self?.eventImageView.contentMode = .scaleToFill
                    self?.eventImageView.clipsToBounds = true
                    self?.eventImageView.layer.cornerRadius = 10
                }
            case .failure(let error):
                print("\n===================\(error.localizedDescription)======================IN \(#function)\n")
            }
        }
    }
}
