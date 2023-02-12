//
//  CryptoDetailVC.swift
//  CryptoCurrency
//
//  Created by Talha Gölcügezli on 12.02.2023.
//

import UIKit
import SDWebImageSVGCoder

class CryptoDetailVC: UIViewController {

    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var detailNameLabel: UILabel!
    @IBOutlet weak var detailSymbolLabel: UILabel!
    @IBOutlet weak var detailPriceLabel: UILabel!
    @IBOutlet weak var detailChangeLabel: UILabel!
    
    var viewModel : CryptoDetailListViewModelProtocol! 
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.delegate = self
        viewModel.load()
        
        let SVGCoder = SDImageSVGCoder.shared
        SDImageCodersManager.shared.addCoder(SVGCoder)
    }
    

}

extension CryptoDetailVC : CryptoDetailListViewModelDelegate {
    func showDetail(_ presentation: CryptoPresentation) {
        detailImageView.sd_setImage(with: URL(string: presentation.image))
        detailSymbolLabel.text = presentation.name
        detailNameLabel.text = presentation.symbol
        detailPriceLabel.text = "$ \(presentation.price)"
        detailChangeLabel.text = "% \(presentation.change)"
    }
    
    
}
