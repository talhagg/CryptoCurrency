//
//  CryptoListViewModel.swift
//  CryptoCurrency
//
//  Created by Talha Gölcügezli on 10.02.2023.
//

import Foundation
import CryptoCrazyAPI

final class CryptoListViewModel : CryptoListViewModelProtocol {
    var delegate: CryptoListViewModelDelegate?
    
    private let service : TopCoinsServiceProtocol!
    
    init(service: TopCoinsServiceProtocol) {
        self.service = service
    }
    
    var cryptoListData : [Coins] = []
    
    func load() {
        notify(.updateTitle("Coins"))
        notify(.isLoading(false))
        service.fetchData(url: Util.Coins.url) { result in
            self.notify(.isLoading(true))
            switch result {
            case .success(let success):
                let data = success.map(CryptoPresentation.init)
                self.notify(.showCryptoList(data))
                self.cryptoListData = success
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func selectedCrypto(_ crypto: CryptoPresentation) {
        //let coins = cryptoListData[index]
        let viewModel = CryptoDetailListViewModel(coins: crypto)
        delegate?.navigate(to: .detail(viewModel))
    }
    
    private func notify(_ output: CryptoListViewModelOutput) {
        delegate?.handleViewOutput(output)
    }
    
}
