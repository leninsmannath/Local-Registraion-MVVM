//
//  HomeViewConntroller.swift
//  Local Registraion MVVM
//
//  Created by Lenin S on 31/08/23.
//

import UIKit

class HomeViewConntroller: UIViewController {
    let cellIdentifier = "Cell"
    private var viewModel:HomeViewModel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        setupViewModel()
        // Do any additional setup after loading the view.
    }
    
    func setupViewModel () {
        viewModel = HomeViewModel(withDelegate: self)
        viewModel.loadData()
    }
    
    func registerCell () {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }
}

extension HomeViewConntroller : UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
        cell.textLabel?.text = viewModel.users[indexPath.row].email
        return cell
    }
    
}

extension HomeViewConntroller : HomeViewModelProtocol {
    func updateUI() {
        self.title = "All Users (\(viewModel.users.count))"
        tableView.reloadData()
    }
}
