//
//  TopCoinsService.swift
//  CryptoCrazyAPI
//
//  Created by Talha Gölcügezli on 5.02.2023.
//

import Foundation
import Alamofire

public protocol TopCoinsServiceProtocol {
    func fetchData(url: String, completion: @escaping(Result<[Coins],Error>)->Void)
}


public final class TopCoinsService : TopCoinsServiceProtocol {
    
    private enum CoinsError : Error {
        case NetworkError
        case SeriError
    }
    
    public init() { }
    
    public func fetchData(url: String, completion: @escaping (Result<[Coins], Error>) -> Void) {
        let headers: HTTPHeaders = ["x-access-token" : "coinranking5c55ea59ccbe63178b18e3622fdbacbc694071f84d7e803b"]
        
        AF.request(url, headers: headers).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let result = try JSONDecoder().decode(TopCoinsResponse.self, from: data)
                    let coinsData = result.coinsResult
                    completion(.success(coinsData))
                }catch {
                    completion(.failure(CoinsError.SeriError))
                }
            case .failure(let error):
                completion(.failure(CoinsError.NetworkError))
            }
        }
    }
    
    
}
