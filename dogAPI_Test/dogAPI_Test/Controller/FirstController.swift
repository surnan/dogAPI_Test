//
//  ViewController.swift
//  dogAPI_Test
//
//  Created by admin on 1/13/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

class FirstController: UIViewController {
    
    
    var backgroundImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let urlToJSON = DogAPI.Endpoint.randomImageFromAllDogsCollection.url
        DogAPI.requestJSONFile(url: urlToJSON) { (url, error) in
            guard let imageURL = url else {return}
            DogAPI.requestImageFile(url: imageURL, completionHandler: self.handleImageFileResponse(image:err:))
        }
        view.addSubview(backgroundImageView)
        setupConstraints()
    }
    
    func handleImageFileResponse(image: UIImage?, err: Error?){
        if let tempImage = image {
            DispatchQueue.main.async {
                self.backgroundImageView.image = tempImage
            }
        }
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            backgroundImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backgroundImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            ])
    }
}

