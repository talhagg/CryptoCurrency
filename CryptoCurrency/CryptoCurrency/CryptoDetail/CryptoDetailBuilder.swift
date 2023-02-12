//
//  CryptoDetailBuilder.swift
//  CryptoCurrency
//
//  Created by Talha Gölcügezli on 12.02.2023.
//

import UIKit


final class CryptoDetailBuilder {
    
    static func make(with viewModel: CryptoDetailListViewModelProtocol) -> CryptoDetailVC {
        let storyboard = UIStoryboard(name: "CryptoDetailVC", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "CryptoDetailVC") as! CryptoDetailVC
        
        viewController.viewModel = viewModel
        
        return viewController
    }
}
