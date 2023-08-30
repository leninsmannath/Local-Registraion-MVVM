//
//  HomeViewConntroller.swift
//  Local Registraion MVVM
//
//  Created by Lenin S on 31/08/23.
//

import UIKit

class HomeViewConntroller: UIViewController {
    var users = [User]()
    let cellIdentifier = "Cell"
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        users = CoreDataManager.shared.getAllUser(entity: "User")
        tableView.reloadData()
        self.title = "All Users (\(users.count))"
        // Do any additional setup after loading the view.
    }
}

extension HomeViewConntroller : UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
        cell.textLabel?.text = users[indexPath.row].email
        return cell
    }
    
}
