//
//  PXTestMenuViewController.swift
//  FinancialPlanner
//
//  Created by puxin on 2019/4/26.
//  Copyright © 2019年 PUXIN. All rights reserved.
//

import UIKit

class PXTestMenuViewController: GANormalizeBaseMenuViewController,BaseMenuHeaderTitleViewDelegate,ZHMenuBarMoreLineViewDelegate {

    let titleArray = ["宏观经济","配置策略","证券透视","固收聚焦","公募周报","财经晚报"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
    self.subViewControllers = [UIViewController(),UIViewController(),UIViewController(),UIViewController(),UIViewController(),UIViewController()];
        
    }
    //活动效果
    lazy var scrollHeaderView :BaseMenuHeaderTitleView = { [weak self] in
        
        let scrollviewVC = BaseMenuHeaderTitleView.init(frame: CGRect.init(x: 0, y: UIScreen.main.bounds.height == 812 ? 88 : 64, width: UIScreen.main.bounds.width, height: 150), titleArray: self?.titleArray ?? [])
        scrollviewVC.delegate = self
        scrollviewVC.backgroundColor = kMainColor
        
        return scrollviewVC
        }()
    
    //多排效果
    lazy var doubleView:ZHMenuBarMoreLineView = {
        
        let str = String(format: "%.5f", CGFloat(self.titleArray.count)/4.0)
        let v = ZHMenuBarMoreLineView()
        v.frame = CGRect.init(x: 0, y: kNavigationHeight + 10, width: kScreenWidth, height:CGFloat(ceil(Double(str)!) * Double(40)))
        v.delegate = self
        v.titles = self.titleArray;
        v.backgroundColor = UIColor.white
        return  v
    }()
    
    override func menuHeaderView() -> UIView {
        
        return self.doubleView
    }
    
    override func menuHeaderViewSize() -> CGSize {
        return CGSize.init(width:UIScreen.main.bounds.width, height:self.doubleView.frame.maxY)
    }
    
    
    func touchHeaderItemIndex(index: Int) {
        
        let indexPath = IndexPath.init(row: index, section: 0)
        self.mainCollectionView.scrollToItem(at: indexPath, at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
        
//        [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionTop animated:true];
    }
    
    //滑动tableview的delegate事件
    override func getCollectionOffx(index:Int) {
                
        self.scrollHeaderView.changeTitleColor(index: index)
       self.doubleView.calueYellowBottomSepearte(index: index);
    }
    
    //ZHMenuBarMoreLineViewDelegate
    func clickBtnIndex(_ index: Int) {
        
        let indexPath = IndexPath.init(row: index, section: 0)
        self.mainCollectionView.scrollToItem(at: indexPath, at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
    }
}
