//
//  FacilityTableViewCell.swift
//  Radius
//
//  Created by Kavyashree Hegde on 28/06/23.
//

import UIKit

class FacilityTableViewCell: UITableViewCell {
    static let cellId = String(describing: FacilityTableViewCell.self)
        
    var option: Option? {
        didSet {
            configureCellData()
        }
    }
    var facilityId: String?
    
    var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 5
        
        view.layer.shadowColor = UIColor(red: 17/225, green: 10/225, blue: 137/225, alpha: 1.0).cgColor
        view.layer.shadowOffset = CGSize(width: 1, height: 1)
        view.layer.shadowOpacity = 1
        
        return view
    }()
    
    var facilityLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()
    
    let selectionButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .clear
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setUpViews()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setUpViews() {
        backgroundColor = .clear
        self.contentView.addSubviews(views: [containerView,
                                             selectionButton,
                                             facilityLabel])
        
        self.contentView.backgroundColor = .clear
                
        containerView.setLeading(with: self.leadingAnchor, constant: 10)
        containerView.setTrailing(with: self.trailingAnchor, constant: -10)
        containerView.setBottom(with: self.bottomAnchor, constant: -3)
        containerView.setTop(with: self.topAnchor,constant: 3)
        
        selectionButton.setLeading(with: containerView.leadingAnchor, constant: 2)
        selectionButton.setCenterY()
        selectionButton.setHeightAndWidth(height: 30, width: 30)
        
        facilityLabel.setAnchors(top: selectionButton.topAnchor,
                                 bottom: selectionButton.bottomAnchor,
                                 leading: selectionButton.trailingAnchor,
                                 trailing: containerView.trailingAnchor,
                                 leadingConstant: 20, trailingConstant: -10)
    }
    
    func configureCellData() {
        facilityLabel.text = option?.name
        let image = UIImage(named: option?.icon ?? "")?.withRenderingMode(.alwaysTemplate)
        selectionButton.setImage(image, for: .normal)
        setUnselectedStyle()
        if option?.selected == true {
            setSelectedStyle()
        }
        
        selectionStyle = .none
    }
    
    func setSelectedStyle() {
        selectionButton.tintColor = UIColor(red: 224/225, green: 101/225, blue: 113/225, alpha: 1.0)
        facilityLabel.textColor = UIColor(red: 224/225, green: 101/225, blue: 113/225, alpha: 1.0)
        facilityLabel.font = .systemFont(ofSize: 16, weight: .bold)
    }
    
    func setUnselectedStyle() {
        selectionButton.tintColor = .black
        facilityLabel.textColor = .black
        facilityLabel.font = .systemFont(ofSize: 16, weight: .regular)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
