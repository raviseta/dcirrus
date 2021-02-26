//
//  APIManager.swift
//  Yoface
//
//  Created by Yobored on 05/03/20.
//  Copyright © 2020 yobored. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class APIManager {
    
    class var shared : APIManager {
        struct Static {
            static let instance : APIManager = APIManager()
        }
        return Static.instance
    }
    
    func toDictionary(modelObject: Any) -> [String : Any] {
        var dictionary = [String:Any]()
        let otherSelf = Mirror(reflecting: modelObject)
        for child in otherSelf.children {
            if let key = child.label {
                dictionary[key] = child.value
            }
        }
        print("USER_DICTIONARY :: \(dictionary.description)")
        return dictionary
    }
    
    func requestPostJSON(url:eAppURL,parameters: Parameters, isShowIndicator: Bool = false,completionHandler:@escaping (_ result: Result<Any,Error>) -> Void) -> DataRequest{
        
        var header : HTTPHeaders = [:]
//        if url == eAppURL.login{
//            header = [:]
//        }else{
            header = self.getHeader()
//        }
        
       
        if isShowLog {
            print("requestURL:\(url.getURL())")
            print()
            print("dictHeader:\(header.description)")
            print("parameter:\(parameters.description)")
            print()
        }
        if isShowIndicator {
            showIndicator()
        }
        return AF.request(url.getURL(), method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: header, interceptor: nil).cURLDescription { description in
            print(description)
        }.responseJSON(queue: DispatchQueue.main, options: JSONSerialization.ReadingOptions.fragmentsAllowed) { (response) in
            if isShowIndicator {
                hideIndicator()
            }
            switch response.result {
            case .success(let finalResponse):
                if let res = finalResponse as? [String: Any] {
                    if isShowLog {
                        print()
                        print("response:\(res.description)")
                        print()
                    }
                    var statusCode: Int = 0
                    if let statusCodel = res[APIKey.messageCode] as? Int {
                        statusCode = statusCodel
                    }
                    completionHandler(.success(res))
//                    if(200...299).contains(statusCode) {
//                        completionHandler(.success(res))
//                    }else if (400...499).contains(statusCode) || (500...599).contains(statusCode) {
//                        if var message = res["message"] as? String {
//                            if message.isBlank == true {
//                                message = "Something went wrong!" + "\n" + "Please try again"
//                            }
//                            let error = NSError(domain: "Custom", code: statusCode, userInfo: [NSLocalizedDescriptionKey : message])
//                            completionHandler(.failure(error))
//                        }
//                    }
                }
                break
            case .failure(let resError):
                if let data  = response.data {
                    if let responseSting = String(data: data, encoding: String.Encoding.utf8){
                        debugPrint("Response Data  ::",responseSting)
                    }
                }
                
                if let err = resError.underlyingError as? URLError, err.code == URLError.Code.networkConnectionLost {
                    getDelayMainQueue(delay: 0.5) {
                        _ = self.requestPostJSON(url:url,parameters: parameters, isShowIndicator: isShowIndicator,completionHandler:completionHandler)
                    }
                    return
                }else if resError.isExplicitlyCancelledError == true {
                    completionHandler(.failure(resError))
                }else {
                    completionHandler(.failure(resError))
                }
                break
            }
        }
    }
    func requestGetJSON(url:eAppURL,parameters: Parameters, isShowIndicator: Bool = false,completionHandler:@escaping (_ result: Result<Any,Error>) -> Void) -> DataRequest{
        
        var header : HTTPHeaders = [:]
//        if url == eAppURL.login{
//            header = [:]
//        }else{
            header = self.getHeader()
//        }
        
       
        if isShowLog {
            print("requestURL:\(url.getURL())")
            print()
            print("dictHeader:\(header.description)")
            print("parameter:\(parameters.description)")
            print()
        }
        if isShowIndicator {
            showIndicator()
        }
        return AF.request(url.getURL(), method: HTTPMethod.get, parameters: parameters, encoding: URLEncoding.default, headers: header, interceptor: nil).cURLDescription { description in
            print(description)
        }.responseJSON(queue: DispatchQueue.main, options: JSONSerialization.ReadingOptions.fragmentsAllowed) { (response) in
            if isShowIndicator {
                hideIndicator()
            }
            switch response.result {
            case .success(let finalResponse):
                if let res = finalResponse as? [String: Any] {
                    if isShowLog {
                        print()
                        print("response:\(res.description)")
                        print()
                       
                          if let theJSONData = try?  JSONSerialization.data(
                            withJSONObject: res,
                            options: .prettyPrinted
                            ),
                            let theJSONText = String(data: theJSONData,
                                                     encoding: String.Encoding.ascii) {
                                print("JSON string = \n\(theJSONText)")
                          }
                        
                    }
                    var statusCode: Int = 0
                    if let statusCodel = res[APIKey.messageCode] as? Int {
                        statusCode = statusCodel
                    }
                    completionHandler(.success(res))
//                    if(200...299).contains(statusCode) {
//                        completionHandler(.success(res))
//                    }else if (400...499).contains(statusCode) || (500...599).contains(statusCode) {
//                        if var message = res["message"] as? String {
//                            if message.isBlank == true {
//                                message = "Something went wrong!" + "\n" + "Please try again"
//                            }
//                            let error = NSError(domain: "Custom", code: statusCode, userInfo: [NSLocalizedDescriptionKey : message])
//                            completionHandler(.failure(error))
//                        }
//                    }
                }
                break
            case .failure(let resError):
                if let data  = response.data {
                    if let responseSting = String(data: data, encoding: String.Encoding.utf8){
                        debugPrint("Response Data  ::",responseSting)
                    }
                }
                
                if let err = resError.underlyingError as? URLError, err.code == URLError.Code.networkConnectionLost {
                    getDelayMainQueue(delay: 0.5) {
                        _ = self.requestPostJSON(url:url,parameters: parameters, isShowIndicator: isShowIndicator,completionHandler:completionHandler)
                    }
                    return
                }else if resError.isExplicitlyCancelledError == true {
                    completionHandler(.failure(resError))
                }else {
                    completionHandler(.failure(resError))
                }
                break
            }
        }
    }
    
    func cancleAllRequests(completion: (() -> Void)? = nil){
        AF.cancelAllRequests(completingOnQueue: DispatchQueue.main) {
            completion?()
        }
    }
    
    //Header
    func getHeader() -> HTTPHeaders {
        var dictHeader: HTTPHeaders = [:]
        if Constants.token.isBlank == false {
            dictHeader["Authorization"] = "Bearer \(Constants.token)"
        }
        
        return dictHeader
    }
}
