//
//  DogAPI.swift
//  dogAPI_Test
//
//  Created by admin on 1/13/19.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation

class DogAPI {
    
    enum Endpoint: String {
        case randomImageFromAllDogsCollection = "https://dog.ceo/api/breeds/image/random"
        
        case randomImageFromAllDogsCollection2 =  "https://images.dog.ceo/breeds/appenzeller/n02107908_3613.jpg"
        
        
        
        var url: URL {
            return URL(string: self.rawValue)! //force-unwrapping will be safe here.  It's an enum
        }
    }
    

    
}
