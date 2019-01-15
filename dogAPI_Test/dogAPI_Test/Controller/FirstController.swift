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

        let randomImageEndpoint = DogAPI.Endpoint.randomImageFromAllDogsCollection.url
        
        URLSession.shared.dataTask(with: randomImageEndpoint) { (data, resp, err) in
            guard let jsonPull = data else {return}
            let decoder = JSONDecoder()
            do {
                let temp = try decoder.decode(DogImage.self, from: jsonPull)
                guard let tempURL = URL(string: temp.message) else {return}
                DogAPI.requestImageFile(url: tempURL, completionHandler: self.handleImageFileResponse(image:err:))
            } catch {
                print("There was a problem", error)
            }
        }.resume()
        
        
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

