//
//  ViewController.swift
//  ex00
//
//  Created by Андрей Мотырев on 01.08.2022.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true;
        //tableView.rowHeight = UITableViewAutomaticDimension // for swift 4.2 version
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 140
        tableView.reloadData()
    }
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Data.people.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "peopleCell") as! PeopleTableViewCell
        //cell?.textLabel?.text = Data.people[indexPath.row].0
        //cell?.detailTextLabel?.text = Data.people[indexPath.row].1
        //return cell!
        //for NOT custom styles!
        cell.people = Data.people[indexPath.row]
        cell.nameLabel?.numberOfLines = 0
        cell.descriptionLabel?.numberOfLines = 0
        cell.dateLabel?.numberOfLines = 0
        return cell
    }
    
}

