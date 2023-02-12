//
//  TopCoinsResponse.swift
//  CryptoCrazyAPI
//
//  Created by Talha Gölcügezli on 5.02.2023.
//

import Foundation


public final class TopCoinsResponse: Decodable {
    
    private enum DataContainer : String, CodingKey{
        case data
    }
    
    private enum CoinsContainer : String, CodingKey {
        case coins
    }
    
    public let coinsResult : [Coins]
    
    public init(from decoder: Decoder) throws {
        let dataContainer = try decoder.container(keyedBy: DataContainer.self)
        let coinsContainer = try dataContainer.nestedContainer(keyedBy: CoinsContainer.self, forKey: .data)
        self.coinsResult = try coinsContainer.decode([Coins].self, forKey: .coins)
        
    }
    
}
