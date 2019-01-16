//
//  ViewController.swift
//  dogAPI_Test
//
//  Created by admin on 1/13/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

class FirstController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    var doggyArray = ["Labrador Retriever", "French Bulldog", "Husky"]
    
    var titleLabel : UILabel = {
       var label = UILabel()
        label.text = " 😊 ❤️ 🐶  Pick your pooch 🐶 ❤️ 😊"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        
    var breedPicker: UIPickerView = {
       let picker = UIPickerView()
        picker.showsSelectionIndicator = true
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    var doggyImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    var screenStackView: UIStackView = {
       let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        breedPicker.delegate = self
        breedPicker.dataSource = self
        view.backgroundColor = .white
        let urlToJSON = DogAPI.Endpoint.randomImageFromAllDogsCollection.url
        DogAPI.requestJSONFile(url: urlToJSON) { (url, error) in
            guard let imageURL = url else {return}
            DogAPI.requestImageFile(url: imageURL, completionHandler: self.handleImageFileResponse(image:err:))
        }
        
        setupUI()
    }
    
    func handleImageFileResponse(image: UIImage?, err: Error?){
        if let tempImage = image {
            DispatchQueue.main.async {
                self.doggyImageView.image = tempImage
            }
        }
    }
    

    private func setupUI(){
        [doggyImageView, breedPicker].forEach{screenStackView.insertArrangedSubview($0, at: 0)}
        [titleLabel, screenStackView].forEach{view.addSubview($0)}
        setupConstraints()
    }
    
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
//            doggyImageView.heightAnchor.constraint(lessThanOrEqualTo: view.heightAnchor, multiplier: 0.25),
//            doggyImageView.widthAnchor.constraint(lessThanOrEqualToConstant: screenWidth),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            screenStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            screenStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            screenStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            screenStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ])
    }
}

