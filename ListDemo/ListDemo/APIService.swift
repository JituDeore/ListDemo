//
//  APIService.swift
//  ListDemo
//
//  Created by Jitendra Deore on 18/06/18.
//  Copyright © 2018 Jitendra Deore. All rights reserved.
//

import Foundation

enum Result<T>{
    case success(T)
    case failure(Error?)
}

class APIService {
    
    class func fetchData(apiURL: String,onCompletion:@escaping (Result<List>)-> Void) {
        
        // Create the URLSession on the default configuration
        let defaultSessionConfiguration = URLSessionConfiguration.default
        let defaultSession = URLSession(configuration: defaultSessionConfiguration)
        
        // Passing the search controller text ...
        // Setup the request with URL
        
        let url = URL(string: apiURL)
        var urlRequest = URLRequest(url: url!)  // Note: This is a demo, that's why I use implicitly unwrapped optional
        
        // Set the httpMethod and assign httpBody
        urlRequest.httpMethod = "GET"
        
        // Create dataTask
        let dataTask = defaultSession.dataTask(with: urlRequest) {(data, response, error) in
            if error != nil {
                print(error ?? "")
                onCompletion(.failure(error))
            } else {
                do {
                    let asciJSON = String(data: data!, encoding: String.Encoding.ascii)
                    if let response = try JSONSerialization.jsonObject(with:(asciJSON?.data(using: String.Encoding.utf8))!, options: []) as? JSONItem{
                        if  let listItem = List(json: response){
                            DispatchQueue.main.async {
                                onCompletion(.success(listItem))
                            }
                        }
                    }
                } catch let error as NSError {
                    print(error)
                }
            }
        }
        // Fire the request
        dataTask.resume()
    }
    
}

