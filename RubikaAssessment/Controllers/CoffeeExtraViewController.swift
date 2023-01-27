//
//  CoffeeExtraViewController.swift
//  RubikaAssessment
//
//  Created by Yaas Mac on 11/5/1401 AP.
//

import UIKit

class CoffeeExtraViewController: UIViewController {

    @IBOutlet weak var extraTableView: UITableView!
    @IBOutlet weak var confirmBtn: UIButton!
    
    var coffees: CoffeeServiceDataModel!
    var chosenCoffee: CoffeeType!
    var coffeeOrder: CoffeeOrder!
    
    var selectedIndex = -1
        
    override func viewDidLoad() {
        super.viewDidLoad()

        extraTableView.delegate = self
        extraTableView.dataSource = self
        
        setupConfirmBtn()
        
        NotificationCenter.default.addObserver(self, selector: #selector(extraItemSelected(notification: )), name: NSNotification.Name("extraItem"), object: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ExtrasToOrder" {
            if let destination = segue.destination as? OrderViewController {
                destination.coffees = coffees!
                destination.chosenCoffee = chosenCoffee!
                destination.coffeeOrder = coffeeOrder
            }
        }
    }
    
    //MARK: - Funcs
    private func setupConfirmBtn() {
        confirmBtn.tintColor = .white
        confirmBtn.layer.cornerRadius = MagicNumbers.tableViewCornerRadios
        confirmBtn.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
        confirmBtn.layer.shadowOffset = CGSize(width: 0, height: 10)
        confirmBtn.layer.shadowOpacity = 10.0
        confirmBtn.layer.shadowRadius = 10.0
        confirmBtn.layer.masksToBounds = false
    }
    
    private func getExtraItem(for id: String) -> CoffeeExtra? {
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
    
    @objc func extraItemSelected(notification: NSNotification) {
        guard let data = notification.userInfo as? [String: String] else { return }
        let orderData = coffeeOrder.extra ?? [String: String]()
        let result = data.merging(orderData, uniquingKeysWith: { (first, _) in first })
        coffeeOrder.extra = result
    }
    
    //MARK: - IBActions
    @IBAction func confirmBtnTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "ExtrasToOrder", sender: nil)
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
