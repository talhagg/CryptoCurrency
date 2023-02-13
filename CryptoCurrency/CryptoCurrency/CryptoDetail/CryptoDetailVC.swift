//
//  CryptoDetailVC.swift
//  CryptoCurrency
//
//  Created by Talha Gölcügezli on 12.02.2023.
//

import UIKit
import SDWebImageSVGCoder
import Charts

class CryptoDetailVC: UIViewController, ChartViewDelegate{
    
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var detailSymbolLabel: UILabel!
    @IBOutlet weak var detailNameLabel: UILabel!
    @IBOutlet weak var detailPriceLabel: UILabel!
    @IBOutlet weak var detailChangeLabel: UILabel!
    
    
    @IBOutlet weak var barChartView: UIView!
    var barChart = LineChartView()
    
    var viewModel : CryptoDetailListViewModelProtocol!
    private var presentation : CryptoPresentation!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        barChart.delegate = self
        
        viewModel.delegate = self
        viewModel.load()
        
        title = "Detail"
        
        barChartView.addSubview(barChart)
        
        let SVGCoder = SDImageSVGCoder.shared
        SDImageCodersManager.shared.addCoder(SVGCoder)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let chartDescription = Description()
        chartDescription.text = "Past Values"
        barChart.chartDescription = chartDescription
        
        barChart.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        barChart.frame = CGRect(x: 0, y: 0, width: barChartView.frame.size.width, height: barChartView.frame.size.width)
        
        var entries = [BarChartDataEntry]()
        
        let doubleArray = presentation.sparkline.map({Double($0) ?? 0.0})
        
        for x in doubleArray {
            entries.append(BarChartDataEntry(x: x, y: x))
        }
        
        
        let set = LineChartDataSet(entries: entries)
        set.colors = ChartColorTemplates.material()
        
        let data = LineChartData(dataSet: set)
        barChart.delegate = self
        barChart.data = data
        
    }
    
    
    
}



extension CryptoDetailVC : CryptoDetailListViewModelDelegate {
    func showDetail(_ presentation: CryptoPresentation) {
        
        let priceString = presentation.price.replacingOccurrences(of: ",", with: "")
        self.presentation = presentation
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


