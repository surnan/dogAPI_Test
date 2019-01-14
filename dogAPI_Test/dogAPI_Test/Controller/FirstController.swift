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
        
        
        URLSession.shared.downloadTask(with: randomImageEndpoint) { (url, response, err) in
            if let fileURL = url {
                print("randomImageEndpoint = \(randomImageEndpoint)")
                print("file url = ",fileURL)
                
                do {
                    let retrievedData = try Data(contentsOf: fileURL)
                    let jsonDownloadedData = try JSONSerialization.jsonObject(with: retrievedData, options: []) as! [String:Any]
                    print(jsonDownloadedData["message"] ?? "")
                } catch let conversionErr as CocoaError{
                    print("Localized Description - ", conversionErr.localizedDescription)
                    print("Code - ",conversionErr.code)
                    print("User Info - ",conversionErr.userInfo)
                    print("Original --",conversionErr)
                } catch {
                    print("Unable to convert file contents to UIImage", error)
                }
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
