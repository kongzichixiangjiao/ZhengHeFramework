//
//  GANormalizeNavigationView.swift
//  YYFramework
//
//  Created by 侯佳男 on 2019/1/24.
//  Copyright © 2019年 houjianan. All rights reserved.
//

import UIKit

enum GANormalizeNavigationViewButtonType: Int {
    case left = 0, otherLeft = 1, right = 2
}
protocol GANormalizeNavigationViewDelegate: class {
    func normalizeNavigationViewClicked(type: GANormalizeNavigationViewButtonType)
}

class GANormalizeNavigationView: UIView {

    weak var delegate: GANormalizeNavigationViewDelegate?
    
    @IBOutlet weak var lineView: UIView!
    
    @IBOutlet weak var titleLable: UILabel!
    
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var leftOtherButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    
    @IBOutlet weak var navigationBackView: UIView!
    
    @IBOutlet weak var titleLabelLeftSpace: NSLayoutConstraint!
    @IBOutlet weak var titleLabelRightSpace: NSLayoutConstraint!
    @IBOutlet weak var lineViewHeight: NSLayoutConstraint!
    
    public var isShowLineView: Bool! {
        didSet {
            lineViewHeight.constant =  1.0 / UIScreen.main.scale
            lineView.isHidden = !isShowLineView
        }
    }
    
    public var isShowLeftButton: Bool! {
        didSet {
            leftButton.isHidden = !isShowLeftButton
            
            _updateTitleLableSpace()
        }
    }
    
    public var isShowLeftOtherButton: Bool! {
        didSet {
            leftOtherButton.isHidden = !isShowLeftOtherButton
            
           _updateTitleLableSpace()
        }
    }
    public var isShowRightButton: Bool! {
        didSet {
            rightButton.isHidden = !isShowRightButton
            _updateTitleLableSpace()
        }
    }
    
    private func _updateTitleLableSpace() {
        if isShowLeftButton {
            titleLabelLeftSpace.constant = 44.0
            titleLabelRightSpace.constant = 44.0
        }else if isShowLeftOtherButton {
            titleLabelLeftSpace.constant = 100.0
            titleLabelRightSpace.constant = 100.0
        } else {
            titleLabelLeftSpace.constant = 0
            titleLabelRightSpace.constant = 0
        }
    }

    @IBAction func navigationButtonsAction(_ sender: UIButton) {
        delegate?.normalizeNavigationViewClicked(type: GANormalizeNavigationViewButtonType(rawValue: sender.tag)!)
    }
    
    public func nav_show(isShowLineView line: Bool = false, isShowLeftButton left: Bool = true, isShowLeftOtherButton leftOther: Bool = false, isShowRightButton right: Bool = false) {
        
        isShowLineView = line
        
        isShowLeftButton = left
        isShowLeftOtherButton = leftOther
        isShowRightButton = right
    }
    
    static func loadNavigationView() -> GANormalizeNavigationView {
        return Bundle.main.loadNibNamed("GANormalizeNavigationView", owner: self, options: nil)?.last as! GANormalizeNavigationView
    }
    
}
