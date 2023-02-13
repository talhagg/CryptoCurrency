//
//  CryptoDetailViewModel.swift
//  CryptoCurrency
//
//  Created by Talha Gölcügezli on 12.02.2023.
//

import Foundation
import CryptoCrazyAPI

final class CryptoDetailListViewModel : CryptoDetailListViewModelProtocol {
    var delegate: CryptoDetailListViewModelDelegate?
    private let presentation : CryptoPresentation
    
    init(coins: CryptoPresentation) {
        self.presentation = coins
    }
    
    func load() {
        delegate?.showDetail(presentation)
    }
    
    
}
