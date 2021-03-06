//
//  GAControl.swift
//  YYFramework
//
//  Created by 侯佳男 on 2018/12/10.
//  Copyright © 2018年 houjianan. All rights reserved.
//

import UIKit

class GAPageControl: UIView {
    @IBInspectable var currentImageName: String = ""
    @IBInspectable var defaultImageName: String = ""
    
    @IBInspectable var currentImageColor: UIColor = UIColor.clear
    @IBInspectable var defaultImageColor: UIColor = UIColor.clear
    
    @IBInspectable var space: CGFloat = 5
    @IBInspectable var maxCount: Int = 6
    
    private var imageViews: [UIImageView] = []
    
    private var currentImageW: CGFloat = 4
    private var currentImageH: CGFloat = 4
    
    private var imageW: CGFloat = 0
    private var imageH: CGFloat = 0
    
    private var allW: CGFloat = 0
    private var allH: CGFloat = 0
    
    private var currentImageViewLeftContraint: NSLayoutConstraint!
    
    private var maxSpace: CGFloat = 0
  
    lazy var currentImageView: UIImageView = {
        let v = UIImageView()
        v.contentMode = .center
        v.translatesAutoresizingMaskIntoConstraints = false
        v.layer.cornerRadius = self.currentImageW / 2
        v.layer.masksToBounds = true
        v.image = UIImage(named: self.currentImageName)
        return v
    }()
    
    lazy var subView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor.clear
        return v
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initViews()
    }
    
    convenience init(frame: CGRect, currentImageColor: UIColor, defaultImageColor: UIColor, maxCount: Int, currentPage: Int) {
        self.init(frame: frame)
        self.maxCount = maxCount
        initViews(currentImageColor: currentImageColor, defaultImageColor: defaultImageColor)
        
        self.currentPage = currentPage
    }
    
    private func initViews(currentImageColor: UIColor = UIColor.white, defaultImageColor: UIColor = UIColor.black) {
        var currentImage: UIImage!
        var defaultImage: UIImage!
        if !currentImageName.isEmpty || !defaultImageName.isEmpty {
            currentImage = UIImage(named: currentImageName)
            defaultImage = UIImage(named: defaultImageName)
            
            currentImageH = currentImage?.size.height ?? 0
            currentImageW = currentImage?.size.width ?? 0
        } else {
            currentImage = currentImageColor.ga_image(viewSize: CGSize(width: currentImageW, height: currentImageH))
            defaultImage = defaultImageColor.ga_image(viewSize: CGSize(width: currentImageW, height: currentImageH))
        }
        self.currentImageView.image = currentImage
        
        maxSpace = max(currentImageW / 2, space)
        
        imageH = defaultImage?.size.height ?? 0
        imageW = defaultImage?.size.width ?? 0
        
        for _ in 0..<maxCount {
            let v = UIImageView()
            v.translatesAutoresizingMaskIntoConstraints = false
            v.image = defaultImage
            imageViews.append(v)
            allW += imageW
            allW += space
        }
        allH = max(imageH, currentImageH)
        
        self.addSubview(subView)
        self.addConstraint(NSLayoutConstraint(item: subView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: subView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        subView.addConstraint(NSLayoutConstraint(item: subView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: allW))
        subView.addConstraint(NSLayoutConstraint(item: subView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: allH))
        for i in 0..<maxCount {
            let v = imageViews[i]
            v.layer.cornerRadius = currentImageW / 2
            v.layer.masksToBounds = true 
            subView.addSubview(v)
            let left = CGFloat(i) * (space + imageW) + maxSpace / 2
            subView.addConstraint(NSLayoutConstraint(item: v, attribute: .left, relatedBy: .equal, toItem: subView, attribute: .left, multiplier: 1, constant: left))
            subView.addConstraint(NSLayoutConstraint(item: v, attribute: .centerY, relatedBy: .equal, toItem: subView, attribute: .centerY, multiplier: 1, constant: 0))
        }
        
        subView.addSubview(currentImageView)
        currentImageViewLeftContraint = NSLayoutConstraint(item: currentImageView, attribute: .left, relatedBy: .equal, toItem: subView, attribute: .left, multiplier: 1, constant: CGFloat(currentPage) * (space + imageW) + space / 2 + imageW - currentImageW / 2 - imageW / 2)
        subView.addConstraint(currentImageViewLeftContraint)
        subView.addConstraint(NSLayoutConstraint(item: currentImageView, attribute: .centerY, relatedBy: .equal, toItem: subView, attribute: .centerY, multiplier: 1, constant: 0))
    }
    
    var currentPage: Int = 0 {
        didSet {
            if self.currentPage == maxCount {
                self.currentPage = 0
            }
            currentImageViewLeftContraint.constant = CGFloat(currentPage) * (space + imageW) + space / 2 + imageW - currentImageW / 2 - imageW / 2
            
            UIView.animate(withDuration: 0.1) {
                self.subView.layoutIfNeeded()
            }
        }
    }
    
}

class GAColletionViewPageControl: UIView {
    
    @IBInspectable var currentImageName: String = "tabbar_mine_selected"
    @IBInspectable var defaultImageName: String = "page_control_point"
    
    @IBInspectable var space: CGFloat = 20
    @IBInspectable var maxCount: Int = 6
    
    private var currentImageW: CGFloat = 0
    private var currentImageH: CGFloat = 0
    
    private var imageW: CGFloat = 0
    private var imageH: CGFloat = 0
    
    private var allW: CGFloat = 0
    private var allH: CGFloat = 0
    
    private var currentImageViewLeftContraint: NSLayoutConstraint!
    
    var count: Int = 0
    
    lazy var currentImageView: UIImageView = {
        let v = UIImageView()
        v.contentMode = .center
        v.translatesAutoresizingMaskIntoConstraints = false
        v.image = UIImage(named: self.currentImageName)
        return v
    }()
    
    lazy var collectionView: UICollectionView = {
        let flow = UICollectionViewFlowLayout()
        flow.scrollDirection = .horizontal
        flow.minimumLineSpacing = 0
        flow.minimumInteritemSpacing = 0
        let v = UICollectionView(frame: CGRect(x: 0, y: 0, width: 210, height: 30), collectionViewLayout: flow)
        v.backgroundColor = UIColor.clear
        v.translatesAutoresizingMaskIntoConstraints = false
        v.isScrollEnabled = false 
        v.delegate = self
        v.dataSource = self
        return v
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let currentImage = UIImage(named: currentImageName)
        let defaultImage = UIImage(named: defaultImageName)
        
        currentImageH = currentImage?.size.height ?? 0
        currentImageW = currentImage?.size.width ?? 0
        currentImageW += 30
        
        imageH = defaultImage?.size.height ?? 0
        imageW = defaultImage?.size.width ?? 0
        
        for _ in 1..<maxCount {
            allW += imageW
            allW += space
        }
        
        allW += currentImageW
        allH = max(imageH, currentImageH)
        
        collectionView.yy_register(nibName: GAPageControlCell.identifier)
        self.addSubview(collectionView)

        self.addConstraint(NSLayoutConstraint(item: collectionView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: collectionView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        collectionView.addConstraint(NSLayoutConstraint(item: collectionView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: allW))
        collectionView.addConstraint(NSLayoutConstraint(item: collectionView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: allH))
        
        collectionView.addSubview(currentImageView)
        collectionView.addConstraint(NSLayoutConstraint(item: currentImageView, attribute: .centerY, relatedBy: .equal, toItem: collectionView, attribute: .centerY, multiplier: 1, constant: 0))
        currentImageView.addConstraint(NSLayoutConstraint(item: currentImageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: currentImageW))
        currentImageViewLeftContraint = NSLayoutConstraint(item: currentImageView, attribute: .left, relatedBy: .equal, toItem: collectionView, attribute: .left, multiplier: 1, constant: 0)
        collectionView.addConstraint(currentImageViewLeftContraint)
    }
    
    var currentPage: Int = 0 {
        didSet {
            if self.currentPage == maxCount {
                self.currentPage = 0
            }
            updateViews(count: self.currentPage)
        }
    }
    
    private func updateViews(count: Int) {
        self.count = count
        self.collectionView.reloadData()
        
        currentImageViewLeftContraint.constant = CGFloat(count) * (imageH + self.space)
        
        UIView.animate(withDuration: 0.3) {
            self.currentImageView.layoutIfNeeded()
            self.collectionView.layoutIfNeeded()
        }
    }
    
}

extension GAColletionViewPageControl: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GAPageControlCell.identifier, for: indexPath) as! GAPageControlCell
        let img = UIImage(named: self.defaultImageName)
        cell.mImageView.image = img
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return maxCount
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == self.count {
            return CGSize(width: currentImageW, height: currentImageH)
        } else {
            return CGSize(width: imageW + self.space, height: currentImageH)
        }
    }
}
