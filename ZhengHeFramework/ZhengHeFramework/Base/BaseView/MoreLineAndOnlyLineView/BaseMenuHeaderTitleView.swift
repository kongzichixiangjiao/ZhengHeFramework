//
//  BaseMenuHeaderTitleView.swift
//  FinancialPlanner
//
//  Created by puxin on 2019/4/29.
//  Copyright © 2019年 PUXIN. All rights reserved.
//

import UIKit

protocol BaseMenuHeaderTitleViewDelegate: class {
    
    func touchHeaderItemIndex(index:Int)
}

class BaseMenuHeaderTitleView: UIView,UICollectionViewDataSource,UICollectionViewDelegate {
 
    private var _selectedColor: UIColor!
    private var _normalColor: UIColor!
    private var _bgColor: UIColor!
    private var _cellHeight: CGFloat! = 40
    private var _cellWidth: CGFloat!
    private var _seletIndex:Int = 0
    private var _topSpaceHeight:CGFloat!
    private var _bottomSpaceHeight:CGFloat!
    private var _rowItem:Int! = 2
    private var _titleArrays:[String]! = []

    
    weak var delegate: BaseMenuHeaderTitleViewDelegate?
    
    private var _menuScrollDirection: UICollectionView.ScrollDirection! = .horizontal //默认横向滑动  vertical纵向滑动

    
    
    lazy var headerCollectionView : UICollectionView = { [weak self] in
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = self?._menuScrollDirection ?? .horizontal
        
        if self?._menuScrollDirection == .horizontal {
        layout.itemSize = CGSize.init(width: self?._titleArrays.count ?? 0 < 5 ? UIScreen.main.bounds.width / CGFloat(self?._titleArrays.count ?? Int(0.00)) : UIScreen.main.bounds.width / 4.5  , height: 44)
        }else {
            layout.itemSize = CGSize.init(width: UIScreen.main.bounds.width / CGFloat(self?._rowItem ?? 2), height: 140)
        }
        
        var collectionHeight :CGFloat = 40.0
        if self?._menuScrollDirection == .vertical {
            
            let str = String(format: "%.5f", self?._titleArrays.count ?? 0 / CGFloat(self?._rowItem ?? 2))
            
            collectionHeight = CGFloat(ceil(Double(str)!) * Double(_cellHeight))
        }
        
        let collectionView = UICollectionView(frame: CGRect.init(x: 0, y: 0 , width: UIScreen.main.bounds.width, height: collectionHeight), collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.bounces = false
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = kCollectionBgColor
        return collectionView
        }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
    }
    convenience init(frame: CGRect,titleArray:[String],rowItem:Int = 4,menuScrollDirection: UICollectionView.ScrollDirection! = .horizontal,viewHeigt:CGFloat = 44.0,topSpaceHeight:CGFloat = 10.0,bottomSpaceHeight:CGFloat = 10.0,selectColor:UIColor = UIColor.init(r: 34, g: 131, b: 223),normalColor:UIColor = UIColor.init(r: 153, g: 153, b: 153)) {
        self.init(frame: frame)
        
        self._titleArrays = titleArray
        self._topSpaceHeight = topSpaceHeight
        self._bottomSpaceHeight = bottomSpaceHeight
        self._selectedColor = selectColor
        self._normalColor = normalColor
        self._rowItem = rowItem
        self._menuScrollDirection = menuScrollDirection
        _initColleciton()
    }
    
    private func _initColleciton(){
    
      self.addSubview(self.headerCollectionView)
        
     self.headerCollectionView.register(UINib.init(nibName: "ZHMenuScrollItemCell", bundle: nil), forCellWithReuseIdentifier: "ZHMenuScrollItemCell")
    self.headerCollectionView.reloadData()

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ZHMenuScrollItemCell.identifier, for: indexPath) as! ZHMenuScrollItemCell
        cell.titleLabel.text = self._titleArrays[indexPath.row]
        cell.lineView.isHidden = _seletIndex == indexPath.item ? false : true
        cell.titleLabel.textColor = _seletIndex == indexPath.item ? _selectedColor : _normalColor
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self._titleArrays.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        _seletIndex = indexPath.item


        self.headerCollectionView.reloadData()
        self.headerCollectionView.scrollToItem(at: indexPath, at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)

        delegate?.touchHeaderItemIndex(index: _seletIndex)

    }
    
    func changeTitleColor(index:Int) {
     
        
        _seletIndex = index
        self.headerCollectionView.reloadData()
        let indexPath = IndexPath.init(row: _seletIndex, section: 0)
        self.headerCollectionView.scrollToItem(at: indexPath, at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)


    }
}
