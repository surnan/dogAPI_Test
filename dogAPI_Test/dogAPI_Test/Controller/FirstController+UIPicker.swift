//
//  FirstController+UIPicker.swift
//  dogAPI_Test
//
//  Created by admin on 1/16/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

extension FirstController {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return doggyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("Row = \(row)\tComponent = \(component)")
        print("Doggy = \(doggyArray[row])")
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let returnLabel: UILabel = {
           let label = UILabel()
            label.backgroundColor = .orange
            label.attributedText = NSAttributedString(string: doggyArray[row], attributes:[
                NSAttributedString.Key.foregroundColor : UIColor.blue,
                NSAttributedString.Key.font : UIFont(name: "Bradley Hand", size: 25) as Any
                ])
            label.textAlignment = .center
            return label
        }()
        
        return returnLabel
    }
    
    
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "Pick you pooch 🐶  ❤️"
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50
    }
}
