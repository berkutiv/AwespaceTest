//
//  OperationsManager.swift
//  AwespaceTest
//
//  Created by Иван on 19.03.2018.
//  Copyright © 2018 Иван. All rights reserved.
//
import Foundation

class OperationsManager
{
    private static let businessOparationQueue = OperationQueue()
    
    class func addOperation(op: Operation, cancellingQueue: Bool)
    {
        businessOparationQueue.maxConcurrentOperationCount = 1
        
        if cancellingQueue
        {
            businessOparationQueue.cancelAllOperations()
        }
        
        businessOparationQueue.addOperation(op)
    }
    
}
