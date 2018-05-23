//
//  SubReddit.swift
//  SubReddit
//
//  Created by Caston  Boyd on 5/22/18.
//  Copyright © 2018 Caston  Boyd. All rights reserved.
//

import UIKit



struct JSONDictionary: Codable {
    
    let data : DataDictionary
    
    struct DataDictionary: Codable {
        let children: [PostDictionary]
        
        
        struct PostDictionary: Codable {
            let data: Post
        }
    }
}

struct Post: Codable {
    let title: String
    let thumbnail: String
    let numberOfUpVotes: Int
    let numberOfComments: Int
    
    private enum CodingKeys: String, CodingKey {
        case thumbnail = "thumbnail"
        case title = "title"
        case numberOfUpVotes = "ups"
        case numberOfComments = "num_comments"
    }
    
}

