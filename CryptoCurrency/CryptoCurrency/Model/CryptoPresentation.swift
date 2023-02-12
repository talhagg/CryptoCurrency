//
//  CryptoPresentation.swift
//  CryptoCurrency
//
//  Created by Talha Gölcügezli on 10.02.2023.
//

import Foundation
import CryptoCrazyAPI

public struct CryptoPresentation {
    let uuid : String
    let symbol : String
    let name : String
    let image : String
    let price : String
    let change : String
}

extension CryptoPresentation {
    init(coins: Coins) {
        self.init(uuid: coins.uuid, symbol: coins.symbol, name: coins.name, image: coins.image, price: coins.price, change: coins.change)
    }
}
