//
//  SubRedditController.swift
//  SubReddit
//
//  Created by Caston  Boyd on 5/22/18.
//  Copyright © 2018 Caston  Boyd. All rights reserved.
//

import Foundation
import UIKit

class SubRedditController {
    
    static let sharedInstance = SubRedditController()
    static let baseUrl = URL(string: "https://www.reddit.com/r")
    
    var posts: [Post] = []
    
   
    func fetchPostwith(searchName: String, completion: @escaping ()-> Void){
        guard let redditURL = SubRedditController.baseUrl else { fatalError("Crash my app beacue THIS needs to get fixed ASAP") }
        let requestUrl = redditURL.appendingPathComponent(searchName).appendingPathExtension("json")
        print("\(requestUrl)")
       
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        request.httpBody = nil
        
        URLSession.shared.dataTask(with: request) { (data, _ , error) in
            if let error = error {
                print("Error downloading with DataTask\(error.localizedDescription)")
                completion()
                return
            }
            guard let data = data else { completion() ; return }
            let jsonDecoder = JSONDecoder()
            do {
        
                let jsonDictionary = try jsonDecoder.decode(JSONDictionary.self, from: data)
                let posts = jsonDictionary.data.children.compactMap{$0.data}
                self.posts = posts
                completion()
                
            } catch let error {
                print("Error Loading reddit \(error.localizedDescription) \(error)")
                
            }
        }.resume()
        
    }
    
    func fetchImage(withURL: String, completion: @escaping ((UIImage?) -> Void)){
        guard let url = URL(string: withURL) else { completion(nil) ; return }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
                return
                
            }
            
            guard let data = data, let image = UIImage(data: data) else { completion(nil) ; return }
            completion(image)
            
            
        }.resume()
        
        
        
    }
    
}
