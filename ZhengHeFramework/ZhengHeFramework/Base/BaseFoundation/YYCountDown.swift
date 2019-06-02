//
//  YYTimer.swift
//  YYFramework
//
//  Created by 侯佳男 on 2018/8/13.
//  Copyright © 2018年 houjianan. All rights reserved.
//  倒计时工具类

import Foundation

class YYCountDown {
    
    typealias YYCountDownHandler = (_ count: Int, _ finished: Bool) -> ()
    
    // 定时器timer
    private var timer: DispatchSourceTimer?
    // 倒计时计数使用
    private var timerCount: Int = -1
    
    convenience init(sourceTimerCount: Int = 3) {
        self.init()
        self.timerCount = sourceTimerCount
    }
    
    // 添加倒计时方法
    public func addTimer(handler: @escaping YYCountDownHandler) {
        // 子线程创建timer
        timer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.global())
        //        let timer = DispatchSource.makeTimerSource()
        /*
         dealine: 开始执行时间
         repeating: 重复时间间隔
         leeway: 时间精度
         */
        timer?.schedule(deadline: .now() + .seconds(0), repeating: DispatchTimeInterval.seconds(1), leeway: DispatchTimeInterval.seconds(0))
        // timer 添加事件
        
        timer?.setEventHandler {
            self.timerCount -= 1
            // 倒计时结束
            if (self.timerCount == 0) {
                // 取消倒计时
                self.cancleTimer()
                DispatchQueue.main.async {
                    handler(-1, true)
                }
            } else {
                DispatchQueue.main.async {
                    // 倒计时更改UI
                    handler(self.timerCount, false)
                    
                }
            }
        }
        timer?.resume()
    }
    // timer暂停
    public func stopTimer() {
        timer?.suspend()
    }
    // timer结束
    public func cancleTimer() {
        guard let t = timer else {
            return
        }
        t.cancel()
        timer = nil
    }
    
    deinit {
        print("deinit YYCountDown")
    }
}


