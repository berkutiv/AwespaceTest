//
//  CollectionManager.swift
//  AwespaceTest
//
//  Created by Иван on 20.03.2018.
//  Copyright © 2018 Иван. All rights reserved.
//

import Foundation

class CollectionManager
{
    class func getProducts (offset: String, success : @escaping (NSArray) -> Void , failure : @escaping (Int) -> Void)
    {
        let collectionOperation = CollectionOperation.init(offset: offset, success: { (dataSource) in
            success(dataSource)
        }, failure: failure)
        OperationsManager.addOperation(op: collectionOperation, cancellingQueue: false)
    }
}
