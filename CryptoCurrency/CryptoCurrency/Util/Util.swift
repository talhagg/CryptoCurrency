//
//  Util.swift
//  CryptoCurrency
//
//  Created by Talha Gölcügezli on 7.02.2023.
//

import Foundation

public struct Util {
    public struct Coins {
        static let baseUrl = "https://api.coinranking.com/v2"
        static let coins = "/coins"
        static let url = "\(baseUrl)\(coins)"
    }
}
