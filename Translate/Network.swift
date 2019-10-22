//
//  Network.swift
//  Translate
//
//  Created by 任成 on 2019/10/21.
//  Copyright © 2019 rencheng Inc. All rights reserved.
//

import UIKit
import Alamofire

enum TranslateMode: String {
    case AUTO = "AUTO|AUTO"
    case C2E = "zh-CHS|en"
    case E2C = "en|zh-CHS"
}

class Network: NSObject {
    public static func requestByYoudao(str: String, mode: TranslateMode, responseData: @escaping ((Dictionary<String, Any>?) -> Void)) {
        let url = "http://fanyi.youdao.com/translate?smartresult=dict,smartresult=rule"
        let params = ["i":str,
                      "from":mode.rawValue.components(separatedBy: "|")[0],
                      "to":mode.rawValue.components(separatedBy: "|")[1],
                      "smartresult":"dict",
                      "client":"fanyideskweb",
                      "salt":"15716460075055",
                      "sign":"cbe60e955e831efb5c9845f1f50ee58a",
                      "doctype":"json",
                      "version":"2.1",
                      "keyfrom":"fanyi.web",
                      "ts": "1571646007505",
                      "bv": "8c395d30daa835d2e26b51eb2ce21fc5",
                      "action":"FY_BY_REALTIME"]
        let headers: HTTPHeaders = ["User-Agent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36"]
        let request = AF.request(url, method: .get, parameters: params, encoding: URLEncoding.default, headers: headers)
        print(params)
        request.responseJSON { (response) in
            let res = response.value;
            if let a = res {
                print(a)
                responseData(a as? Dictionary)
            } else {
                responseData(nil)
            }
        }
    }
    
    public static func requestByGoogle(str: String, responseData: @escaping ((Dictionary<String, Any>?) -> Void)) {
        let url = "https://translate.google.cn/translate_a/single?client=webapp&sl=auto&tl=en&hl=zh-CN&dt=at&dt=bd&dt=ex&dt=ld&dt=md&dt=qca&dt=rw&dt=rm&dt=ss&dt=t&dt=gt&ssel=3&tsel=3&kc=0&tk=830003.656228&q=%E7%BE%8E%E4%B8%BD"
        let params = ["client":"webapp",
                      "sl":"auto",
                      "tl":"en",
                      "hl":"zh-CN",
//                      "dt":"at",
//                      "dt":"bd",
//                      "dt":"ex",
//                      "dt":"ld",
//                      "dt":"md",
//                      "dt":"qca",
//                      "dt":"rw",
//                      "dt":"rm",
//                      "dt":"ss",
//                      "dt":"t",
                      "dt":"gt",
                      "ssel":"3",
                      "tsel":"3",
                      "kc":"0",
                      "tk":"830003.656228",
                      "q":"%E7%BE%8E%E4%B8%BD"]
        let headers: HTTPHeaders = ["User-Agent":"Mozilla/5.0"]
        let request = AF.request(url, method: .get, parameters: params, encoding: URLEncoding.default, headers: headers)
        request.responseJSON { (response) in
            let res = response.value;
            if let a = res {
                print(a)
                responseData(a as? Dictionary)
            } else {
                responseData(nil)
            }
        }
    }
}
