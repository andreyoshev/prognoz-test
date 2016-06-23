//
//  AOListCell.swift
//  Prognoz-test
//
//  Created by Андрей Ошев on 23.06.16.
//  Copyright © 2016 Andrey Oshev. All rights reserved.
//

import UIKit

class AOListElementCell: UITableViewCell {
    var iconView: UIImageView!
    var titleLabel: UILabel!
    
    var showIcon: Bool = false
    var iconSize: CGSize = CGSizeZero
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    func setupView() {
        titleLabel = UILabel()
        contentView.addSubview(titleLabel)
        
        iconView = UIImageView()
        contentView.addSubview(iconView)
    }
    
    func configureWithElement(element: AOListElement) {
        titleLabel?.text = element.text
    }
    
    class func cellIdentifier() -> String {
        return NSStringFromClass(self)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.frame = bounds
    }
}
