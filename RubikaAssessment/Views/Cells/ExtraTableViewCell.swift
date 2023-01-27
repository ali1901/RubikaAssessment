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
        let cell = tableView.cellForRow(at: indexPath) as! EmbededTableViewCell
        let x = cell.titleLabel.text
        print(x ?? "")
        selectedItem = indexPath.row
        tableView.reloadData()
    }
}
