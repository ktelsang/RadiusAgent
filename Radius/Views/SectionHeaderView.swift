//
//  SectionHeaderView.swift
//  Radius
//
//  Created by Kavyashree Hegde on 29/06/23.
//

import UIKit

class SectionHeaderView: UIView {
    
    var headerLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews() {
        self.addSubviews(views: [headerLabel])
        headerLabel.setFullOnSuperView(withSpacing: 15)
    }
}
