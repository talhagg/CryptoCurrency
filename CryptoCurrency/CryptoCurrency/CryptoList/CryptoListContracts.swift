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
    func selectedCrypto(_ crypto: CryptoPresentation)
}

enum CryptoListViewModelOutput {
    case updateTitle(String)
    case isLoading(Bool)
    case showCryptoList([CryptoPresentation])
}

enum CryptoListViewRoute {
    case detail(CryptoDetailListViewModelProtocol)
}

protocol CryptoListViewModelDelegate : class {
    func handleViewOutput(_ output: CryptoListViewModelOutput)
    func navigate(to route: CryptoListViewRoute)
}
