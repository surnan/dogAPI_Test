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
    
    

    
    
}
