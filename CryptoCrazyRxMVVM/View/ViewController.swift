//
//  ViewController.swift
//  CryptoCrazyRxMVVM
//
//  Created by Mustafa DANIŞAN on 8.06.2024.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController, UITableViewDelegate {
    
    // UITableViewDataSource kısmı zor yöntemi kullanmak için silindi

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    let cryptoVM = CryptoViewModal()
    let disposeBag = DisposeBag()
    var cryptoList = [Crypto]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Data ekrana bastırılırken kullanılan basit yöntem delegasyon işlemleri
        // tableView.delegate = self
        // tableView.dataSource = self
        
        view.backgroundColor = .black
        // rx delegasyon işlemi
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        // fonksiyonların çalıştırılması
        setupBindings()
        cryptoVM.requestData()
    }
    
    // Data'dan gele verilerin tanımlanarak gösterilme işlemi
    private func setupBindings () {
        
        // Loading işaretinin ekrana getirilmesi
        cryptoVM
            .loading
            .bind(to: self.indicatorView.rx.isAnimating)
            .disposed(by: disposeBag)
        
        // Error durumunun ekrana getirilmesi
        cryptoVM
            .error
            .observe(on: MainScheduler.asyncInstance)
            .subscribe { errorString in
                print(errorString)
            }
            .disposed(by: disposeBag)
        
        // Data'daki bilgilerin ekrana getirilmesinin kolay yöntemi
//        cryptoVM
//            .cryptos
//            .observe(on: MainScheduler.asyncInstance)
//            .subscribe { cryptos in
//                self.cryptoList = cryptos
//                self.tableView.reloadData()
//            }
//            .disposed(by: disposeBag)
        
        // Data'nın ekrana getirilmesinin zor ve sektörde en çok kullanılan yöntemi
        cryptoVM
            .cryptos
            .observe(on: MainScheduler.asyncInstance)
            .bind(to: tableView.rx.items(cellIdentifier: "CryptoCell", cellType: CryptoTableViewCell.self)) {row,item,cell in
                cell.item = item
            }
            .disposed(by: disposeBag)
        
    }
    
    // Her bir dataya ayrı ayrı yükseklik verilmesi
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    // Data'nın kolay yöntemle ekrana getirilmesi işleminde kullanılan fonksiyonlar
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return cryptoList.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell()
//        var content = cell.defaultContentConfiguration()
//        content.text = cryptoList[indexPath.row].currency
//        content.secondaryText = cryptoList[indexPath.row].price
//        cell.contentConfiguration = content
//        
//        return cell
//    }

}

