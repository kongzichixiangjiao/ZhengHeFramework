//
//  PXTitleButton.swift
//  IFA-B
//
//  Created by summer on 2018/8/13.
//  Copyright © 2018年 ZHENGHEHOLDING. All rights reserved.
//

import UIKit

class PXTitleButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setTitleAndImage()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setTitleAndImage()
    }
    
    private func setTitleAndImage() {
        setImage(UIImage(named: "sortNormal"), for: .normal)
        setImage(UIImage(named: "sortSelected"), for: .selected)
        let normalFontColor = UIColor.init(red: 51/255.0, green: 51/255.0, blue: 51/255.0, alpha: 1)
        let selectedFontColor = UIColor.init(red: 180/255.0, green: 136/255.0, blue: 86/255.0, alpha: 1)
        setTitleColor(normalFontColor, for: .normal)
        setTitleColor(selectedFontColor, for: .selected)
        sizeToFit()
    }
    
    /**
     这个方法里调整布局
     */
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel?.frame.origin.x = (self.frame.size.width  - titleLabel!.frame.size.width - (imageView?.image?.size.width)!) / 2
        imageView?.frame.origin.x = (titleLabel?.frame.origin.x)! + (titleLabel?.frame.size.width)! + 5
    }

}

