//
//  Coins.swift
//  CryptoCrazyAPI
//
//  Created by Talha Gölcügezli on 5.02.2023.
//


import Foundation


public struct Coins : Decodable {
    
    public enum CodingKeys : String, CodingKey {
        case uuid, symbol, name
        case image = "iconUrl"
        case sparkline, marketCap, price, change
    }
    
    public let uuid : String
    public let symbol : String
    public let name : String
    public let image : String
    public let sparkline : [String]
    public let marketCap : String
    public let price : String
    public let change : String
    
}
