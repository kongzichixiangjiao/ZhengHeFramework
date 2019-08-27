//
//  CTMediator.h
//  CTMediator
//
//  Created by casa on 16/3/13.
//  Copyright © 2016年 casa. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * const kCTMediatorParamsKeySwiftTargetModuleName;

@interface CTMediator : NSObject

+ (instancetype)sharedInstance;

// 远程App调用入口 - 直接跳转控制器
- (id)performDirectJumpVcWithUrl:(NSURL *)url toOc:(BOOL)isTrue completion:(void (^)(NSDictionary *))completion;

// 远程App调用入口 - 协议TargetClass对象和响应方法  可以回调传参
- (id)performActionWithUrl:(NSURL *)url toOc:(BOOL)isTrue callBack:(void(^)(NSDictionary *info))callback;

// 远程App调用入口 - 协议TargetClass对象和响应方法
- (id)performActionWithUrl:(NSURL *)url toOc:(BOOL)isTrue completion:(void(^)(NSDictionary *info))completion;

// 本地组件调用入口
- (id)performTarget:(NSString *)targetName toOc:(BOOL)isTrue action:(NSString *)actionName params:(NSDictionary *)params shouldCacheTarget:(BOOL)shouldCacheTarget;

- (void)releaseCachedTargetWithTargetName:(NSString *)targetName;

@end
