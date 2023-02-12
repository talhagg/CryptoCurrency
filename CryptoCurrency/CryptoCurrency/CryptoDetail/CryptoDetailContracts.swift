//
//  CryptoDetailContracts.swift
//  CryptoCurrency
//
//  Created by Talha Gölcügezli on 12.02.2023.
//

import Foundation

protocol CryptoDetailListViewModelProtocol {
    var delegate : CryptoDetailListViewModelDelegate? { get set }
    func load()
}

protocol CryptoDetailListViewModelDelegate : class {
    func showDetail(_ presentation: CryptoPresentation)
}
