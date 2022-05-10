//
//  ChatClient.swift
//  Rapptr iOS Test
//
//  Created by Ethan Humphrey on 8/11/21.
//

import Foundation
import UIKit

/**
 * =========================================================================================
 * INSTRUCTIONS
 * =========================================================================================
 * 1) Make a request to fetch chat data used in this app.
 *
 * 2) Using the following endpoint, make a request to fetch data
 *    URL: http://dev.rapptrlabs.com/Tests/scripts/chat_log.php
 *
 */

class ChatClient {
    
//    var session: URLSession?
    
    static let baseURL = "http://dev.rapptrlabs.com/Tests/scripts/chat_log.php"
    
    static func fetchChatData(completion: @escaping (Result<[Message], ClientError>) -> Void) {
        
        guard let baseURL = URL(string: baseURL) else { return completion(.failure(.invalidError)) }
        
        URLSession.shared.dataTask(with: baseURL) { data, response, error in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n--\n \(error)")
                completion(.failure(.thrownError(error)))
                return
            }
            
            if let response = response as? HTTPURLResponse {
                print("Fetched Messages Response Code: \(response.statusCode)")
            }
            
            guard let data = data else { return completion(.failure(.noData)) }
            
            do {
                let topLevelObject = try JSONDecoder().decode(TopLevelObject.self, from: data)
                let messages = topLevelObject.data
                return completion(.success(messages))
            } catch {
                return completion(.failure(.unableToDecode))
            }

        }.resume()
    }
    
    static func fetchImage(with avatarURL: String, completion: @escaping (Result<UIImage, ClientError>) -> Void) {
        guard let avatarURL = URL(string: avatarURL) else { return completion(.failure(.noData)) }
        
        URLSession.shared.dataTask(with: avatarURL) { data, response, error in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n--\n \(error)")
                completion(.failure(.thrownError(error)))
                return
            }
            
            if let response = response as? HTTPURLResponse{
                print("Fetched Image Response Code: \(response.statusCode)")
            }
            
            guard let data = data else { return completion(.failure(.noData)) }
            guard let avatarImage = UIImage(data: data) else { return completion(.failure(.unableToDecode)) }
            completion(.success(avatarImage))

        }.resume()
    }
    
    
}
