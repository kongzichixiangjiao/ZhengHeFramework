//
//  GANormalizeTabBarViewController.swift
//  YYFramework
//
//  Created by 侯佳男 on 2019/2/21.
//  Copyright © 2019年 houjianan. All rights reserved.
//  self.title = "" 这个不要设置  YYBaseXibTabBarView配置导航样式  storyboard增删vc

import UIKit

class GANormalizeTabBarViewController: UITabBarController {
    
    public var vcs: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViewControllers()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func initViewControllers() {
        guard let arr = self.viewControllers else {
            print("viewControllers 为空")
            return
        }
        
        for vc in arr {
            if NSStringFromClass(type(of: vc)).components(separatedBy: ".").last! == "GANormalizeNavigationViewController" ||
                NSStringFromClass(type(of: vc)).components(separatedBy: ".").last! == "UINavigationViewController" {
                self.addChild(vc)
                self.vcs.append(vc)
            } else {
                let nav = GANormalizeNavigationController(rootViewController: vc)
                self.addChild(nav)
                self.vcs.append(nav)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        _addTabBarView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        _addTabBarView()
    }
    
    private func _addTabBarView() {
        for v in tabBar.subviews {
            v.removeFromSuperview()
        }
    }
    
    public func tabBar_AddTabView(v: GANormalizeTabbarView) {
        self.tabBar.insertSubview(v, at: 9)
    }
    
    public var tabBar_currentVC: UIViewController {
        return self.viewControllers![selectedIndex]
    }
    
    public func willShowVC(clickedIndex d_idnex: Int) -> UIViewController {
        return self.viewControllers![d_idnex]
    }
    
}

extension GANormalizeTabBarViewController: GANormalizeTabbarViewDelegate {
    func base_xibTabBarView(currentIndex c_index: Int, clickedIndex d_index: Int) {
        self.selectedIndex = d_index
    }
    
    func base_xibTabBarViewClickedCurrentItem(index: Int) {
        
    }
}
