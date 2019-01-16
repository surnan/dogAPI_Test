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
        
//        DogAPI.requestJSONFile(completionHandler: self.handleJSONFileResponse(url:error:))
        DogAPI.requestJSONFile(breed: doggyArray[row], completionHandler: self.handleJSONFileResponse(url:error:))
        
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
    
    
    //MARK:- stuff
    private func handleJSONFileResponse(url: URL?, error: Error?){
        guard let imageURL = url else {return}
        DogAPI.requestImageFile(url: imageURL, completionHandler: self.handleImageFileResponse(image:err:))
    }
    
    private func handleImageFileResponse(image: UIImage?, err: Error?){
        if let tempImage = image {
            DispatchQueue.main.async {
                self.doggyImageView.image = tempImage
            }
        }
    }
}
