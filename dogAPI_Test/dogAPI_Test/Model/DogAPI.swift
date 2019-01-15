//
//  DogAPI.swift
//  dogAPI_Test
//
//  Created by admin on 1/13/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

class DogAPI {
    
    enum Endpoint: String {
        case randomImageFromAllDogsCollection = "https://dog.ceo/api/breeds/image/random"  //link to JSON
        
        var url: URL {
            return URL(string: self.rawValue)! //force-unwrapping will be safe here.  It's an enum
        }
    }
    
    class func requestImageFile(url: URL, completionHandler: @escaping (UIImage?, Error?) -> Void){
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let tempData = data else {
                completionHandler(nil, error)
                return
            }
            let downloadedImage = UIImage(data: tempData)
            completionHandler(downloadedImage, nil)
            return
        }.resume()
    }
    
    class func requestJSONFile(completionHandler: @escaping (URL?, Error?)-> Void) {
        let urlToJSON = DogAPI.Endpoint.randomImageFromAllDogsCollection.url
        URLSession.shared.dataTask(with: urlToJSON) { (data, resp, err) in
            guard let jsonPull = data else {
                completionHandler(nil, err)
                return
            }
            let decoder = JSONDecoder()
            do {
                let tempDogImage = try decoder.decode(DogImage.self, from: jsonPull)
                guard let tempURL = URL(string: tempDogImage.message) else {
                    completionHandler(nil, err)
                    return
                }
                completionHandler(tempURL, nil)
                return
            } catch {
                completionHandler(nil, err)
                return
            }
        }.resume()
    }
}
