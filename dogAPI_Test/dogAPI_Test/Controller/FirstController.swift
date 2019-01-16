//
//  ViewController.swift
//  dogAPI_Test
//
//  Created by admin on 1/13/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

class FirstController: UIViewController {
    
    var breedPicker: UIPickerView = {
       let picker = UIPickerView()
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
        let urlToJSON = DogAPI.Endpoint.randomImageFromAllDogsCollection.url
        DogAPI.requestJSONFile(url: urlToJSON) { (url, error) in
            guard let imageURL = url else {return}
            DogAPI.requestImageFile(url: imageURL, completionHandler: self.handleImageFileResponse(image:err:))
        }
        
        [doggyImageView, breedPicker].forEach{screenStackView.insertArrangedSubview($0, at: 0)}
        view.addSubview(screenStackView)
    }
    
    func handleImageFileResponse(image: UIImage?, err: Error?){
        if let tempImage = image {
            DispatchQueue.main.async {
                self.doggyImageView.image = tempImage
            }
        }
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            screenStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            screenStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            screenStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            screenStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ])
    }
}

