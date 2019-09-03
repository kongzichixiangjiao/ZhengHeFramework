//
//  PXNotifyView.swift
//  PXNotifyView
//
//  Created by new on 2019/9/2.
//  Copyright © 2019 new. All rights reserved.
//

import UIKit

let PXNotifyView_kW = UIScreen.main.bounds.size.width
let PXNotifyView_navH = UIApplication.shared.statusBarFrame.size.height + UINavigationBar.appearance().bounds.size.height


class PXNotifyView: UIView {
    
    private var _showView:UIView? //keyWindow
    private var _notifyStr:String? //提示文字
    
    static func showNotify(_ notify:String) {
        _ = self.showNotify(notify, showView: UIApplication.shared.keyWindow!)
    }
    
    static func showNotify(_ notify:String, showView:UIView?) -> PXNotifyView {
        
        //参数配置工具类看需要再添加
        
        if let v:UIView = showView {
            return PXNotifyView.init(notify, showView: v)
        }
        return PXNotifyView.init(notify, showView: UIApplication.shared.keyWindow!)
    }
    
    convenience init(_ notify:String, showView:UIView) {
        self.init()
        
        _notifyStr = notify
            
        _showView = showView
            
        initUI()
        
        initNotifyAnimation()
    }
    
    private func initUI() {
        _showView?.addSubview(self)
        
        self.backgroundColor = UIColor.black
        
        //图标
        let iconImgV = UIImageView()
        let iconImg = UIImage.init(named: "toast_icon_warning")
        iconImgV.image = iconImg
        iconImgV.frame = CGRect.init(x: 16, y: 12, width: 16, height: 16)
        self.addSubview(iconImgV)
        
        //关闭按钮
        let closeIconImgV = UIImageView()
        let closeIconImg = UIImage.init(named: "icon_close")
        closeIconImgV.image = closeIconImg
        closeIconImgV.frame = CGRect.init(x: PXNotifyView_kW - 22 - 10, y: 10, width: 22, height: 22)
        closeIconImgV.isUserInteractionEnabled = true
        let closeTap = UITapGestureRecognizer.init(target: self, action: #selector(closeAction))
        closeIconImgV.addGestureRecognizer(closeTap)
        self.addSubview(closeIconImgV)
        
        //提示文字
        let msgLabel = UILabel()
        msgLabel.frame = CGRect.init(x: 40, y: 14, width: PXNotifyView_kW - 40 - 45, height: 0)
        msgLabel.numberOfLines = 0
        msgLabel.textAlignment = .left
        msgLabel.font = UIFont.systemFont(ofSize: 12)
        msgLabel.textColor = UIColor.white
        self.addSubview(msgLabel)
        
        msgLabel.text = _notifyStr
        msgLabel.sizeToFit()
        
        let sizeMessage = msgLabel.frame.size
        msgLabel.frame = CGRect.init(x: 40, y: 14, width: PXNotifyView_kW - 40 - 45, height: sizeMessage.height)
        self.frame = CGRect.init(x: 0, y: PXNotifyView_navH, width: PXNotifyView_kW, height: sizeMessage.height + 28)
      
    }
    
    private func initNotifyAnimation() {
        
        var fromPoint = self.center
        fromPoint.y = -self.frame.size.height
        let oldPoint = self.center
        
        if #available(iOS 9.0, *) {
            
            let animation = CABasicAnimation(keyPath: "position")
            animation.fromValue = NSValue(cgPoint: fromPoint)
            animation.toValue = NSValue(cgPoint: oldPoint)
            animation.duration = 0.5
            animation.isRemovedOnCompletion = false
            animation.fillMode = CAMediaTimingFillMode.forwards
            animation.delegate = self
            self.layer.add(animation, forKey: nil)
        }
        
    }
    
    
    @objc func closeAction() {
        
        var fromPoint = self.center
        fromPoint.y = -self.frame.size.height
        let oldPoint = self.center
        
        if #available(iOS 9.0, *) {
            
            let animation = CABasicAnimation(keyPath: "position")
            animation.fromValue = NSValue(cgPoint: oldPoint)
            animation.toValue = NSValue(cgPoint: fromPoint)
            animation.duration = 0.5
            animation.isRemovedOnCompletion = false
            animation.fillMode = CAMediaTimingFillMode.forwards
            animation.delegate = self
            self.layer.add(animation, forKey: "closeAnimation")
        }
        
    }
    
    class func close() {
        let viewArr = UIApplication.shared.keyWindow?.subviews
        for  view in viewArr! {
            if view.isKind(of: PXNotifyView.classForCoder()){
                view.removeFromSuperview()
            }
        }
    }

}

//CAAnimationDelegate
extension PXNotifyView:CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        let closeAnimation = self.layer.animation(forKey: "closeAnimation")
        if (anim == closeAnimation) {
            PXNotifyView.close()
        }
    }
}
