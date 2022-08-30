//
//  APIService.swift
//  Coppel ios examen
//
//  Created by Josue Valdez Morales on 15/08/22.
//

import Foundation

class APIService :  NSObject {
    private let api_base = "https://api.themoviedb.org/3/"
    private let api_key = "f48e69d6a8485ef2819154aca28c93cd"
    private let url_token = "authentication/token/new?api_key="
    private let url_session = "authentication/session/new"
    private let login = "authentication/token/validate_with_login?api_key="
    
    func generateSession(token: String, completion : @escaping (Result<Data, Error>) -> ()){
        guard let url = URL(string: api_base+"authentication/session/new?api_key="+api_key) else {
            print("Error: cannot create URL")
            return
        }
        
        let sessionBody = SessionRequest(request_token: token)
                
        // Convert model to JSON data
        guard let jsonData = try? JSONEncoder().encode(sessionBody) else {
            print("Error: Trying to convert model to JSON data")
            return
        }
        
        
        //not sure if these are headers or not, they look more like GET fields
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type") // the request is JSON
        request.setValue("application/json", forHTTPHeaderField: "Accept") // the response expected to be in JSON format
        request.httpBody = jsonData

        URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            let statusCode = (response as! HTTPURLResponse).statusCode
            if (statusCode == 200){
                completion(.success(data!))
            }
            
        }.resume()
    }
    
    func generateToken(completion : @escaping (Result<Data, Error>) -> ()){
        var url = URLComponents(string: api_base+url_token)!

        url.queryItems = [
            URLQueryItem(name: "api_key", value: api_key)
        ]
        
        url.percentEncodedQuery = url.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        let request = URLRequest(url: url.url!)
            
        
        guard let url = request.url else {
            print("Error: cannot create URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, urlResponse, error) in
            if let data = data {
                completion(.success(data))
            }
            
            if let error = error {
                completion(.failure(error))
            }
            
        }.resume()
    }
    
    func sendRequestToLogin(user : String, passwd : String, token: String,
        completion: @escaping (Result<Data, Error>) -> Void){
        
        guard let url = URL(string: api_base+login+api_key) else {
            print("Error: cannot create URL")
            return
        }
        
        let uploadDataModel = UserCredentials(username: user, password: passwd, request_token: token)
                
        // Convert model to JSON data
        guard let jsonData = try? JSONEncoder().encode(uploadDataModel) else {
            print("Error: Trying to convert model to JSON data")
            return
        }
        
        //not sure if these are headers or not, they look more like GET fields
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type") // the request is JSON
        request.setValue("application/json", forHTTPHeaderField: "Accept") // the response expected to be in JSON format
        request.httpBody = jsonData

        URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            let statusCode = (response as! HTTPURLResponse).statusCode
            if (statusCode == 200){
                completion(.success(data!))
            }
            
        }.resume()
    }
    
    
    func sendRequestBillboardTMDB(endPointUrl : String, completion : @escaping (Result<Data, Error>) -> ()){
        var url = URLComponents(string: api_base + endPointUrl)!
        
        url.queryItems = [
            URLQueryItem(name: "api_key", value: api_key),
            URLQueryItem(name: "language", value: "es-ES")
        ]
        
        url.percentEncodedQuery = url.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        let request = URLRequest(url: url.url!)
            
        
        guard let url = request.url else {
            print("Error: cannot create URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, urlResponse, error) in
            if let data = data {
                completion(.success(data))
            }
            
            if let error = error {
                completion(.failure(error))
            }
            
        }.resume()
    }
    
    
    func sendRequestDetail(id : String, completion : @escaping (Result<Data, Error>) -> ()){
        var url = URLComponents(string: api_base + "movie/" + id)!
        
        url.queryItems = [
            URLQueryItem(name: "api_key", value: api_key),
            URLQueryItem(name: "language", value: "es-ES")
        ]
        
        url.percentEncodedQuery = url.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        var request = URLRequest(url: url.url!)
            
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type") // the request is JSON
        request.setValue("application/json", forHTTPHeaderField: "Accept") // the response expected to be in JSON format
        
        guard let url = request.url else {
            print("Error: cannot create URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, urlResponse, error) in
            if let data = data {
                completion(.success(data))
            }
            
            if let error = error {
                completion(.failure(error))
            }
            
        }.resume()
    }
    
    
    func sendRequestProfile(completion : @escaping (Result<Data, Error>) -> ()){
        var url = URLComponents(string: api_base + "account")!
        
        url.queryItems = [
            URLQueryItem(name: "api_key", value: api_key),
            URLQueryItem(name: "session_id", value: UserPreferences.retrieveSession())
        ]
        
        url.percentEncodedQuery = url.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        var request = URLRequest(url: url.url!)
            
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type") // the request is JSON
        request.setValue("application/json", forHTTPHeaderField: "Accept") // the response expected to be in JSON format
        
        guard let url = request.url else {
            print("Error: cannot create URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, urlResponse, error) in
            if let data = data {
                completion(.success(data))
            }
            
            if let error = error {
                completion(.failure(error))
            }
            
        }.resume()
    }
}
