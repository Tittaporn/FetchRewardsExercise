//
//  EventListTableViewController.swift
//  SeatGeekEvents
//
//  Created by Lee on 4/29/21.
//

import UIKit

class EventListTableViewController: UITableViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: - Properties
    var events: [Event] = []
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        events = FavoriteEventController.shared.favoriteEvents
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as? EventTableViewCell else {return UITableViewCell()}
        let event = events[indexPath.row]
        cell.event = event
        return cell
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEventDetailVC" {
            guard let index = tableView.indexPathForSelectedRow else {return}
            guard let destinationVC = segue.destination as? EventDetailViewController else {return}
            let event = events[index.row]
            destinationVC.event = event
        }
    }
}

extension EventListTableViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let eventSearchTerm = searchBar.text else {return}
        EventController.fetchEvents(searchTerm: eventSearchTerm) { [weak self](result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let events):
                    self?.events = events
                    self?.tableView.reloadData()
                case .failure(let error):
                    print("\n===================\(error.localizedDescription))======================IN \(#function)\n")
                }
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.text = ""
        events = FavoriteEventController.shared.favoriteEvents
        tableView.reloadData()
    }
}
