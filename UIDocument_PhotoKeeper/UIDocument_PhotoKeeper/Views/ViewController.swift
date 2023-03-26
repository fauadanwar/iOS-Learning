//
//  ViewController.swift
//  UIDocument_PhotoKeeper
//
//  Created by Fauad Anwar on 24/03/23.
//

import UIKit

private extension String {
    static let cellID = "PhotoKeeperCell"
}

class ViewController: UIViewController {
    private var selectedEntry: Entry?
    private var entries: [Entry] = []
    
    private lazy var localRoot: URL? = FileManager.default.urls(
        for: .documentDirectory,
        in: .userDomainMask).first
    private var selectedDocument: Document?
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var leftBarButtonItem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refresh()
    }
    
    private func loadDoc(at fileURL: URL) {
        let doc = Document(fileURL: fileURL)
        doc.open { [weak self] success in
            guard success else {
                fatalError("Failed to open doc.")
            }
            
            let metadata = doc.metadata
            let fileURL = doc.fileURL
            let version = NSFileVersion.currentVersionOfItem(at: fileURL)
            
            doc.close() { success in
                guard success else {
                    fatalError("Failed to close doc.")
                }
                
                if let version = version {
                    self?.addOrUpdateEntry(for: fileURL, metadata: metadata, version: version)
                }
            }
        }
    }
    
    private func loadLocal() {
        guard let root = localRoot else { return }
        do {
            let localDocs = try FileManager.default.contentsOfDirectory(
                at: root,
                includingPropertiesForKeys: nil,
                options: [])
            
            for localDoc in localDocs where localDoc.pathExtension == .appExtension {
                loadDoc(at: localDoc)
            }
        } catch let error {
            fatalError("Couldn't load local content. \(error.localizedDescription)")
        }
    }
    
    private func refresh() {
        loadLocal()
        tableView.reloadData()
    }
    
    private func getDocumentURL(for filename: String) -> URL? {
        return localRoot?.appendingPathComponent(filename, isDirectory: false)
    }
    
    private func getDocFilename(for prefix: String) -> String {
        var newDocName = String(format: "%@.%@", prefix, String.appExtension)
        var docCount = 1
        
        while docNameExists(for: newDocName) {
            newDocName = String(format: "%@ %d.%@", prefix, docCount, String.appExtension)
            docCount += 1
        }
        
        return newDocName
    }
    
    private func docNameExists(for docName: String) -> Bool {
        return !entries.filter{ $0.fileURL.lastPathComponent == docName }.isEmpty
    }
    
    private func indexOfEntry(for fileURL: URL) -> Int? {
        return entries.firstIndex(where: { $0.fileURL == fileURL })
    }
    
    private func addOrUpdateEntry(
        for fileURL: URL,
        metadata: PhotoMetadata?,
        version: NSFileVersion
    ) {
        if let index = indexOfEntry(for: fileURL) {
            let entry = entries[index]
            entry.metadata = metadata
            entry.version = version
        } else {
            let entry = Entry(fileURL: fileURL, metadata: metadata, version: version)
            entries.append(entry)
        }
        
        entries = entries.sorted(by: >)
        tableView.reloadData()
    }
    
    private func insertNewDocument(
        with photoEntry: PhotoEntry? = nil,
        title: String? = nil) {
            // 1
            guard let fileURL = getDocumentURL(
                for: getDocFilename(for: title ?? .photoKey)
            ) else { return }
            
            // 2
            let doc = Document(fileURL: fileURL)
            doc.photo = photoEntry
            
            // 3
            doc.save(to: fileURL, for: .forCreating) {
                [weak self] success in
                guard success else {
                    fatalError("Failed to create file.")
                }
                
                print("File created at: \(fileURL)")
                
                let metadata = doc.metadata
                let URL = doc.fileURL
                if let version = NSFileVersion.currentVersionOfItem(at: fileURL) {
                    // 4
                    self?.addOrUpdateEntry(for: URL, metadata: metadata, version: version)
                }
            }
        }
    
    private func showDetailVC() {
        guard let detailVC = detailVC else { return }
        
        detailVC.delegate = self
        detailVC.document = selectedDocument
        
        mode = .viewing
        present(detailVC.navigationController!, animated: true, completion: nil)
    }
    
    
    @IBAction func addEntry(_ sender: Any) {
        selectedEntry = nil
        selectedDocument = nil
        showDetailVC()
    }
    
    @IBAction func editEntries(_ sender: Any) {
        mode = mode.otherMode
    }
    
    private func delete(entry: Entry) {
        let fileURL = entry.fileURL
        guard let entryIndex = indexOfEntry(for: fileURL) else { return }

        do {
          try FileManager.default.removeItem(at: fileURL)
          entries.remove(at: entryIndex)
          tableView.reloadData()
        } catch {
          fatalError("Couldn't remove file.")
        }
    }
    
    private func rename(_ entry: Entry, with name: String) {
        guard entry.description != name else { return }

        let newDocFilename = "\(name).\(String.appExtension)"

        if docNameExists(for: newDocFilename) {
          fatalError("Name already taken.")
        }

        guard let newDocURL = getDocumentURL(for: newDocFilename) else { return }

        do {
          try FileManager.default.moveItem(at: entry.fileURL, to: newDocURL)
        } catch {
          fatalError("Couldn't move to new URL.")
        }

        entry.fileURL = newDocURL
        entry.version = NSFileVersion.currentVersionOfItem(at: entry.fileURL) ?? entry.version

        tableView.reloadData()

    }
    
    private var mode: Mode = .viewing {
        didSet {
            switch mode {
            case .editing:
                tableView.setEditing(true, animated: true)
                leftBarButtonItem.title = "Done"
            case .viewing:
                tableView.setEditing(false, animated: true)
                leftBarButtonItem.title = "Edit"
            }
        }
    }
}

//MARK: DetailViewControllerDelegate
extension ViewController: DetailViewControllerDelegate {
    func detailViewControllerDidFinish(_ viewController: DetailViewController, with photoEntry: PhotoEntry?, title: String?) {
        // 1
        guard
          let doc = viewController.document,
          let version = NSFileVersion.currentVersionOfItem(at: doc.fileURL)
          else {
            if let docData = photoEntry {
              insertNewDocument(with: docData, title: title)
            }
            return
        }

        // 2
        if let docData = photoEntry {
          doc.photo = docData
        }

        addOrUpdateEntry(for: doc.fileURL, metadata: doc.metadata, version: version)
        
        if let title = title, let entry = selectedEntry, title != entry.description {
          rename(entry, with: title)
        }
    }
}

//MARK: UITableViewDelegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let entry = entries[indexPath.row]
            delete(entry: entry)
        }
    }
}

//MARK: UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: .cellID, for: indexPath) as? PhotoKeeperCell else { return UITableViewCell() }
        
        let entry = entries[indexPath.row]
        cell.photoImageView?.image = entry.metadata?.image
        cell.titleTextField?.text = entry.description
        cell.subtitleLabel?.text = entry.version.modificationDate?.mediumString
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      let entry = entries[indexPath.row]
      selectedEntry = entry
      selectedDocument = Document(fileURL: entry.fileURL)
      
      showDetailVC()
      
      tableView.deselectRow(at: indexPath, animated: false)
    }

}

//MARK: UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        mode = .viewing
        
        guard
            let entry = selectedEntry,
            let newName = textField.text
        else {
            return true
        }
        
        rename(entry, with: newName)
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let filteredEntries = entries.filter { (entry) -> Bool in
            return entry.description == textField.text
        }
        
        guard let entry = filteredEntries.first else { return }
        
        selectedEntry = entry
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
}

//MARK: Additional Conveniences
extension ViewController {
    private var detailVC: DetailViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailNavVC = storyboard.instantiateViewController(withIdentifier: "DetailNavigationController")
        
        guard
            let navVC = detailNavVC as? UINavigationController,
            let detailVC = navVC.topViewController as? DetailViewController
        else {
            return nil
        }
        
        return detailVC
    }
}

private enum Mode {
    case editing
    case viewing
    
    var otherMode: Mode {
        switch self {
        case .editing:
            return .viewing
        case .viewing:
            return .editing
        }
    }
}
