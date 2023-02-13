//
//  Coins.swift
//  CryptoCrazyAPI
//
//  Created by Talha Gölcügezli on 5.02.2023.
//

/*
 
 "coins": [
 {
 "uuid": "Qwsogvtv82FCd",
 "symbol": "BTC",
 "name": "Bitcoin",
 "color": "#f7931A",
 "iconUrl": "https://cdn.coinranking.com/bOabBYkcX/bitcoin_btc.svg",
 "marketCap": "1064845170034",
 "price": "56373.67522635439",
 "listedAt": 1330214400,
 "tier": 1,
 "change": "-3.61",
 "rank": 1,
 "sparkline": [

 ],
 "lowVolume": false,
 "coinrankingUrl": "https://coinranking.com/coin/Qwsogvtv82FCd+bitcoin-btc",
 "24hVolume": "39591261551",
 "btcPrice": "1"
 
 */

import Foundation


public struct Coins : Decodable {
    
    public enum CodingKeys : String, CodingKey {
        case uuid, symbol, name
        case image = "iconUrl"
        case marketCap, price, change
    }
    
    public let uuid : String
    public let symbol : String
    public let name : String
    public let image : String
    public let marketCap : String
    public let price : String
    public let change : String
    
}
