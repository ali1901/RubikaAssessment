//
//  ItemsTableViewCell.swift
//  RubikaAssessment
//
//  Created by Yaas Mac on 11/5/1401 AP.
//

import UIKit

class ItemsTableViewCell: UITableViewCell {

    @IBOutlet weak var cellBackView: UIView!
    @IBOutlet weak var itemIcon: UIImageView!
    @IBOutlet weak var itemTitleLabel: UILabel!
    
    let embededtableView = UITableView()
    var index = 0
    var extras: [CoffeeExtraSubselectoin]?
    var cofeeExtra: CoffeeExtra? {
        didSet {
            if cofeeExtra != nil {
                createEmbededTableView()
            }
        }
    }
    
//    let stuff = ["one", "two"]
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        cellBackView.layer.cornerRadius = MagicNumbers.tableViewCornerRadios
        itemIcon.layer.cornerRadius = itemIcon.frame.width/2

        embededtableView.delegate = self
        embededtableView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func createEmbededTableView() {
        cellBackView.addSubview(embededtableView)
       
        setupTableView(embededtableView, in: cellBackView)
    }
    
    private func setupTableView(_ tableView: UITableView, in cell: UIView) {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: itemIcon.bottomAnchor, constant: 5).isActive = true
        tableView.leftAnchor.constraint(equalTo: cell.leftAnchor, constant: 10).isActive = true
        tableView.bottomAnchor.constraint(equalTo: cell.bottomAnchor, constant: -5).isActive = true
        tableView.rightAnchor.constraint(equalTo: cell.rightAnchor, constant:  -10).isActive = true
        tableView.backgroundColor = .yellow
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
     }

}

extension ItemsTableViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        extras?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = embededtableView.dequeueReusableCell(withIdentifier: "cell")!
        let name = extras?[indexPath.row].name
        cell.textLabel?.text = name
        return cell
    }


}
