//
//  BaseNetworkManager.swift
//  NewsAppTask
//
//  Created by Rajeswaran on 11/08/19.
//  Copyright © 2019 Rajes. All rights reserved.
//

import Foundation

class BaseNetworkManager{
    
    let router = Router()
    
    func baseServiceRequest<T:Decodable>(route:EndPointType, decoder: T.Type, completion:@escaping (GenericResponseData<T, APIError>) -> Void){
        
        print("Input param \(route)")
        router.request(route) { data, response, error  in
            if error != nil {
                //completion(nil, "Please check your network connection.")
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(.failure(.invalidData))
                        return
                    }
                    do {
                        print(responseData)
                        
                        let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                        print(jsonData)
                        let apiResponse = try JSONDecoder().decode(T.self, from: responseData)
                        completion(.success(apiResponse))
                    }catch {
                        print(error)
                        completion(.failure(.jsonConversionFailure))
                    }
                case .failure(let error):
                    print(error)
                    if error == NetworkResponse.authenticationError.rawValue{
                       
                    }
                    completion(.failure(.responseUnsuccessful))
                }
            }
        }
    }
    
    
    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String>{
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
    
}

enum NetworkResponse:String {
    case success
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
}
