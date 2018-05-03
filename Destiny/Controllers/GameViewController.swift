//  GameViewController.swift
//  Destiny
//
//  Created by Vadym Dmytriiev on 1/23/18.
//  Copyright © 2018 Vadym Dmytriiev. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var flipCounter: UILabel!
    
    @IBOutlet weak var timerLabel: UILabel!
    
    var timer = Timer()
    var counter = 0
    var isRuning = false
    
    let cellMagrings: CGFloat = 5
    
    func startTime(){
        if(isRuning == false){  
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
            isRuning = true
        }
    }
    
    @objc func updateTimer(){
        counter += 1
        timerLabel.text = "\(counter)"
    }
    
    var selected:[IndexPath] = []
    private var cellIndexies:[IndexPath] = []
    
    var varFromPickerView = 1
    private var shuffledPics = [Int: UIImage]()
    
    var flips = 1
    var leftCardsCounter = 0
    
    override func viewDidLoad() {
        collectionView.delegate = self
        collectionView.dataSource = self
        let share = UIBarButtonItem(title: "share", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.shareResults))
        self.navigationItem.rightBarButtonItem = share
        self.navigationItem.rightBarButtonItem?.image = UIImage(named: "share")
        leftCardsCounter = varFromPickerView
        super.viewDidLoad()
    }
    
    override func becomeFirstResponder() -> Bool {
        return true
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            NotificationCenter.default.post(name: Notification.Name(rawValue: "retryGame"), object: self)
            dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func shareResults() {
        let screenForSharing = captureScreen()
        let activityVC = UIActivityViewController(activityItems: [screenForSharing!], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC, animated: true, completion: nil)
    }
    
    func captureScreen() -> UIImage? {
        let layer = UIApplication.shared.keyWindow!.layer
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale);
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let screenshot = UIGraphicsGetImageFromCurrentImageContext()
        return screenshot
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return varFromPickerView
    }
    
    private lazy var game = Shuffler(numberOfPairsOfCards: varFromPickerView / 2)
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        startTime()
        selected.append(indexPath)
        switch selected.count {
        case 1:
            let cell  = collectionView.cellForItem(at: selected[0]) as! CustomCollectionViewCell
            cell.flipFront(image: game.pictureForCell(for: game.cards[selected[0].row]))
            
        case 2:
            if selected[0] == selected[1] {
                let cell = collectionView.cellForItem(at: selected[0]) as! CustomCollectionViewCell
                cell.flipBack()
                selected.remove(at: 0)
                selected.remove(at: 0)// remove from indexPath not selected cell
            }
            else {
                let card1 = game.cards[selected[0].row] // getting card by sellected index
                let card2 = game.cards[selected[1].row]
                let cell1 = collectionView.cellForItem(at: selected[0]) as! CustomCollectionViewCell
                let cell2 = collectionView.cellForItem(at: selected[1]) as! CustomCollectionViewCell
                cell2.flipFront(image: game.pictureForCell(for: game.cards[selected[1].row]))
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                })
                if card1.identifier == card2.identifier {
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                        cell1.remove()
                        cell2.remove()
                        self.flips += 1
                        self.selected.removeAll()
                        self.leftCardsCounter -= 2
                        if(self.leftCardsCounter == 0){
                            self.timer.invalidate();
                            self.performSegue(withIdentifier: "sbPopUpId", sender: self)
                        }
                    })
                }
                collectionView.isUserInteractionEnabled = false
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                    collectionView.isUserInteractionEnabled = true
                })
                
                if card1.identifier != card2.identifier {
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                        cell1.flipBack()
                        cell2.flipBack()
                        self.selected.remove(at: 0)
                        self.selected.remove(at: 0)
                        self.flips += 1
                    })
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                })
            }
            
        default:
            print("print")
        }
        flipCounter.text = "\(flips)"
        
    }
    
    
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customCell", for: indexPath) as! CustomCollectionViewCell
        cell.initialCell();
        return cell
    }
    
    func cellsRowAndColomn() -> (cellInRow: Int, cellInColomn: Int){
        var cellInRow = Int(floor(sqrt(Double(varFromPickerView))))
        while (varFromPickerView % cellInRow != 0) {
            cellInRow -= 1
            if (cellInRow == 1) {
                break
            }
        }
        let cellInColomn = varFromPickerView / cellInRow
        return (cellInRow, cellInColomn)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "sbPopUpId" ){
            let flipsFromGame = segue.destination as! PopUpViewController
            flipsFromGame.flipsFromGameViewController = flips
            flipsFromGame.timeFromViewControoler = counter
        }
        
        if segue.identifier == "pauseGame" || segue.identifier == "sure" {
            stopTimer()
        }
    }
    
    func stopTimer(){
        timer.invalidate()
        isRuning = false
    }
    
    @IBAction func reloadBut(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "retryGame"), object: self)
        dismiss(animated: true, completion: nil)
    }
}
extension GameViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = collectionView.frame.width
        let screenHeight = collectionView.frame.height
        let cell = cellsRowAndColomn()
        if (screenWidth < screenHeight) {
            return CGSize(width: screenWidth/CGFloat(cell.cellInRow) - cellMagrings, height: screenHeight/CGFloat(cell.cellInColomn) - cellMagrings)
        } else {
            return CGSize(width: screenWidth/CGFloat(cell.cellInColomn) - cellMagrings, height: screenHeight/CGFloat(cell.cellInRow) - cellMagrings)
        }
    }
}

