//
//  CoffeeStylesViewController.swift
//  RubikaAssessment
//
//  Created by Yaas Mac on 11/5/1401 AP.
//

import UIKit

class CoffeeStylesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var coffees: CoffeeServiceDataModel!
    var chosenCoffee: CoffeeType?
    var coffeeOrder = CoffeeOrder(type: "", size: "", extra: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "StyleToSize" {
            if let destinationVC = segue.destination as? CoffeeSizeViewController {
                destinationVC.coffees = coffees!
                destinationVC.chosenCoffee = chosenCoffee!
                destinationVC.coffeeOrder = coffeeOrder
            }
        }
    }
    
    private func getImage(coffeeName: String) -> UIImage {
        switch coffeeName {
        case "Espresso":
            return UIImage(named: "espresso 1.png") ?? UIImage(systemName: "photo.on.rectangle.fill")!
        case "Cappuccino":
            return UIImage(named: "cappuccino 1.png") ?? UIImage(systemName: "photo.on.rectangle.fill")!
        case "Ristretto":
            return UIImage(named: "ristretto 1.png") ?? UIImage(systemName: "photo.on.rectangle.fill")!
        default:
            return UIImage(named: "espresso 1.png") ?? UIImage(systemName: "photo.on.rectangle.fill")!
        }
    }

}

//Mark: - TableViewDelegate and DataSource
extension CoffeeStylesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        coffees.types.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! ItemsTableViewCell
        let coffeeName = coffees.types[indexPath.row].name
        cell.itemTitleLabel.text = coffeeName
        cell.itemIcon.image = getImage(coffeeName: coffeeName)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        MagicNumbers.tableViewCellHight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenCoffee = coffees.types[indexPath.row]
        if chosenCoffee != nil {
            coffeeOrder.type = chosenCoffee!.id
            performSegue(withIdentifier: "StyleToSize", sender: nil)
        }
    }
}
