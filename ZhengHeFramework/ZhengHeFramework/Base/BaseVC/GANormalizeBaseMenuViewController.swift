//
//  BaseMenuViewController.swift
//  FinancialPlanner
//
//  Created by puxin on 2019/4/28.
//  Copyright © 2019年 PUXIN. All rights reserved.
//

import UIKit

protocol MenuBarOptionProtocol {
    
    func menuHeaderViewSize() -> CGSize //必选
    func menuHeaderView() -> UIView //必选
    func menuViewitemOfLine() -> Int //必选
    func menuViewAllItemsNum() -> Int //必选
    func menuViewLineHeight() -> Int //必选
}

class GANormalizeBaseMenuViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,MenuBarOptionProtocol {
   
    func menuHeaderViewSize() -> CGSize {
        return CGSize.zero

    }
    
    func menuHeaderView() -> UIView {
        return UIView()

    }
    
    func menuViewitemOfLine() -> Int {
        return 3
    }
    
    func menuViewAllItemsNum() -> Int {
        return 4
    }
    
    func menuViewLineHeight() -> Int {
        return 3
    }
    
  
    var headerView:UIView!
    
    var subViewControllers:[UIViewController]! {
        
        didSet {
            
            for viewVC in subViewControllers {
                self.addChild(viewVC)
            }
            self.mainCollectionView.reloadData()
        }
    }
    lazy var mainCollectionView : BaseMenuViewCollecitonView = { [weak self] in
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize.init(width: self?.menuHeaderViewSize().width ?? 0 , height: UIScreen.main.bounds.height)
        let collectionView = BaseMenuViewCollecitonView(frame: CGRect.init(x: 0, y: self?.menuHeaderViewSize().height ?? 0.00, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = kCollectionBgColor
        return collectionView
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor  = UIColor.white
        self.view.addSubview(self.menuHeaderView())
        self.view.addSubview(self.mainCollectionView)
        mainCollectionView.dataSource = self
        mainCollectionView.delegate = self
        mainCollectionView.register(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "UICollectionViewCell")
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return subViewControllers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath)
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        let childVc = subViewControllers[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview((childVc.view)!)
        return cell
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let scrollOffx = scrollView.contentOffset.x / UIScreen.main.bounds.width
        self.getCollectionOffx(index: Int(scrollOffx))
    }
    
    func getCollectionOffx(index:Int) {
    
    
    
    }
    
}
//MARK: 解决滚动视图跟页面的其他滑动手势(PanGuesture)冲突问题

class BaseMenuViewCollecitonView: UICollectionView {
    
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        
        if gestureRecognizer.isKind(of: UIPanGestureRecognizer.classForCoder()) {
            let pan = gestureRecognizer as? UIPanGestureRecognizer
            if ((pan?.translation(in: self).x) ?? 0 > CGFloat(0)) && (self.contentOffset.x == CGFloat(0)) {
                return false
            }
        }
        return super.gestureRecognizerShouldBegin(gestureRecognizer)
    }
}
