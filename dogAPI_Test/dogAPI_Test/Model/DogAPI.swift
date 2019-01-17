//
//  DogAPI.swift
//  dogAPI_Test
//
//  Created by admin on 1/13/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

class DogAPI {
    
    enum Endpoint {
        case randomImageFromAllDogsCollection
        case randomImageForBreed(String)
        case allDogBreeds
        var stringValue: String {
            switch  self {
            case .randomImageFromAllDogsCollection:
                return "https://dog.ceo/api/breeds/image/random"  //link to JSON
            case .randomImageForBreed(let breed):
                return "https://dog.ceo/api/breed/\(breed.lowercased())/images/random"
            case .allDogBreeds:
                return "https://dog.ceo/api/breeds/list/all"
            }
        }
        var url: URL {
            return URL(string: self.stringValue)! //force-unwrapping enum is safe
        }
    }
    
    
    class func requestAllDogBreeds(completionHandler: @escaping ([String]?, Error?)-> Void){
        let url = DogAPI.Endpoint.allDogBreeds.url
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let breedData = data else {
                completionHandler(nil, error)
                return
            }
            let decode = JSONDecoder()
            let temp = try! decode.decode(BreedImage.self, from: breedData)
            let tempBreeds = temp.breeds
            var tempBreedKeys = tempBreeds.map{$0.key}
            tempBreedKeys =  tempBreedKeys.sorted()
            completionHandler(tempBreedKeys, nil)
            return
            }.resume()
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
    
    class func requestJSONFile(breed: String, completionHandler: @escaping (URL?, Error?)-> Void) {
        let url = DogAPI.Endpoint.randomImageForBreed(breed).url
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
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
