//
//  CryptoListVC.swift
//  CryptoCurrency
//
//  Created by Talha Gölcügezli on 10.02.2023.
//

import UIKit


class CryptoListVC: UIViewController {

    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
        }
    }
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    
    var viewModel : CryptoListViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    
    @IBOutlet weak var filterButton: UIButton!
    
    let refreshControl = UIRefreshControl()
    private var cryptoList : [CryptoPresentation] = []
    private var filterList : [CryptoPresentation] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)

        viewModel.load()
    
        tableView.refreshControl = refreshControl

        setupMenu()
    }
    
}


extension CryptoListVC : CryptoListViewModelDelegate {
    func navigate(to route: CryptoListViewRoute) {
        switch route {
        case .detail(let cryptoDetailListViewModelProtocol):
            let viewController = CryptoDetailBuilder.make(with: cryptoDetailListViewModelProtocol)
            show(viewController, sender: nil)
        }
    }
    
    func handleViewOutput(_ output: CryptoListViewModelOutput) {
        switch output {
        case .isLoading(let bool):
            loadingView.startAnimating()
            loadingView.isHidden = bool
        case .showCryptoList(let array):
            self.cryptoList = array
            self.filterList = array
            self.tableView.reloadData()
        case .updateTitle(let title):
            self.title = title
        }
    }
    
    
}


extension CryptoListVC : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cryptoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CoinsCell", for: indexPath) as! CryptoListCell
        let cryptos = cryptoList[indexPath.row]
    
        cell.setup(coins: cryptos)
    
        return cell
    }
    
  
    
}

extension CryptoListVC : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let crypto = cryptoList[indexPath.row]
        viewModel.selectedCrypto(crypto)
    }
    
   
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, 0, -500, 0)
        cell.layer.transform  = rotationTransform
        cell.alpha = 0.25
        
        UIView.animate(withDuration: 0.5) {
            cell.layer.transform = CATransform3DIdentity
            cell.alpha = 1.0
        }
    }
    
}


extension CryptoListVC {
    
    func setupMenu() {
        let optionClosure = {(action: UIAction) in
            
            if action.title == "Price" {
                self.sortedPrice()
            } else if action.title == "Change" {
                self.sortedCurrency()
            } else if action.title == "Name" {
                self.sortedName()
            } else if action.title == "Market Cap" {
                self.sortedMarketCap()
            }
        }
        
        filterButton.menu = UIMenu(children: [
            UIAction(title: "Price", state: .on, handler: optionClosure),
            UIAction(title: "Change", state: .on, handler: optionClosure),
            UIAction(title: "Market Cap", state: .on, handler: optionClosure),
            UIAction(title: "Name", state: .on, handler: optionClosure)
        ])
        
        filterButton.showsLargeContentViewer = true
        filterButton.showsMenuAsPrimaryAction = true
        filterButton.changesSelectionAsPrimaryAction = true
    }
    
    func sortedPrice() {
        cryptoList.sort { coinOne, coinTwo in
            let priceOne = Double(String(format: "%.2f", Double(coinOne.price.replacingOccurrences(of: ",", with: "")) ?? 0.0)) ?? 0.0
            let priceTwo = Double(String(format: "%.2f", Double(coinTwo.price.replacingOccurrences(of: ",", with: "")) ?? 0.0)) ?? 0.0
            return priceOne > priceTwo
        }
        tableView.reloadData()
    }
    
    func sortedCurrency() {
        cryptoList.sort { coinOne, coinTwo in
            let changeOne = Double(String(format: "%.2f", Double(coinOne.change.replacingOccurrences(of: ",", with: "")) ?? 0.0)) ?? 0.0
            let changeTwo = Double(String(format: "%.2f", Double(coinTwo.change.replacingOccurrences(of: ",", with: "")) ?? 0.0)) ?? 0.0
            return changeOne > changeTwo
        }
        tableView.reloadData()
    }
    
    func sortedName() {
        cryptoList.sort { coinOne, coinTwo in
            return coinOne.name < coinTwo.name
        }
        tableView.reloadData()
    }
    
    func sortedMarketCap() {
        cryptoList.sort { coinOne, coinTwo in
            let marketOne = Int(coinOne.marketCap) ?? 0
            let marketTwo = Int(coinTwo.marketCap) ?? 0
            return marketOne > marketTwo
        }
        tableView.reloadData()
    }
    
    
    @objc func refreshData() {
        viewModel.load()
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
}

extension CryptoListVC : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            cryptoList = filterList
        } else {
            cryptoList = filterList.filter({ crypto in
                if crypto.name.range(of: searchText, options: .caseInsensitive) != nil {
                    return true
                } else if crypto.symbol.range(of: searchText, options: .caseInsensitive) != nil {
                    return true
                } else {
                    return false
                }
                    
            })
        }
       
        self.tableView.reloadData()
    }
}
