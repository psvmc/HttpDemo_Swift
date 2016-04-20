//
//  AlamofireSwiftyJSON.swift
//  AlamofireSwiftyJSON
//
//  Created by Pinglin Tang on 14-9-22.
//  Copyright (c) 2014 SwiftyJSON. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


// MARK: - Request for Swift JSON

extension Request {
    
    public func responseSwiftyJSON(completionHandler: (NSURLRequest, NSHTTPURLResponse?, JSON, NSError?) -> Void) -> Self {
        return responseSwiftyJSON(nil, options:NSJSONReadingOptions.AllowFragments, completionHandler:completionHandler)
    }
    
    public func responseSwiftyJSON(queue: dispatch_queue_t? = nil, options: NSJSONReadingOptions = .AllowFragments, completionHandler: (NSURLRequest, NSHTTPURLResponse?, JSON, NSError?) -> Void) -> Self {
        
        return response(queue: queue, responseSerializer: Request.JSONResponseSerializer(options: options), completionHandler: {
            responseResult -> Void in

            let result = responseResult.result;
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
                var responseJSON: JSON
                if result.isFailure
                {
                    responseJSON = JSON.null
                } else {
                    responseJSON = JSON(result.value!)
                }
                dispatch_async(queue ?? dispatch_get_main_queue(), {
                    completionHandler(self.request!, self.response, responseJSON, result.error)
                })
            })
        })
    }
}