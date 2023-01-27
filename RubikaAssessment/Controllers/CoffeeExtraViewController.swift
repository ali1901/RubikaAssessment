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
}


//MARK: - TableViewDelegate and DataSource
extension CoffeeExtraViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chosenCoffee.extras.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let extraItem = getExtraItem(for: chosenCoffee.extras[indexPath.row])
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! ExtraTableViewCell
        cell.coffeeExtra = extraItem
        cell.titleLabel.text = extraItem?.name ?? "Not specified!"
        cell.iconImage.image = getImage(coffeeName: extraItem?.name ?? "")
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == selectedIndex {
            let extraItem = getExtraItem(for: chosenCoffee.extras[indexPath.row])
            let itemsHight = CGFloat((extraItem?.subselections.count ?? 0) * 50)
            return MagicNumbers.tableViewCellHight + itemsHight
        }
        return MagicNumbers.tableViewCellHight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Setting selectedIndex to be used when expanding row height
        if selectedIndex == indexPath.row {
            selectedIndex = -1
        } else {
            selectedIndex = indexPath.row
        }
        extraTableView.reloadData()
    }
    
}
