//
//  AOListCell.swift
//  Prognoz-test
//
//  Created by Андрей Ошев on 23.06.16.
//  Copyright © 2016 Andrey Oshev. All rights reserved.
//

import UIKit

let kAOListElementCellHorizontalPadding: CGFloat = 8
let kAOListElementCellVerticalPadding: CGFloat = 8
let kAOListElementCellIconOffset: CGFloat = 8

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
    
    // Рассчитывает высоту ячейки для элемента списка в зависимости от: 
    // размера картинки, 
    // присутствует картинка или нет,
    // шрифта, 
    // размера шрифта, 
    // ширины ячейки
    // Считаем, что если размер картинки нулевой, значит картинка отсутствует.
    
    class func heightForElement(element: AOListElement, iconSize: CGSize, titleFont: UIFont, cellWidth: CGFloat) -> CGFloat {
        var avaliableWidth = cellWidth - kAOListElementCellHorizontalPadding * 2
        var height = kAOListElementCellVerticalPadding * 2
        
        if (iconSize.width > 0) {
            avaliableWidth = avaliableWidth - iconSize.width - kAOListElementCellIconOffset
        }
        
        var textSize = CGSizeZero
        
        if (element.text != nil) {
            let text = NSString(string: element.text!)
            textSize = text.boundingRectWithSize(CGSizeMake(avaliableWidth, CGFloat.max), options: .UsesLineFragmentOrigin, attributes: [NSFontAttributeName : titleFont], context: nil).size
        }
        
        height = height + ((iconSize.height > textSize.height) ? iconSize.height : textSize.height)
        
        return height
    }
    
    func setupView() {
        titleLabel = UILabel()
        titleLabel.numberOfLines = 0
        titleLabel.backgroundColor = UIColor.clearColor()
        
        contentView.addSubview(titleLabel)
        
        iconView = UIImageView()
        contentView.addSubview(iconView)
    }
    
    func configureWithElement(element: AOListElement) {
        titleLabel?.text = element.text
        iconView.image = element.image
        self.layoutSubviews()
    }
    
    class func cellIdentifier() -> String {
        return NSStringFromClass(self)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        var titleLabelX = kAOListElementCellHorizontalPadding
        
        if (showIcon) {
            iconView.frame = CGRectMake(kAOListElementCellHorizontalPadding,
                                        kAOListElementCellVerticalPadding,
                                        iconSize.width,
                                        iconSize.height)
            titleLabelX = iconView.frame.maxX + kAOListElementCellIconOffset
        }
        
        let avaliableWidth = self.bounds.width - titleLabelX - kAOListElementCellHorizontalPadding
        var textSize = CGSizeZero
        
        if (titleLabel.text != nil) {
            let text = NSString(string: titleLabel.text!)
            textSize = text.boundingRectWithSize(CGSizeMake(avaliableWidth, CGFloat.max), options: .UsesLineFragmentOrigin, attributes: [NSFontAttributeName : titleLabel.font], context: nil).size
        }
        
        titleLabel.frame = CGRectMake(titleLabelX,
                                      kAOListElementCellVerticalPadding,
                                      textSize.width,
                                      textSize.height)
    }
}














