//
//  EmbededTableViewCell.swift
//  RubikaAssessment
//
//  Created by Yaas Mac on 11/7/1401 AP.
//

import UIKit

class EmbededTableViewCell: UITableViewCell {
    
    let backview: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = MagicNumbers.tableViewCornerRadios
        view.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        return view
      }()
    
    let titleLabel: UILabel =  {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let selectionImageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        img.clipsToBounds = true
        img.tintColor = .white
        return img
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backview.addSubview(titleLabel)
        backview.addSubview(selectionImageView)
        contentView.addSubview(backview)
        
        setBackViewConstraints()
        setTitleLabelConstraints()
        setSelectionImageConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setBackViewConstraints() {
        backview.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        backview.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:10).isActive = true
        backview.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-10).isActive = true
        backview.heightAnchor.constraint(equalToConstant:40).isActive = true
    }
    
    func setTitleLabelConstraints() {
        titleLabel.centerYAnchor.constraint(equalTo:backview.centerYAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo:backview.leadingAnchor, constant:10).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo:selectionImageView.leadingAnchor, constant:-10).isActive = true
    }
    
    func setSelectionImageConstraints() {
        selectionImageView.centerYAnchor.constraint(equalTo:backview.centerYAnchor).isActive = true
        selectionImageView.trailingAnchor.constraint(equalTo:backview.trailingAnchor, constant:-10).isActive = true
        selectionImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        selectionImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
    }
}
