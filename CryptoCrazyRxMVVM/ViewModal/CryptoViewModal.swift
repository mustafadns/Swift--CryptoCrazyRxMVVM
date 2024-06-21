//
//  CryptoViewModal.swift
//  CryptoCrazyRxMVVM
//
//  Created by Mustafa DANIŞAN on 9.06.2024.
//

import Foundation
import RxSwift
import RxCocoa


// ViewController sayfasında tableView'e tanımlanacak veriler bu kısımda oluşturuluyor ve tableView sayfası boş yere doldurulmuyor
class CryptoViewModal {
    
    // Data'nın tanımlaması
    let cryptos : PublishSubject<[Crypto]> = PublishSubject()
    
    // Hata'nın tanımlaması
    let error : PublishSubject<String> = PublishSubject()
    
    // Loading işaretinin tanımlanması
    let loading : PublishSubject<Bool> = PublishSubject()
    
    // Data'nın tekrardan tanımlanması
    func requestData () {
        self.loading.onNext(true)
        let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!
        Webservice().downloadCurrrencies(url: url) { result in
            self.loading.onNext(false)
            switch result {
            case .success(let cryptos):
                self.cryptos.onNext(cryptos)
            case .failure(let error):
                switch error {
                case .parsingError:
                    self.error.onNext("Parsing Error")
                case .serverError:
                    self.error.onNext("Server Error")
                }
            }
        }
    }
    
}
