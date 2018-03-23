//
//  CollectionPresenter.swift
//  AwespaceTest
//
//  Created by Иван on 20.03.2018.
//  Copyright © 2018 Иван. All rights reserved.
//

import Foundation

class CollectionPresenter : Presenter
{
    var dataSource = NSMutableArray()
    var nextOffset = 1
    weak var view: View?
    
    func viewLoaded(view: View) -> Void
    {
        self.view = view
        view.addLoader()
        getData(offset: "1")
    }
    
    func numberOfModels(inSection section: Int) -> Int
    {
        return dataSource.count
    }
    
    func numberOfSections() -> Int
    {
        return 1
    }
    
    func getModel(atIndexPath indexPath: IndexPath) -> Any
    {
        let object = dataSource[indexPath.row]
        return object
    }
    
    private func getData(offset: String)
    {
        CollectionManager.getProducts(offset: offset, success: { [weak self] (posts) in
            DispatchQueue.main.async{
                self?.view?.removeLoader()
                self?.nextOffset += 1
                self?.dataSource.addObjects(from: posts as! [Any])
                self?.view?.reloadData()
            }
        }) { [weak self](code) in
            DispatchQueue.main.async{
                self?.view?.removeLoader()
                self?.view?.handleInternetErrorCode(code: code)
            }
        }
    }
    
    func provide(data: NSDictionary)
    {
        getData(offset: "\(nextOffset)")
    }
}
