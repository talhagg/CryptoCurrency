//
//  CryptoListCell.swift
//  CryptoCurrency
//
//  Created by Talha Gölcügezli on 10.02.2023.
//

import UIKit
import SDWebImage

class CryptoListCell: UITableViewCell {


    @IBOutlet weak var cellCurrencyLabel: UILabel!
    
    @IBOutlet weak var cellPriceLabel: UILabel!
    @IBOutlet weak var cellNameLabel: UILabel!
    @IBOutlet weak var cellSymbolLabel: UILabel!
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var cellView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        cellView.layer.cornerRadius = 40
        cellView.layer.masksToBounds = true

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(coins : CryptoPresentation) {

        let priceString = coins.price.replacingOccurrences(of: ",", with: "")
        
        cellNameLabel.text = coins.name
        cellSymbolLabel.text = coins.symbol
        
        cellCurrencyLabel.text = "% \(coins.change)"
        cellImageView.sd_setImage(with: URL(string: coins.image))
        
        if let number = Float(priceString) {
            let formattedNumber = String(format: "%.2f", number)
            cellPriceLabel.text = "$ \(formattedNumber)" 
        }
       
        let price = Float(priceString) ?? 0.0
        if price < 0 {
            cellCurrencyLabel.textColor = .red
        } else {
            cellCurrencyLabel.textColor = UIColor.systemGreen
        }

    }

}
