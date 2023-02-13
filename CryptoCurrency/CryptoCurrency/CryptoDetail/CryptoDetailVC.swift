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
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var detailSymbolLabel: UILabel!
    @IBOutlet weak var detailNameLabel: UILabel!
    @IBOutlet weak var detailPriceLabel: UILabel!
    @IBOutlet weak var detailChangeLabel: UILabel!
    
    var viewModel : CryptoDetailListViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.delegate = self
        viewModel.load()
        
        title = "Detail"
        
        let SVGCoder = SDImageSVGCoder.shared
        SDImageCodersManager.shared.addCoder(SVGCoder)
    }
    

}

extension CryptoDetailVC : CryptoDetailListViewModelDelegate {
    func showDetail(_ presentation: CryptoPresentation) {
        
        let priceString = presentation.price.replacingOccurrences(of: ",", with: "")
        
        detailNameLabel.text = presentation.name
        detailSymbolLabel.text = presentation.symbol
        
        if let number = Float(priceString) {
            let formattedNumber = String(format: "%.2f", number)
            detailPriceLabel.text = "$ \(formattedNumber)"
        }
        
        let change = Float(presentation.change) ?? 0.0
        if change < 0 {
            detailChangeLabel.textColor = UIColor.systemRed
        } else {
            detailChangeLabel.textColor = UIColor.systemGreen
        }
        
        detailChangeLabel.text = "% \(presentation.change)"
        detailImageView.sd_setImage(with: URL(string: presentation.image))
        
    }
    
    
}
