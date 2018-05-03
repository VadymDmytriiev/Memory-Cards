//
//  ChangeLanguageViewController.swift
//  Destiny
//
//  Created by Vadym Dmytriiev on 2/2/18.
//  Copyright © 2018 Vadym Dmytriiev. All rights reserved.
//

import UIKit

class ChangeLanguageViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func English(_ sender: UIButton) {
        self.changeToLanguage("en")
    }
    
    @IBAction func Ukrainian(_ sender: UIButton) {
        self.changeToLanguage("uk")
    }
    
    @IBAction func Italian(_ sender: UIButton) {
        self.changeToLanguage("it")
    }
    
    private func changeToLanguage(_ langCode: String) {
        if Bundle.main.preferredLocalizations.first != langCode {
            let confirmAlertCtrl = UIAlertController(title: NSLocalizedString("restartTitle", comment: ""), message: NSLocalizedString("restart", comment: ""), preferredStyle: .alert)
            
            let confirmAction = UIAlertAction(title: NSLocalizedString("close", comment: ""), style: .destructive) { _ in
                UserDefaults.standard.set([langCode], forKey: "AppleLanguages")
                UserDefaults.standard.synchronize()
                exit(EXIT_SUCCESS)
            }
            confirmAlertCtrl.addAction(confirmAction)
            
            let cancelAction = UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: .cancel, handler: nil)
            confirmAlertCtrl.addAction(cancelAction)
            
            present(confirmAlertCtrl, animated: true, completion: nil)
        }
    }
    
}
