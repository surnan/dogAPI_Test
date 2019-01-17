//
//  DogImage.swift
//  dogAPI_Test
//
//  Created by admin on 1/14/19.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation

struct DogImage: Codable {
    let status: String
    let message: String
}


struct BreedImage: Codable {
    let status: String
    let breeds: [String:[String]]
    
    enum CodingKeys: String, CodingKey {
        case status
        case breeds = "message"
    }
    
}
