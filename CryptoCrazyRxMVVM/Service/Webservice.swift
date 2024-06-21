//
//  Webservice.swift
//  CryptoCrazyRxMVVM
//
//  Created by Mustafa DANIŞAN on 9.06.2024.
//

import Foundation

// JSON Data'sından gelecek hataları tanımlıyoruz
enum CryptoError : Error {
    case serverError
    case parsingError
}

// WebService ' yi oluşturuyoruz ve data'yı işliyoruz
class Webservice {
    
    func downloadCurrrencies (url : URL , completion : @escaping (Result<[Crypto],CryptoError>) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let _ = error {
                completion(.failure(.serverError))
            } else if let data = data {
                let cryptoList = try? JSONDecoder().decode([Crypto].self, from: data)
                if let cryptoList = cryptoList {
                    completion(.success(cryptoList))
                } else {
                    completion(.failure(.parsingError))
                }
            }
            
        }.resume()
    }
    
}
