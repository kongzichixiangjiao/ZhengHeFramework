//
//  Extension.swift
//  ZhengHeFramework
//
//  Created by puxin on 2019/6/4.
//  Copyright © 2019年 houjianan. All rights reserved.
//

import UIKit
import Foundation

//MARK: 获取水印图片方法
private let HORIZONTAL_SPACE:CGFloat = 40
private let VERTICAL_SPACE:CGFloat = 100//竖直间距
private let CG_TRANSFORM_ROTATION:Double = -(Double.pi / 2 / 3)//旋转角度(正旋45度 || 反旋45度)
private let density:CGFloat = 0.8 //字体密度比例
extension UIImage {
    
   func getWaterMarkImage(title:String,titleFont:UIFont = UIFont.systemFont(ofSize: 11),titleColor:UIColor = UIColor.lightGray) -> UIImage {
        
        let font:UIFont = titleFont
        //原始image的宽高
        let viewWidth:CGFloat = kScreenWidth * density
        let viewHeight:CGFloat = kScreenHeight * density
        //为了防止图片失真，绘制区域宽高和原始图片宽高一样
        //    UIGraphicsBeginImageContext(CGSize.init(width: viewWidth, height: viewHeight))
        UIGraphicsBeginImageContextWithOptions(CGSize.init(width: viewWidth, height: viewHeight), false, UIScreen.main.scale);
        
        //先将原始image绘制上
        self.draw(in: CGRect.init(x: 0, y: 0, width: viewWidth, height: viewHeight))
        //sqrtLength：原始image的对角线length。在水印旋转矩阵中只要矩阵的宽高是原始image的对角线长度，无论旋转多少度都不会有空白。
        
        let sqrtLength:CGFloat = sqrt(viewWidth * viewWidth + viewHeight * viewWidth)
        //文字的属性
        let mark:String = title as String
        let attrStr:NSMutableAttributedString = NSMutableAttributedString.init(string: mark, attributes: [NSAttributedString.Key.font : font,NSAttributedString.Key.foregroundColor : titleColor])
        
        //绘制文字的宽高
        let strWidth:CGFloat = attrStr.size().width
        let strHeight:CGFloat = attrStr.size().height
        
        //开始旋转上下文矩阵，绘制水印文字
        let context:CGContext = UIGraphicsGetCurrentContext()!
        //将绘制原点（0，0）调整到源image的中心
        context.concatenate(CGAffineTransform(translationX: viewWidth/2, y: viewHeight/2));
        
        //以绘制原点为中心旋转
        context.concatenate(CGAffineTransform(rotationAngle: CGFloat(CG_TRANSFORM_ROTATION)));
        //将绘制原点恢复初始值，保证当前context中心和源image的中心处在一个点(当前context已经旋转，所以绘制出的任何layer都是倾斜的)
        context.concatenate(CGAffineTransform(translationX: -viewWidth/2, y: -viewHeight/2));
        //计算需要绘制的列数和行数
        let horCount:NSInteger = NSInteger((sqrtLength / (strWidth + HORIZONTAL_SPACE)) + 1);
        let verCount:NSInteger = NSInteger((sqrtLength / (strHeight + VERTICAL_SPACE)) + 1);
        //此处计算出需要绘制水印文字的起始点，由于水印区域要大于图片区域所以起点在原有基础上移
        let orignX:CGFloat = -(sqrtLength-viewWidth)/2
        let orignY:CGFloat = -(sqrtLength-viewHeight)/2
        //在每列绘制时X坐标叠加
        var tempOrignX:CGFloat = orignX;
        //在每行绘制时Y坐标叠加
        var tempOrignY:CGFloat = orignY;
        
        for i in 0...horCount*verCount {
            attrStr.draw(in: CGRect.init(x: tempOrignX, y: tempOrignY, width: strWidth, height: strHeight))
            
            if (i % horCount == 0 && i != 0) {
                tempOrignX = orignX;
                tempOrignY += (strHeight + VERTICAL_SPACE);
            }else{
                tempOrignX += (strWidth + HORIZONTAL_SPACE);
            }
        }
        //根据上下文制作成图片
        let finalImg:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        context.strokePath()
        
        //    finalImg = finalImg.stretchableImage(withLeftCapWidth: Int(finalImg.size.width * 0.5), topCapHeight: Int(finalImg.size.height * 0.5))
        
        return finalImg
    }

    
    
}
