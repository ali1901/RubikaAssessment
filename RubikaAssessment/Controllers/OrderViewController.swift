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
    var items = ["type", "size", "milk", "sugar"]
    var itemsDictionary = [String: String]()
    var isSubItem = false
    var milkItemAdded = false
    var sugarItemAdded = false
    override func viewDidLoad() {
        super.viewDidLoad()

        overviewTableView.delegate = self
        overviewTableView.dataSource = self
        
        orderBtn.layer.cornerRadius = MagicNumbers.tableViewCornerRadios
        
        makeArrayOfItems(order: coffeeOrder)
        overviewTableView.register(EmbededTableViewCell.self, forCellReuseIdentifier: "cell")
        overviewTableView.separatorColor = .white
    }
    
    private func makeArrayOfItems(order: CoffeeOrder) {
        itemsDictionary["type"] = order.type
        itemsDictionary["size"] = order.size
        itemsDictionary["milk"] = order.extra?["milk"] ?? ""
        itemsDictionary["sugar"] = order.extra?["sugar"] ?? ""
    }
    
    private func getTableViewData(for key: String, id: String) -> String {
        switch key {
        case "type":
            for item in coffees.types {
                if item.id == id {
                    return item.name
                }
            }
        case "size":
            for item in coffees.sizes {
                if item.id == id {
                    return item.name
                }
            }
        case "milk":
            return "Milk"
        case "sugar":
            return "Sugar"
            
        case "milkSub", "sugarSub":
            for item in coffees.extras {
                for subItem in item.subselections {
                    if subItem.id == id {
                        return subItem.name
                    }
                }
            }
        default:
            return ""
            
        }
        return ""
    }
}


//MARK: - TableViewDelegate and DataSource
extension OrderViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if itemsDictionary["milk"] != nil && itemsDictionary["milk"] != "" && !milkItemAdded {
            milkItemAdded = true
            items.insert("milkSub", at: 3)
        }
        if itemsDictionary["sugar"] != nil && itemsDictionary["sugar"] != "" && !sugarItemAdded{
            sugarItemAdded = true
            items.append("sugarSub")
        }
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let x = items[indexPath.row]
        
        if x == "milkSub" || x == "sugarSub" {
            let z = x == "milkSub" ? itemsDictionary["milk"] : itemsDictionary["sugar"]
            let subCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! EmbededTableViewCell
            subCell.titleLabel.text = getTableViewData(for: x, id: z ?? "")
            subCell.selectionImageView.image = UIImage(systemName: "checkmark.circle")
            isSubItem = false
            subCell.backgroundColor = #colorLiteral(red: 0.7215686275, green: 0.8509803922, blue: 0.6666666667, alpha: 1)
            return subCell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! ItemsTableViewCell
        cell.itemTitleLabel.text = getTableViewData(for: x, id: itemsDictionary[x] ?? "")
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return MagicNumbers.tableViewCellHight
    }
    
}
