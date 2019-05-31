//
//  PXTabbarViewController.swift
//  ZhengHeFramework
//
//  Created by houjianan on 2019/3/21.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit

class PXTabbarViewController: GANormalizeTabBarViewController {
    
    lazy var xibTabBarView: GANormalizeTabbarView = {
        let v = PXTabbarView.loadBaseXibTabBarView(nibName: "PXTabbarView")
        v.mDelegate = self
        v.frame = CGRect(x: 0, y: 0, width: self.tabBar.bounds.width, height: kTabBarHeight)
        v.autoresizingMask = [.flexibleWidth, .flexibleHeight, .flexibleTopMargin, .flexibleLeftMargin]
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBar_AddTabView(v: xibTabBarView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tabBar_AddTabView(v: xibTabBarView)
    }
}

extension PXTabbarViewController {
    override func base_xibTabBarView(currentIndex c_index: Int, clickedIndex d_index: Int) {
        super.base_xibTabBarView(currentIndex: c_index, clickedIndex: d_index)
    }
    
    override func base_xibTabBarViewClickedCurrentItem(index: Int) {
        
    }
}
