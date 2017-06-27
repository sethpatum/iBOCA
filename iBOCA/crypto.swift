//
//  crypto.swift
//  iBOCA
//
//  Created by saman on 6/26/17.
//  Copyright © 2017 sunspot. All rights reserved.
//


import Foundation
import Security
import CryptoSwift

let key = "passwordpassword"
let initvec = "drowssapdrowssap"
let header = "AES00"

func encryptString(str : String) -> Data {
    
    do {
        let aes = try AES(key: key, iv: initvec)
        let ciphertext = try aes.encrypt(Array(str.utf8))
        return Data(bytes: ciphertext)
    } catch { }
    return Data()
}


 
