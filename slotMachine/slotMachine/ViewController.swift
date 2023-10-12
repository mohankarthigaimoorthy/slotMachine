//
//  ViewController.swift
//  slotMachine
//
//  Created by Imcrinox Mac on 17/12/1444 AH.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var resultLbl: UILabel!
    @IBOutlet weak var emojiSlotPicker: UIPickerView!
    @IBOutlet weak var spinBtn: UIButton!
    @IBOutlet weak var modeBtn: UIButton!
    
    var imageArray = [String]()
    var dataArray1 = [Int]()
    var dataArray2 = [Int]()
    var dataArray3 = [Int]()
    var amazinFlag = false
    var bounds : CGRect = CGRect .zero
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        bounds = spinBtn.bounds
        imageArray = ["🎰","💵","💰","💸","💀","🪙","🍔","😎","👻","🍟","🚖","🏍"]
        
        for _ in 0...100 {
            self.dataArray1.append((Int)(arc4random() % 10 ))
            self.dataArray2.append((Int)(arc4random() % 10 ))
            self.dataArray3.append((Int)(arc4random() % 10 ))

        }
        
        resultLbl.text = ""
        
        emojiSlotPicker.delegate = self
        emojiSlotPicker.dataSource = self
        
        spinBtn.layer.cornerRadius = 4
        spinBtn.layer.masksToBounds = true
        modeBtn.layer.cornerRadius = 4
    }
    
//    override var prefferedStatusBarStyle : UIStatusBarStyle {
//        return UIStatusBarStyle.lightContent
//        
//    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        spinBtn.alpha = 0
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.5, delay: 0.3, options: .curveEaseOut,animations: {
            self.spinBtn.alpha = 1
            
        }, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBAction func spinSlotButton(_ sender: Any) {
        let index1: Int
        let index2: Int
        let index3: Int
        if amazinFlag {
            index1 = Int(arc4random()) % 90 + 3
            index2 = dataArray2.firstIndex(of: dataArray1[index1])!
            index3 = dataArray3.lastIndex(of: dataArray1[index1])!
        }
        else {
            index1 =  Int(arc4random()) % 90 + 3
            index2 = Int(arc4random()) % 90 + 3
            index3 = Int(arc4random()) % 90 + 3
            
        }
        
        emojiSlotPicker.selectRow(index1, inComponent: 0, animated: true )
        emojiSlotPicker.selectRow(index2, inComponent: 1, animated: true )
        emojiSlotPicker.selectRow(index3, inComponent: 2, animated: true )

        if(dataArray1[emojiSlotPicker.selectedRow(inComponent: 0)] ==
           dataArray2[emojiSlotPicker.selectedRow(inComponent: 1)] &&
           dataArray2[emojiSlotPicker.selectedRow(inComponent: 1)] ==
           dataArray3[emojiSlotPicker.selectedRow(inComponent: 2)]) {
            
            resultLbl.text = "Bingo!"
        }
        else {
            resultLbl.text = "💔Loss"
        }
        
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.1, initialSpringVelocity: 5, options: .curveLinear, animations: {
            self.spinBtn.bounds = CGRect(x: self.bounds.origin.x, y: self.bounds.origin.y, width: self.bounds.size.width - 20, height: self.bounds.size.height)
        }, completion: {(complete: Bool) in
            UIView.animate(withDuration: 0.1, delay: 0.0, options: UIView.AnimationOptions(), animations: {
                self.spinBtn.bounds = CGRect(x: self.bounds.origin.x, y: self.bounds.origin.y, width: self.bounds.size.width, height: self.bounds.size.height)
            }, completion: nil)
        })
                       
                       }
    
    @IBAction func modeSlotButton(_ sender: Any) {
        amazinFlag = !amazinFlag;
        (sender as AnyObject).setTitle(amazinFlag ? "normalMode":" openMode", for: .normal)
        
    }
    
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       return  3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 100
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 100.0

    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 100.0
    }
    
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
                let pickerlabel = UILabel()
        if component == 0 {
            pickerlabel.text = imageArray[(Int)(dataArray1[row])]
        }
        else if component == 1 {
            pickerlabel.text = imageArray[(Int)(dataArray2[row])]
        }
        else {
            pickerlabel.text = imageArray[(Int)(dataArray3[row])]
        }
        
        pickerlabel.font = UIFont(name: "Apple Color Emoji", size: 80)
        pickerlabel.textAlignment = NSTextAlignment.center
        
        return pickerlabel
    }
}
