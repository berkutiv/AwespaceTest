//
//  ViewController.swift
//  AwespaceTest
//
//  Created by Иван on 19.03.2018.
//  Copyright © 2018 Иван. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    var presenter: Presenter?
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let productCellNIB = UINib(nibName: "ProductCollectionViewCell", bundle: nil)
    let productCellReuseIdentifier = "productCellReuseIdentifier"
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        collectionView.register(productCellNIB, forCellWithReuseIdentifier: productCellReuseIdentifier)
    }

    override func viewWillAppear(_ animated: Bool)
    {
        if presenter == nil
        {
            DependencyInjector.obtainPresenter(view: self)
        }
        super.viewWillAppear(animated)
    }


}

extension ViewController: View
{
    func assignPresenter(presenter: Presenter) -> Void
    {
        self.presenter = presenter
        presenter.viewLoaded(view: self)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func reloadData() -> Void
    {
        collectionView.reloadData()
    }
    
    func addLoader() -> Void
    {
        activityIndicator.startAnimating()
    }
    
    func removeLoader() -> Void
    {
        activityIndicator.stopAnimating()
    }
    
    func handleInternetErrorCode(code: Int) -> Void
    {
        let alertController = UIAlertController(title: "Ошибка", message: "Нет соединения", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource
{
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return presenter!.numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return presenter!.numberOfModels(inSection: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let model = presenter!.getModel(atIndexPath: indexPath)
        
        if model is Product
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: productCellReuseIdentifier, for: indexPath) as! ProductCollectionViewCell
            cell.configureSelf(with: model as! Product)
            return cell
        }else
        {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
    {
        if ( indexPath.row == presenter!.numberOfModels(inSection: indexPath.section) - 2)
        {
            presenter!.provide(data: NSDictionary())
        }
    }
}

