//
//  Crypto.swift
//  CryptoCrazyRxMVVM
//
//  Created by Mustafa DANIŞAN on 8.06.2024.
//

import Foundation


// Codebale de yapılabilir ...
// JSON Data'sından gelecek veriyi tanımlıyoruz NOT: İsimlendirmeler uyuşması lazım
struct Crypto : Decodable {
    let currency : String
    let price : String
}
