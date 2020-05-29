//
//  TestService.swift
//  siciDemo
//
//  Created by iOS on 2020/5/6.
//  Copyright © 2020 123. All rights reserved.
//

import Foundation

class TestService {
    /// 获取token
    ///
    /// - Parameters:
    ///   - callback: 成功后回调
    static func getToken(callback: @escaping(Bool, String?) -> ()) {
        ServiceManager.shared.get(path: "https://v2.jinrishici.com/token", parameters: nil) { (response, result) in
            
            guard let result = result else {
                callback(false, "kNetworkErrorStr")
                return
            }

            let status = result["status"].stringValue
            let token = result["data"].stringValue
            
            UserDefaults.standard.set(token, forKey: "TOKEN")
            
            callback(status == "success", token)
        }
    }
    
    /// 获取token
    ///
    /// - Parameters:
    ///   - callback: 成功后回调
    static func getSentence(callback: @escaping(Bool, String, String?) -> ()) {
        ServiceManager.shared.get(path: "https://v2.jinrishici.com/sentence", parameters: nil) { (response, result) in
            
            guard let result = result else {
                callback(false, "kNetworkErrorStr", "")
                return
            }

            let status = result["status"].stringValue
            
            callback(status == "success", "", "")
        }
    }
}
