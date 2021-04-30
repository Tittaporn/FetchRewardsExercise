//
//  EventDetailViewController.swift
//  SeatGeekEvents
//
//  Created by Lee on 4/29/21.
//

import UIKit

class EventDetailViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var favoriteImageView: UIImageView!
    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var dateAndTimeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var detailTextView: UITextView!
    
    // MARK: - Properties
    var event: Event?
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        eventImageView.contentMode = .scaleToFill
        eventImageView.clipsToBounds = true
        eventImageView.layer.cornerRadius = 10
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateView()
    }
    
    // MARK: - Actions
    @IBAction func favoriteButttonTapped(_ sender: Any) {
    
    }
    
    // MARK: - Helper Fuctions
    func updateView() {
        guard let event = event else {return}
        titleLabel.text = event.title
        locationLabel.text = event.venue.location
        let eventDate = event.date.stringDateToDate()

        dateAndTimeLabel.text = eventDate.dateToString(format: .fullWithTime)
        updateImageFor(event: event)
    }
    
    
    func updateImageFor(event: Event) {
        guard let imageURL = event.performers.first?.image else {return}
        EventController.fetchImage(with: imageURL) { [weak self] (results) in
            switch results {
            case .success(let eventImage):
                DispatchQueue.main.async {
                    self?.eventImageView.image = eventImage
//                    self?.eventImageView.contentMode = .scaleToFill
//                    self?.eventImageView.clipsToBounds = true
//                    self?.eventImageView.layer.cornerRadius = 10
                }
            case .failure(let error):
                print("\n===================\(error.localizedDescription)======================IN \(#function)\n")
            }
        }
    }
}
