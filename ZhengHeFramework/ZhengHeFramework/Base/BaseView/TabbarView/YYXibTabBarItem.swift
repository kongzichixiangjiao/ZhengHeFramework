//
//  YYXibTabBarItem.swift
//  YYFramework
//
//  Created by 侯佳男 on 2018/12/14.
//  Copyright © 2018年 houjianan. All rights reserved.
//

import UIKit

protocol YYXibTabBarItemDelegate: class {
    func YYXibTabBarItemTap(title: String, tag: Int) -> Bool
}

class YYXibTabBarItem: UIView {

    weak var mDelegate: YYXibTabBarItemDelegate?
    
    @IBInspectable var backViewColor: UIColor = UIColor.black
    
    @IBInspectable var imageDefaultName: String = ""
    @IBInspectable var imageHighlightName: String = ""
    
    @IBInspectable var labelName: String = ""
    @IBInspectable var labelFontSize: CGFloat = 10
    @IBInspectable var labelColor: UIColor = UIColor.black
    
    @IBInspectable var imageTopSpace: CGFloat = 8
    @IBInspectable var labelTopSpace: CGFloat = 33
    
    @IBInspectable var mTag: Int = -1
    
    var isHighlight: Bool! {
        didSet {
            if isHighlight && !imageHighlightName.isEmpty {
                imageV.image = UIImage(named: self.imageHighlightName)
            } else {
                imageV.image = UIImage(named: self.imageDefaultName)
            }
        }
    }
    
    lazy var imageV: UIImageView = {
        let v = UIImageView()
        v.image = UIImage(named: self.imageDefaultName)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    lazy var mLabel: UILabel = {
        let v = UILabel()
        v.font = UIFont.systemFont(ofSize: self.labelFontSize)
        v.textColor = self.labelColor
        v.textAlignment = .center
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    lazy var button: UIButton = {
        let v = UIButton()
        v.tag = mTag
        v.translatesAutoresizingMaskIntoConstraints = false
        v.addTarget(self, action: #selector(tabbarItemTapAction(sender:)), for: UIControl.Event.touchUpInside)
        return v
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = backViewColor
        initViews()
    }

    
    @objc func tabbarItemTapAction(sender: UIButton) {
        guard let b = mDelegate?.YYXibTabBarItemTap(title: labelName, tag: mTag) else {
            return
        }
        
        if b {
            isHighlight = true
        }
    }
    
    private func initViews() {
        if !imageDefaultName.isEmpty {
            self.addSubview(imageV)
            self.addConstraint(NSLayoutConstraint(item: imageV, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: imageTopSpace))
            self.addConstraint(NSLayoutConstraint(item: imageV, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        }
        
        if !labelName.isEmpty {
            self.addSubview(mLabel)
            mLabel.text = labelName
            let c = (ga_useLaunchImageType() != .iPhoneX_XS && ga_useLaunchImageType() != .iPhoneXR_XSMax && imageDefaultName.isEmpty) ? labelTopSpace - 20 : labelTopSpace
            self.addConstraint(NSLayoutConstraint(item: mLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: c))
            self.addConstraint(NSLayoutConstraint(item: mLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        }
        
        self.addSubview(button)
        self.addConstraint(NSLayoutConstraint(item: button, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: button, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: button, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: button, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0))
    }
    
    private func ga_useLaunchImageType() -> GANormalizeLaunchImageType {
        let w = UIScreen.main.bounds.width
        let h = UIScreen.main.bounds.height
        
        if w == 414 && h == 896 {
            return .iPhoneXR_XSMax
        } else if w == 375 && h == 812 {
            return .iPhoneX_XS
        } else if w == 414 && h == 736 {
            return .iPhone6_7_8
        } else if w == 375 && h == 667 {
            return .iPhone6_7_8
        } else {
            return .none
        }
    }
}
