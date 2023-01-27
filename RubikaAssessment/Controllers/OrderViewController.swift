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
    
    let coffeeService = CoffeeService()
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
        overviewTableView.register(EmbededTableViewCell.self, forCellReuseIdentifier: "cell")
        overviewTableView.separatorColor = .white
        overviewTableView.layer.cornerRadius = MagicNumbers.tableViewCornerRadios
        
        orderBtn.layer.cornerRadius = MagicNumbers.tableViewCornerRadios
        
        makeArrayOfItems(order: coffeeOrder)
    }
    
    //MARK: - Funcs
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
    
    private func getImage(coffeeName: String) -> UIImage {
        switch coffeeName {
        case "Large":
            return UIImage(named: "large.png") ?? UIImage(systemName: "photo.on.rectangle.fill")!
        case "Venti":
            return UIImage(named: "venti.png") ?? UIImage(systemName: "photo.on.rectangle.fill")!
        case "Tall":
            return UIImage(named: "tall.png") ?? UIImage(systemName: "photo.on.rectangle.fill")!
        case "Espresso":
            return UIImage(named: "espresso 1.png") ?? UIImage(systemName: "photo.on.rectangle.fill")!
        case "Cappuccino":
            return UIImage(named: "cappuccino 1.png") ?? UIImage(systemName: "photo.on.rectangle.fill")!
        case "Ristretto":
            return UIImage(named: "ristretto 1.png") ?? UIImage(systemName: "photo.on.rectangle.fill")!
        case "Milk":
            return UIImage(named: "milk.png") ?? UIImage(systemName: "photo.on.rectangle.fill")!
        case "Sugar":
            return UIImage(named: "sugar.png") ?? UIImage(systemName: "photo.on.rectangle.fill")!
        default:
            return UIImage(systemName: "photo.on.rectangle.fill")!
        }
    }
    
    //MARK: - IBActions
    @IBAction func orderBtnTapped(_ sender: UIButton) {
        print("Coffee Ordered...")
        coffeeService.orderCoffee(order: coffeeOrder) { response in
            if response.error == false {
                //TODO: Parsing order response
            }
        }
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
        let rowName = getTableViewData(for: x, id: itemsDictionary[x] ?? "")
        cell.itemTitleLabel.text = rowName
        cell.itemIcon.image = getImage(coffeeName: rowName)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return MagicNumbers.tableViewCellHight-20
    }
    
}
