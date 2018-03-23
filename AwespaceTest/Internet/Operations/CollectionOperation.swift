//
//  CollectionOperation.swift
//  AwespaceTest
//
//  Created by Иван on 20.03.2018.
//  Copyright © 2018 Иван. All rights reserved.
//

import Foundation

class CollectionOperation : Operation
{
    var success: (NSArray) -> Void
    var failure: (Int) -> Void
    var offset: String
    
    var internetTask : URLSessionDataTask?
    
    init(offset: String, success: @escaping (NSArray) -> Void, failure: @escaping (Int) -> Void)
    {
        self.offset = offset
        self.success = success
        self.failure = failure
    }
    
    override func cancel()
    {
        internetTask?.cancel()
    }
    
    override func main()
    {
        let semaphore = DispatchSemaphore(value: 0)
        internetTask = API_WRAPPER.getProducts(offset: offset, count: "20", success: { (jsonResponce) in
            
            print("offset \(self.offset)")
            let jsons = jsonResponce["data"].arrayValue
            
            let success = jsonResponce["res"].stringValue
            var outData = NSMutableArray()
            
            if success != "success"
            {
                semaphore.signal()
                self.failure(0)
            }
            
            for i in 0..<jsons.count
            {
                if self.isCancelled
                {
                    break
                }
                
                let model = jsons[i]
                let productName = model["name"].stringValue
                let colours = model["Colors"].arrayValue
                var productPrice = ""
                for color in colours
                {
                    productPrice = "$ " + color["price"].stringValue + ".- "
                }
                let productImage = model["image_preview"].stringValue
                
                let productModel = Product(name: productName, price: productPrice, image: productImage)
                outData.add(productModel)
            }
            
            if self.isCancelled == false
            {
                self.success(outData)
            }
            else
            {
                self.success(NSArray())
            }
            
            semaphore.signal()
            
        }, failure: { (code) in
            semaphore.signal()
            self.failure(code)
        })
        
        
        _ = semaphore.wait(timeout: DispatchTime.distantFuture)
    }
}
