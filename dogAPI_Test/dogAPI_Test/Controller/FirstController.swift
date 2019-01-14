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
        
        
        URLSession.shared.dataTask(with: randomImageEndpoint) { (data, response, err) in
           
            guard let data = data else {return}
            
            let decoder = JSONDecoder()
            
            do {
                let imageData = try decoder.decode(DogImage.self, from: data)
                guard let imageURL = URL(string: imageData.message) else {return}//we know it's a string from structure of DogImage Struct
                let task = URLSession.shared.dataTask(with: imageURL, completionHandler: { (data, response, err) in
                    if let data = data {
                        print("Data = \(data)")
                        DispatchQueue.main.async {
                            self.backgroundImageView.image = UIImage(data: data)
                        }
                    }
                })
                task.resume()
            } catch let conversionErr as CocoaError{
                print("Localized Description - ", conversionErr.localizedDescription)
                print("Code - ",conversionErr.code)
                print("User Info - ",conversionErr.userInfo)
                print("Original --",conversionErr)
            } catch {
                print("Unable to convert file contents to UIImage", error)
            }
        }.resume()
        view.addSubview(backgroundImageView)
        setupConstraints()
    }
    
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            backgroundImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backgroundImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            ])
    }
}

/*
 } catch let conversionErr as CocoaError{
 print("Localized Description - ", conversionErr.localizedDescription)
 print("Code - ",conversionErr.code)
 print("User Info - ",conversionErr.userInfo)
 print("Original --",conversionErr)
 } catch {
 print("Unable to convert file contents to UIImage", error)
 }
 */
