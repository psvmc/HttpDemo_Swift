//
//  ViewController.swift
//  HttpDemo_Swift
//
//  Created by 张剑 on 16/4/20.
//  Copyright © 2016年 张剑. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

class ViewController: UIViewController {

    @IBOutlet weak var showTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    /**
     Alamofire + ObjectMapper + AlamofireObjectMapper 组合
     - parameter sender:
     */
    @IBAction func queryDataModelClick(sender: AnyObject) {
        let apiBaseUrl = "http://t.yidaisong.com:90/";
        let parameters:[String:AnyObject] = [
            "userPhone": "15225178360",
            "userLoginPswd":"123456"
        ];
        let url = apiBaseUrl+"login!in.do";
        request(Method.POST, url, parameters: parameters).responseObject { (response: Response<ZJResult<ZJUser>, NSError>) in
            if(response.result.error != nil){
                self.showTextView.text = "请求出错";
            }else{
                let result:ZJResult = response.result.value!;
                if(result.success == "true"){
                    self.showTextView.text = "\(result.toJSONString()!)";
                    print("用户名为：\(result.obj!.userName)")
                }else{
                    self.showTextView.text = "\(result.msg)";
                }
            }
            
        }
    }
    
    /**
     Alamofire + SwiftyJSON + Alamofire-SwiftyJSON 组合
     - parameter sender:
     */
    @IBAction func queryDataClick(sender: AnyObject) {
        let apiBaseUrl = "http://t.yidaisong.com:90/";
        let parameters:[String:AnyObject] = [
            "userPhone": "15225178360",
            "userLoginPswd":"123456"
        ];
        let url = apiBaseUrl+"login!in.do";
        
        request(Method.POST, url, parameters: parameters).responseSwiftyJSON({ request, response, data, error in
            if(error != nil){
                self.showTextView.text = "请求出错";
            }else{
                if(data["success"]){
                    self.showTextView.text = "\(data)";
                    print("用户名为：\(data["obj"]["userName"].stringValue)")
                }else{
                    self.showTextView.text = "\(data["msg"].stringValue)";
                }
            }
            
        })
        

    }
}

