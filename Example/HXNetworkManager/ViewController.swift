//
//  ViewController.swift
//  HXNetworkManager
//
//  Created by sachinD on 08/08/2022.
//  Copyright (c) 2022 sachinD. All rights reserved.
//

import UIKit
import HXNetworkManager

class ViewController: UIViewController,NewsViewModalProtocol {

    @IBOutlet weak var tableView: UITableView!
    private var newsList: [Articles]?
    override func viewDidLoad() {
        super.viewDidLoad()
        let viewModal = NewsViewModal(APIClient(), self)
        viewModal.fetchNewsApi()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateResponse(article: [Articles]) {
        DispatchQueue.main.async {
            self.newsList = article
            self.tableView.reloadData()
        }
    }
    
    func showError(message: String) {
        DispatchQueue.main.async {
            print(message)
        }
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as? NewsCell else {
            return fatalError("not load cell") as! UITableViewCell
        }
        
        cell.newsTitle.text = newsList?[indexPath.row].title
        cell.newsDescription.text = newsList?[indexPath.row].descriptions
        return cell
    }
}

