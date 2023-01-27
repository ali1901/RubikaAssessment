//
//  OrderViewController.swift
//  RubikaAssessment
//
//  Created by Yaas Mac on 11/7/1401 AP.
//

import UIKit

class OrderViewController: UIViewController {

    @IBOutlet weak var overviewTableView: UITableView!
    @IBOutlet weak var orderBtn: UIButton!
    
    var coffees: CoffeeServiceDataModel!
    var chosenCoffee: CoffeeType!
    var coffeeOrder: CoffeeOrder!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        overviewTableView.delegate = self
        overviewTableView.dataSource = self
        
        orderBtn.layer.cornerRadius = MagicNumbers.tableViewCornerRadios
    }
    
}


//MARK: - TableViewDelegate and DataSource
extension OrderViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! ExtraTableViewCell
        cell.titleLabel.text = "Not specified!"
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return MagicNumbers.tableViewCellHight * 3
    }
    
}
