//
//  DependencyInjector.swift
//  AwespaceTest
//
//  Created by Иван on 19.03.2018.
//  Copyright © 2018 Иван. All rights reserved.
//

import Foundation

class DependencyInjector
{
    class func obtainPresenter(view: View)
    {
        var presenter : Presenter?
        
        if view is ViewController
        {
            presenter = CollectionPresenter()
        }
        
        if presenter != nil
        {
            view.assignPresenter(presenter: presenter!)
        }
    }
}
