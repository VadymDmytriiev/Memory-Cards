//
//  CustomCollectionViewCell.swift
//  Destiny
//  Created by Vadym Dmytriiev on 1/23/18.
//  Copyright © 2018 Vadym Dmytriiev. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageCell: UIImageView!
    
    func initialCell() {
        self.imageCell?.image = UIImage(named: "backCardIm.png")
    }
    
    func flipFront(image: UIImage){
        UIView.transition(with: self, duration: 0.4, options: .transitionFlipFromLeft, animations: {self.imageCell?.image = image}, completion: nil)
    }
    
    func flipBack() {
        UIView.transition(with: self,duration: 0.4, options: .transitionFlipFromLeft, animations: {self.imageCell?.image = UIImage(named: "backCardIm.png")
        },completion: nil)
    }
    
    func remove() {
        UIView.animate(withDuration: 0.2, animations: {
            self.alpha = 0
        }) { _ in
            self.removeFromSuperview()
        }
    }
    
}

