//
//  CoffeeExtraViewController.swift
//  RubikaAssessment
//
//  Created by Yaas Mac on 11/5/1401 AP.
//

import UIKit

class CoffeeExtraViewController: UIViewController {

    @IBOutlet weak var extraTableView: UITableView!
    
    var coffees: CoffeeServiceDataModel!
    var chosenCoffee: CoffeeType!
    
    var selectedIndex = -1
        
    override func viewDidLoad() {
        super.viewDidLoad()

        extraTableView.delegate = self
        extraTableView.dataSource = self
    }
    
    func getExtraItem(for id: String) -> CoffeeExtra? {
        for item in coffees.extras {
            if item.id == id {
                return item
            }
        }
        return nil
    }
    
    private func getImage(coffeeName: String) -> UIImage {
        if coffeeName.contains("milk") {
            return UIImage(named: "milk.png") ?? UIImage(systemName: "photo.on.rectangle.fill")!
        } else if coffeeName.contains("sugar") {
            return UIImage(named: "sugar.png") ?? UIImage(systemName: "photo.on.rectangle.fill")!
        } else {
            return UIImage(systemName: "photo.on.rectangle.fill")!
        }
    }
    
//    private func createEmbededTableView(in indexPath: IndexPath) {
//        let cell = extraTableView.cellForRow(at: indexPath) as! ItemsTableViewCell
//        let embededtableView = UITableView()
//
//        setupTableView(embededtableView, in: cell)
//    }
//
//    func setupTableView(_ tableView: UITableView, in cell: ItemsTableViewCell) {
//        cell.cellBackView.addSubview(tableView)
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        tableView.topAnchor.constraint(equalTo: cell.itemIcon.bottomAnchor, constant: 5).isActive = true
//        tableView.leftAnchor.constraint(equalTo: cell.cellBackView.leftAnchor, constant: 10).isActive = true
//        tableView.bottomAnchor.constraint(equalTo: cell.cellBackView.bottomAnchor, constant: -5).isActive = true
//        tableView.rightAnchor.constraint(equalTo: cell.cellBackView.rightAnchor, constant:  -10).isActive = true
//        tableView.backgroundColor = .yellow
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//        extraTableView.reloadData()
//     }
}


//Mark: - TableViewDelegate and DataSource
extension CoffeeExtraViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chosenCoffee.extras.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let extraItem = getExtraItem(for: chosenCoffee.extras[indexPath.row])
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! ItemsTableViewCell
        cell.index = indexPath.row
        cell.cofeeExtra = extraItem
        cell.extras = extraItem?.subselections
        cell.itemTitleLabel.text = extraItem?.name ?? "Not specified!"
        cell.itemIcon.image = getImage(coffeeName: extraItem?.name ?? "")
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == selectedIndex {
            return MagicNumbers.tableViewCellExpandedHight
        }
        return MagicNumbers.tableViewCellHight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        chosenCoffee = coffees.types[indexPath.row]
        //        if chosenCoffee != nil {
        //            performSegue(withIdentifier: "SizeToExtra", sender: nil)
        //        }
        
        //Setting selectedIndex to be used when expanding row height
        if selectedIndex == indexPath.row {
            selectedIndex = -1
        } else {
            selectedIndex = indexPath.row
            //createEmbededTableView(in: indexPath)
        }
        extraTableView.reloadRows(at: [indexPath], with: .automatic)
        
    }
    
}
