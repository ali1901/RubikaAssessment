//
//  ExtraTableViewCell.swift
//  RubikaAssessment
//
//  Created by Yaas Mac on 11/7/1401 AP.
//

import UIKit

class ExtraTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellbackview: UIView!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var embededTableView: UITableView!
    
    var coffeeExtra: CoffeeExtra?
    var selectedItem = -1

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        cellbackview.layer.cornerRadius = MagicNumbers.tableViewCornerRadios
        iconImage.layer.cornerRadius = iconImage.frame.width/2
        
        embededTableView.delegate = self
        embededTableView.dataSource = self
        setupTableView(embededTableView, in: cellbackview)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setupTableView(_ tableView: UITableView, in cell: UIView) {
        tableView.backgroundColor = .clear
        tableView.register(EmbededTableViewCell.self, forCellReuseIdentifier: "cell")
     }
    
    private func postNotification(with data: [String: String]) {
        NotificationCenter.default.post(name: NSNotification.Name("extraItem"), object: nil, userInfo: data)
    }
    
    private func getExtraItemName(name: String) -> String {
        if name.localizedStandardContains("milk") {
            return "milk"
        } else if name.localizedStandardContains("sugar") {
            return "sugar"
        } else {
            return "extra"
        }
    }
}

extension ExtraTableViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        coffeeExtra?.subselections.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = embededTableView.dequeueReusableCell(withIdentifier: "cell") as! EmbededTableViewCell
        let name = coffeeExtra?.subselections[indexPath.row].name
        cell.titleLabel.text = name
        cell.selectionImageView.image = selectedItem == indexPath.row ? UIImage(systemName: "checkmark.circle") : UIImage(systemName: "circle")
        cell.backgroundColor = .clear
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        MagicNumbers.embededTableViewCellHight
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let itemName = getExtraItemName(name: coffeeExtra?.name ?? "")
        let itemID = coffeeExtra?.subselections[indexPath.row].id
        postNotification(with: [itemName : itemID ?? ""])
        selectedItem = indexPath.row
        tableView.reloadData()
    }
}
