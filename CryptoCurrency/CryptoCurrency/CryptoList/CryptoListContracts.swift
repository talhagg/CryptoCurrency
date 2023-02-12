//
//  CryptoListContracts.swift
//  CryptoCurrency
//
//  Created by Talha Gölcügezli on 10.02.2023.
//

import Foundation


protocol CryptoListViewModelProtocol : class {
    var delegate : CryptoListViewModelDelegate? { get set }
    func load()
    func selectedCrypto(at index: Int)
}

enum CryptoListViewModelOutput {
    case isLoading(Bool)
    case showCryptoList([CryptoPresentation])
}

protocol CryptoListViewModelDelegate : class {
    func handleViewOutput(_ output: CryptoListViewModelOutput)
}
