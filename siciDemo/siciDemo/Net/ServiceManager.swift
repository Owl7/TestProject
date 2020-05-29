//
//  ServiceManager.swift
//  siciDemo
//
//  Created by iOS on 2020/5/6.
//  Copyright © 2020 123. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

typealias ServicesCallbackResponse = AFDataResponse<Data>
typealias ServicesCallback = (ServicesCallbackResponse, JSON?) -> Void

class ServiceManager {
    
    var accessToken: String?  // token
    
    static fileprivate var _shared = ServiceManager()
    
    static var shared: ServiceManager { return _shared }
    
    fileprivate var urlCache = { () -> URLCache in
        let capacity = 50 * 1024 * 1024 // MBs
        let urlCache = URLCache(memoryCapacity: capacity, diskCapacity: capacity, diskPath: nil)

        return urlCache
    }()
    
    fileprivate lazy var manager: Session = {
        let configuration = URLSessionConfiguration.default
//        configuration.httpAdditionalHeaders = Session
        configuration.timeoutIntervalForRequest = 10
        configuration.timeoutIntervalForResource = 10
        configuration.requestCachePolicy = .useProtocolCachePolicy
        configuration.urlCache = self.urlCache

        let ret = Session(configuration: configuration)
        return ret
    }()
    
    /// 创建请求头信息
    func getRequestHeader() -> [String: String] {
        var headerDic = [String: String]()
//        headerDic["User-Agent"] = CommonUtil.shared.createUserAgent()
        headerDic["Token"] = UserDefaults.standard.object(forKey: "TOKEN") as? String ?? ""
        return headerDic
    }
    
    /// 数据请求
    fileprivate func _request(method: HTTPMethod,
                              path: String,
                              parameters: [String: AnyObject]?,
                              callback: @escaping ServicesCallback) {
        
//        manager.request("\(path)",
//            method: method,
//            parameters: parameters,
//            headers: getRequestHeader())
//            .responseData { [weak self] (response) in
//                switch response.result {
//                case .success:
//                    YWPrint(path, parameters ?? "没有参数")
//                    self?.requestSucc(path: path, response: response, callback: callback)
//                case .failure(let error):
//                    self?.requestFailure(response: response, error: error, callback: callback)
//                }
//        }
        
        
//        URLConvertible
        
        manager.request(URL(string: path)!, method: method, parameters: parameters, headers: HTTPHeaders(getRequestHeader())).responseData { [weak self] (response) in
            switch response.result {
            case .success:
//                YWPrint(path, parameters ?? "没有参数")
                self?.requestSucc(path: path, response: response, callback: callback)
            case .failure(let error):
                self?.requestFailure(response: response, error: error, callback: callback)
            }
        }
        
//        manager.request
    }
    
    // 数据请求成功
    fileprivate func requestSucc(path: String, response: AFDataResponse<Data>, callback: ServicesCallback) {
        var result: JSON? = nil
        if let data = response.data {
            do {
                try result = JSON(data: data)
            } catch let error as NSError {
//                YWPrint("Error: \(error.domain)")
            }
        }
        
        DispatchQueue.global().async {
            
            DispatchQueue.main.async {
                
            }
        }
        
//        if path != kPrizeScrollApi {
//            YWPrint(result ?? "空数据")
//        }
        print(result ?? "空数据")
        callback(response, result)
    }
    
    // 数据请求失败
    fileprivate func requestFailure(response: AFDataResponse<Data>, error: Error, callback: ServicesCallback) {
//        YWPrint("Error: \((error as NSError).domain)")
        callback(response, nil)
    }
    
    /// get请求
    func get(path: String, parameters: [String: AnyObject]?, callback: @escaping ServicesCallback) {
        return _request(method: .get, path: path, parameters: parameters, callback: callback)
    }
    
    /// post请求
    func post(path: String, parameters: [String: AnyObject]?, callback: @escaping ServicesCallback) {
        return _request(method: .post, path: path, parameters: parameters, callback: callback)
    }
    
}
