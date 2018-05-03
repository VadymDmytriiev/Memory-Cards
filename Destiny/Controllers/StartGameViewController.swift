//
//  ViewController.swift
//  Destiny
//
//  Created by Vadym Dmytriiev on 1/23/18.
//  Copyright © 2018 Vadym Dmytriiev. All rights reserved.
//

import UIKit

class StartGameViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var goButton: UIButton!
    
    @IBOutlet weak var pickerView: UIPickerView!

    let amount = ["8","12","18"]
    
    var count = 8
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return amount[row]
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return amount.count
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gameSegue"{
            let temp = segue.destination as! GameViewController
            temp.varFromPickerView = count
        }
    }
    
    @IBAction func toGame(_ sender: UIButton) {
        performSegue(withIdentifier: "gameSegue", sender: self)
    }
  
    @IBAction func language(_ sender: UIButton) {
        performSegue(withIdentifier: "langu", sender: self)
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        count = Int(amount[row])!
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        let titleData = amount[row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSAttributedStringKey.font:UIFont(name: "Georgia", size: 35.0)!,NSAttributedStringKey.foregroundColor:UIColor.white])
        pickerLabel.attributedText = myTitle
        pickerLabel.textAlignment = .center
        return pickerLabel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "retryGame"), object: nil, queue: OperationQueue.main) { notification in
            self.toGame(self.goButton)
        }
        count = 8
    }
}

