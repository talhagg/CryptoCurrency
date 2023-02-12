//
//  CryptoListBuilder.swift
//  CryptoCurrency
//
//  Created by Talha Gölcügezli on 11.02.2023.
//

import UIKit
import CryptoCrazyAPI

final class CryptoListBuilder {
    
    static func make() -> CryptoListVC {
        let staryboard = UIStoryboard(name: "CryptoVC", bundle: nil)
        let view = staryboard.instantiateViewController(withIdentifier: "CryptoVC") as! CryptoListVC
        let service = TopCoinsService()
        view.viewModel = CryptoListViewModel(service: service)
        
        return view
    }
}


