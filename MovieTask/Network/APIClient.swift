//
//  APIClient.swift
//  MovieTask
//
//  Created by Al-attar on 26/03/2024.
//

import Foundation
import UIKit

enum APIError: Error {
    case invalidURL
    case networkError(String)
    case decodingError
    case serverError(String)
}

class APIClient<T: TargetType> {
    
    var loadingCheck: Bool?
    
    private let baseURL: String = "https://api.themoviedb.org/3/"
    private let apiKey = "8b36bb045c454c225dde292662d9757c"
    
    /// a generic method to perform requests with requestModels
    /// - Parameters:
    ///   - target: it carries the data of the request you are performing
    ///   - requestModel: it is used to infer the type of the encodable parameters
    /// - Returns: an observable of type Result --> may carry a success or failure response
    func performRequest<X: Decodable, E: Encodable>(target: T, requestModel: E, completion: @escaping (Result<X, APIError>) -> Void) {
        if loadingCheck ?? true {
            Loading.shared.showLoading()
        }
        
        guard let url = buildURL(with: target) else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = target.method.rawValue
        
        // Set headers
        for (key, value) in target.headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        // Encode parameters
        if let parameters = try? JSONEncoder().encode(requestModel) {
            request.httpBody = parameters
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            self.hideLoading()
            
            if let error = error {
                completion(.failure(.networkError(error.localizedDescription)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.networkError("Invalid response")))
                return
            }
            
            let statusCode = httpResponse.statusCode
            if 200..<300 ~= statusCode {
                do {
                    let decodedData = try JSONDecoder().decode(X.self, from: data ?? Data())
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(.decodingError))
                }
            } else {
                completion(.failure(.serverError("Server error")))
            }
        }
        
        task.resume()
    }
    
    
    /// a generic method to perform plain requests without requestModels
    /// - Parameters:
    ///   - target: it carries the data of the request you are performing
    /// - Returns: an observable of type Result --> may carry a success or failure response
    func performRequest<X: Decodable>(target: T, completion: @escaping (Result<X, APIError>) -> Void) {
        if loadingCheck ?? true {
            Loading.shared.showLoading()
        }
        
        guard let url = buildURL(with: target) else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = target.method.rawValue
        request.allHTTPHeaderFields = target.headers
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            self.hideLoading()
            
            if let error = error {
                completion(.failure(.networkError(error.localizedDescription)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.networkError("Invalid response")))
                return
            }
            
            let statusCode = httpResponse.statusCode
            if 200..<300 ~= statusCode {
                do {
                    let decodedData = try JSONDecoder().decode(X.self, from: data ?? Data())
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(.decodingError))
                }
            } else {
                completion(.failure(.serverError("Server error")))
            }
        }
        
        task.resume()
    }
    
    private func buildURL(with target: T) -> URL? {
        let urlString = "\(baseURL)\(target.path)?api_key=\(apiKey)"
        return URL(string: urlString)
    }
    
    func hideLoading(){
        if self.loadingCheck ?? true{
            Loading.shared.hideProgressView()
        }
    }
}


struct MultiPartData{
    var keyName: String
    var fileData: Data
    var mimeType: String
    var fileName: String
}


extension Encodable{
    
    /// encode class that confirm Encodable to Data to send it to HTTP body
    var encode : Data?{
        do {
            return try JSONEncoder().encode(self)
        }catch{
            return nil
        }
    }
    
    /// convert encodable model to [String: Any]
    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw NSError()
        }
        return dictionary
    }
}

//MARK: - Download and caching Images
extension APIClient {
    private var imageCache: NSCache<NSString, UIImage> {
         let cache = NSCache<NSString, UIImage>()
         cache.countLimit = 100
         return cache
     }
     
     func downloadAndCacheImage(from url: URL, completion: @escaping (Result<UIImage, APIError>) -> Void) {
         // Check if image is already cached
         if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
             completion(.success(cachedImage))
             return
         }
         
         let task = URLSession.shared.dataTask(with: url) { data, response, error in
             if let error = error {
                 completion(.failure(.networkError(error.localizedDescription)))
                 return
             }
             
             guard let httpResponse = response as? HTTPURLResponse,
                   (200..<300).contains(httpResponse.statusCode),
                   let imageData = data,
                   let image = UIImage(data: imageData) else {
                 completion(.failure(.serverError("Failed to download image")))
                 return
             }
             
             // Cache the downloaded image
             self.imageCache.setObject(image, forKey: url.absoluteString as NSString)
             
             completion(.success(image))
         }
         
         task.resume()
     }
 }

