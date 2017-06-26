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

func encryptString(str : String) -> Data {
    
    do {
        let aes = try AES(key: "passwordpassword", iv: "drowssapdrowssap") // aes128
        let ciphertext = try aes.encrypt(Array(str.utf8))
        return Data(bytes: ciphertext)
    } catch { }
    return Data()
}

 
