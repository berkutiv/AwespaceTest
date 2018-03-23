//
//  API_WRAPPER.swift
//  AwespaceTest
//
//  Created by Иван on 19.03.2018.
//  Copyright © 2018 Иван. All rights reserved.
//

import Foundation
import SwiftyJSON

class API_WRAPPER
{
    class func getProducts (offset: String, count: String, success : @escaping (JSON) -> Void , failure : @escaping (Int) -> Void) -> URLSessionDataTask
    {
        let urlString = "https://lampainar.ru/admin/api/v1/product/filter?offset=\(offset)&count=\(count)"
        
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.setValue(Constants.token, forHTTPHeaderField: "token")
        request.setValue(Constants.contentType, forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request, completionHandler:
            {data , response, error in
                
                self.genericCompletionCallback(data: data, response: response, error: error, success: success, failure: failure)
                
        })
        
        task.resume()
        return task
    }
    
}

//MARK: -обработчик ответов из интернета JSON
extension API_WRAPPER
{
    class func genericCompletionCallback (
        data : Data? ,
        response : URLResponse? ,
        error : Error? ,
        success : (JSON) -> Void ,
        failure : (Int) -> Void
        )
    {
        if (error != nil)
        {
            failure( (error as! NSError).code )
            return
        }
        if let rawData = data
        {
            do
            {
                let rawJSON = try JSONSerialization.jsonObject(with: rawData, options: JSONSerialization.ReadingOptions.mutableContainers)
                
                let json = JSON( rawJSON)
                success(json)
                return
            }
            catch
            {
                failure(-1)
                return
            }
            
        }
        failure(-1)
        
    }
}



