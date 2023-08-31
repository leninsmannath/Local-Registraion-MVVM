//
//  HomeViewModel.swift
//  Local Registraion MVVM
//
//  Created by Lenin S on 31/08/23.
//

import Foundation

protocol HomeViewModelProtocol:AnyObject {
    func updateUI() -> Void
}

class HomeViewModel {
    weak private var delegate:HomeViewModelProtocol?
    var users = [User]()
    
    init(withDelegate delegate:HomeViewModelProtocol) {
        self.delegate = delegate
    }
    
    func loadData () {
        users = CoreDataManager.shared.getAllUser(entity: CoreDataEntity.user)
        delegate?.updateUI()
    }
}
