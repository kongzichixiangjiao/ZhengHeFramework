//
//  ZHBaseBridgeWebviewController.swift
//  PuXinFinancial
//
//  Created by puxin on 2019/2/12.
//  Copyright © 2019年 ZHENGHE. All rights reserved.
//

import UIKit
import dsBridge

private let webWidth                             = UIScreen.main.bounds.width
private let webHeight                            = UIScreen.main.bounds.height
let webNavBarHeight:       CGFloat      = webHeight >= 812 ? 88 : 64


class ZHBaseBridgeWebviewController: GANormalizeBaseViewController,WKNavigationDelegate,ZHDsbridgeUtilsToolsDelegate {
    
    private var webUrl:String = ""
    private var bridgeNameTool:ZHBaseDsbridgeUtilsTools?
    private var appUserAgent = "" //普信财富顾问app的userAgent标识
    var dwebview:DWKWebView!

    //进度条
    open lazy var topProgressView : UIProgressView = {
        let loadingProgressView = UIProgressView(frame: CGRect.init(x: 0, y: webNavBarHeight, width: webHeight, height: 2))
        loadingProgressView.progressTintColor = UIColor.orange
        return loadingProgressView
    }()
    
    convenience init(url:String,_ appUserAgent:String = "ZHXX_JF_IOS", _ title:String = "", _ bridgeName:ZHBaseDsbridgeUtilsTools = ZHBaseDsbridgeUtilsTools() ) {
        self.init()
        self.title = title
        self.webUrl = url
        self.appUserAgent = appUserAgent
        self.bridgeNameTool = bridgeName
    }
    
    @objc func backClick() {
        if !dwebview.canGoBack {
          self.navigationController?.popViewController(animated: true)
        }else {
         dwebview.goBack()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bridgeNameTool?.delegate = self
        self.dwebview = DWKWebView.init(frame: CGRect.init(x: 0, y: webNavBarHeight, width: kScreenWidth, height: kScreenHeight - kNavigationHeight))
        dwebview.addJavascriptObject(self.bridgeNameTool, namespace: nil)
        dwebview.setDebugMode(true)
        dwebview.navigationDelegate = self
        dwebview.loadUrl(self.webUrl)
        if #available(iOS 12.0, *) {
        let oldUA:String = dwebview.value(forKey: "applicationNameForUserAgent") as! String
        let newUA = "\(String(describing: oldUA)) \(self.appUserAgent)"
            dwebview.setValue(newUA, forKey: "applicationNameForUserAgent")
            
        }else {
        //12.0以前的版本
        dwebview.evaluateJavaScript("navigator.userAgent") {(data, errs) in
            let newUA = "\(String(describing: data)) \(self.appUserAgent)"
            self.dwebview.customUserAgent = newUA
            }
        }
        view.addSubview(dwebview)
        dwebview.addObserver(self, forKeyPath: "estimatedProgress", options: [NSKeyValueObservingOptions.new], context: nil)
        dwebview.addObserver(self, forKeyPath: "title", options: [NSKeyValueObservingOptions.new], context: nil)
        
        dwebview.setJavascriptCloseWindowListener {
            print("已经关闭了")
        }
   
        
       //如果调取js方法参数不能为空
        dwebview.callHandler("zhGetArticleDetailId") { (articleId) in
            
            print(articleId ?? "")
            //            self.requestShareDetailData(articleId as! String)
        }
        
        //添加进度条
        self.view.addSubview(topProgressView)

    }
    fileprivate func _setNavRightBackItems(){
        
        if dwebview.canGoBack {
            let leftBarButtonItem = UIBarButtonItem(imageName: "NavigationBar_Back", rect: CGRect(x: 0, y: 0, width: 44, height: 44), imageEdgeInsets: UIEdgeInsets(top: 0, left: -30, bottom: 0, right: 0), target: self, action:  #selector(backClick))
            
            let closeBarBtnItem = UIBarButtonItem(imageName: "nav_btn_cancel", rect: CGRect(x: 0, y: 0, width: 44, height: 44), imageEdgeInsets: UIEdgeInsets(top: 0, left: -30, bottom: 0, right: 0), target: self, action:  #selector(closeClick))
            
            self.navigationItem.leftBarButtonItems = [leftBarButtonItem,closeBarBtnItem]
            
        }else{
            let leftBarButtonItem = UIBarButtonItem(imageName: "NavigationBar_Back", rect: CGRect(x: 0, y: 0, width: 44, height: 44), imageEdgeInsets: UIEdgeInsets(top: 0, left: -30, bottom: 0, right: 0), target: self, action:  #selector(backClick))
            
            self.navigationItem.leftBarButtonItems = [leftBarButtonItem]
        }
    }

    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
        topProgressView.isHidden = false
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        _setNavRightBackItems()

    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        decisionHandler(.allow)
        
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {

    }
    
    //MARK: ------ 监听加载进度
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            let progress: Float = (change?[NSKeyValueChangeKey.newKey] as! NSNumber).floatValue
            topProgressView.progress = progress
            if topProgressView.progress == 1.0 {
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double((Int64)(0.4 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: {
                    self.topProgressView.isHidden = true
                })
            }
        }else if keyPath == "title" {
            
            if dwebview.title != nil && dwebview.title != ""{
                self.title = dwebview.title
            }
        }
    }
    //MARK: ZHDsbridgeUtilsToolsDelegate代理
    func operationSucceeded() {
        
    }
 
    
    @objc func closeClick() -> Void {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK:顶部分享按钮
    @objc fileprivate  func sharedClicked(_ sender:UIBarButtonItem) {
        //app调取前端js方法
        dwebview.callHandler("zhGetArticleDetailId") { (articleId) in
            
            print(articleId ?? "")
            // self.requestShareDetailData(articleId as! String)
        }
    }
    
    //MARK:请求分享接口数据
    func requestShareDetailData(_ projectId:String) -> Void {
    

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    deinit {
        dwebview.removeObserver(self, forKeyPath: "estimatedProgress")
        dwebview.removeObserver(self, forKeyPath: "title")
    }

}
