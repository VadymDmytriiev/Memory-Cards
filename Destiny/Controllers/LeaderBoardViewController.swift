//
//  LeaderBoardViewController.swift
//  Destiny
//
//  Created by Vadym Dmytriiev on 2/2/18.
//  Copyright © 2018 Vadym Dmytriiev. All rights reserved.
//

import UIKit
import  CoreData

class LeaderBoardViewController: UIViewController {
    
    private var resultsFromRecord: [NSManagedObject]!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        self.navigationItem.hidesBackButton = true
        super.viewDidLoad()
        fetchDataFromDB()
    }
    
    @IBAction func menu(_ sender: UIBarButtonItem) {
        navigationController?.popToRootViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    func fetchDataFromDB() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequestRecord = NSFetchRequest<NSManagedObject>(entityName: "Records")
        let sort = NSSortDescriptor(key: "time", ascending: true)
        fetchRequestRecord.sortDescriptors = [sort]
        do {
            resultsFromRecord = try managedContext.fetch(fetchRequestRecord)
        } catch let err as NSError {
            print("Failed to fetch items", err)
        }
    }
}

extension LeaderBoardViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = resultsFromRecord {
            return sections.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as! RecordsTableViewCell
        let user = resultsFromRecord[indexPath.row]
        let userName = user.value(forKey: "userName")
        let userScore = user.value(forKey: "score")
        let userTime = user.value(forKey: "time")
        cell.nameLabel.text = "\(userName ?? "name unavialable")"
        cell.scoreLabel.text = "\(userScore ?? "score unavialable")"
        cell.timeLabel.text = "\(userTime ?? "time unavialable")"
        return cell
    }
}

extension LeaderBoardViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "tableCell") as! RecordsTableViewCell
        headerCell.contentView.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        return headerCell.contentView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
}

