//
//  PopUpViewController.swift
//  Destiny
//
//  Created by Vadym Dmytriiev on 2/1/18.
//  Copyright © 2018 Vadym Dmytriiev. All rights reserved.
//

import UIKit
import CoreData
class PopUpViewController: UIViewController {
    
    var results: [NSManagedObject]!
    
    var flipsFromGameViewController = 0
    
    var timeFromViewControoler = 0

    @IBOutlet weak var resultsView: UIView!
    
    @IBOutlet weak var scoreCounter: UILabel!
    
    @IBOutlet weak var timer: UILabel!
    
    @IBOutlet weak var nameOfTheUser: UITextField!
    
    @IBOutlet weak var score: UILabel!
    
    @IBOutlet weak var time: UILabel!

    @IBAction func rec(_ sender: UIButton) {
        saveNewResult()
        performSegue(withIdentifier: "goToRecords", sender: self)
    }

    @IBAction func menuBut(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        resultsView.layer.cornerRadius = 15
        self.view.backgroundColor = UIColor.black
        self.view.layer.masksToBounds = false
        score.text = "\(flipsFromGameViewController)"
        time.text = "\(timeFromViewControoler)"
        self.navigationItem.hidesBackButton = true
        self.navigationController?.navigationBar.barTintColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0)
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0)
    }
    

    //--------------------------DataBase----------------------
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Records")

        do {
            results = try managedContext.fetch(fetchRequest)
        } catch let err as NSError {
            print("Failed to fetch items", err)
        }
    }
    
    func saveNewResult() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let context = appDelegate.persistentContainer.viewContext
        let newResult = NSEntityDescription.insertNewObject(forEntityName: "Records", into: context)
        
        newResult.setValue(flipsFromGameViewController, forKey: "score")
        newResult.setValue(timeFromViewControoler, forKey: "time")
        newResult.setValue(nameOfTheUser.text, forKey: "userName")

        do {
            try context.save()
            results.append(newResult)
        } catch {
            print("error")
        }
    }


}
