//
//  ViewController.swift
//  CoreDataMDA
//
//  Created by Fauad Anwar on 03/05/23.
//

import UIKit

class ViewController: UIViewController {
    
    enum Section {
        case main
    }

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    let coreDataManager = CoreDataManager()
    typealias DataSource = UITableViewDiffableDataSource<Section, Event>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Event>
    private lazy var dataSource = setupDataSource()
    private var events = [Event]()
    private var selectedEvent: Event?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
//        for location in coreDataManager.getAllLocation() {
//            coreDataManager.deleteLocation(location: location)
//            print(location.address ?? "no address")
//            print(location.events ?? "no event")
//            print(location.image ?? "no image")
//        }
        refreshtableData()
    }
    
    func setupDataSource() -> DataSource
    {
        let dataSource = DataSource(tableView: tableView) { tableView, indexPath, event in
            let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as! EventCell
            cell.configureCell(event: event)
            return cell
        }
        dataSource.defaultRowAnimation = .fade
        return dataSource
    }
    
    func refreshtableData() {
        let events = coreDataManager.getAllEvent()
        self.events = events
        deleteButton.isEnabled = !events.isEmpty
        self.applySnapshot()
    }

    @IBAction func addEvent(_ sender: Any) {
        _ = coreDataManager.createEvent(eventDate: Date(), cost: 40, address: "\(events.count + 1) Address", imageName: "Burj_Khalifa")
        refreshtableData()
    }
    
    @IBAction func deleteEvent(_ sender: Any) {
        coreDataManager.deleteEvent(event: events.first!)
        refreshtableData()
    }
    
    func applySnapshot(animatingDifferences: Bool = true)
    {
        var initialSnapshot = Snapshot()
        initialSnapshot.appendSections([.main])
        initialSnapshot.appendItems(self.events)
        self.dataSource.apply(initialSnapshot, animatingDifferences: animatingDifferences)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailSegue",
           let detailView = segue.destination as? DetailViewController
        {
            
            detailView.location = selectedEvent?.location
        }
    }
}

extension ViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedEvent = events[indexPath.row]
        performSegue(withIdentifier: "DetailSegue", sender: self)
    }
}
