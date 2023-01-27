//
//  CoffeeSizeViewController.swift
//  RubikaAssessment
//
//  Created by Yaas Mac on 11/5/1401 AP.
//

import UIKit

class CoffeeSizeViewController: UIViewController {

    @IBOutlet weak var sizesTableView: UITableView!
    
    var coffees: CoffeeServiceDataModel!
    var chosenCoffee: CoffeeType!
    //var chosenCoffeeType: CoffeeType?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sizesTableView.delegate = self
        sizesTableView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SizeToExtra" {
            if let destination = segue.destination as? CoffeeExtraViewController {
                destination.coffees = coffees!
                destination.chosenCoffee = chosenCoffee!
                
            }
        }
    }
    
    
    func getSizeItem(for id: String) -> CoffeeSize? {
        for item in coffees.sizes {
            if item.id == id {
                return item
            }
        }
        return nil
    }
    
    private func getImage(coffeeName: String) -> UIImage {
        switch coffeeName {
        case "Large":
            return UIImage(named: "large.png") ?? UIImage(systemName: "photo.on.rectangle.fill")!
        case "Venti":
            return UIImage(named: "venti.png") ?? UIImage(systemName: "photo.on.rectangle.fill")!
        case "Tall":
            return UIImage(named: "tall.png") ?? UIImage(systemName: "photo.on.rectangle.fill")!
        default:
            return UIImage(named: "large.png") ?? UIImage(systemName: "photo.on.rectangle.fill")!
        }
    }
}


//Mark: - TableViewDelegate and DataSource
extension CoffeeSizeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        chosenCoffee.sizes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! ItemsTableViewCell
        let sizeItem = getSizeItem(for: chosenCoffee.sizes[indexPath.row])
        cell.itemTitleLabel.text = sizeItem?.name ?? "Not specified!"
        cell.itemIcon.image = getImage(coffeeName: sizeItem?.name ?? "")
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        MagicNumbers.tableViewCellHight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //chosenCoffeeType = coffees.types[indexPath.row]
        if chosenCoffee != nil {
            performSegue(withIdentifier: "SizeToExtra", sender: nil)
        }
    }
    
}


