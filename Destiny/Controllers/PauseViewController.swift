//
//  PauseViewController.swift
//  Destiny
//
//  Created by Vadym Dmytriiev on 4/2/18.
//  Copyright © 2018 Vadym Dmytriiev. All rights reserved.
//

import UIKit

class PauseViewController: UIViewController {
    
    @IBOutlet weak var pauseView: UIView!
    
    override func viewDidLoad() {
        pauseView.layer.cornerRadius = 15
        self.view.backgroundColor = UIColor.black
        self.view.layer.masksToBounds = false
        super.viewDidLoad()
    }
    
    @IBAction func continueBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0)
    }
}
