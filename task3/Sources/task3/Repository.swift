//
//  File.swift
//  
//
//  Created by Body Block on 04/02/2020.
//

import Foundation

struct Repository: Decodable, CustomStringConvertible {
    //need only name
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case name
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: CodingKeys.name)
    }
    
    var description: String {
        return name
    }
    
}
