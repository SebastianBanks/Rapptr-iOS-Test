//
//  LoginClient.swift
//  Rapptr iOS Test
//
//  Created by Ethan Humphrey on 8/11/21.
//

import Foundation

/**
 * =========================================================================================
 * INSTRUCTIONS
 * =========================================================================================
 * 1) Make a request here to login.
 *
 * 2) Using the following endpoint, make a request to login
 *    URL: http://dev.rapptrlabs.com/Tests/scripts/login.php
 *
 * 3) Don't forget, the endpoint takes two parameters 'email' and 'password'
 *
 * 4) email - info@rapptrlabs.com
 *   password - Test123
 *
*/

class LoginClient {
    
    static let baseURL = "http://dev.rapptrlabs.com/Tests/scripts/login.php"
    
    static func login(email: String, password: String, completion: @escaping (Result<LoginResponse, ClientError>) -> Void) {
        
        guard let baseURL = URL(string: baseURL) else { return completion(.failure(.invalidError)) }
        
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)
        components?.queryItems = [
            URLQueryItem(name: "email", value: email.lowercased()),
            URLQueryItem(name: "password", value: password)
        ]
        
        let query = components?.url?.query
        
        var finalURL = URLRequest(url: baseURL)
        
        finalURL.httpMethod = "POST"
        finalURL.httpBody = Data(query!.utf8)
        
        print("\nFinalURL: \(finalURL)")
        
        URLSession.shared.dataTask(with: finalURL) { data, response, error in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n--\n \(error)")
                completion(.failure(.thrownError(error)))
                return
            }
            
            if let response = response as? HTTPURLResponse{
                if response.statusCode == 400 {
                    return completion(.failure(.invalidError))
                }
                print("Login Response Code: \(response.statusCode)")
            }
            
            guard let data = data else { return completion(.failure(.noData)) }
            
            do {
                let data = try JSONDecoder().decode(LoginResponse.self, from: data)
                completion(.success(data))
            } catch {
                return completion(.failure(.unableToDecode))
            }

        }.resume()
    }
}
