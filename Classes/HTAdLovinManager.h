//
//  HTAdLovinManager.h
// 
//
//  Created by Apple on 2022/11/20.
//  Copyright © 2022 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveObjC.h"
#import "HTAdBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HTAdLovinManager : NSObject

/// 是否停止广告
@property (nonatomic, assign) BOOL var_stopAd;


@property (nonatomic, strong) RACSubject *nativeLoadSuccessSignal;

+ (HTAdLovinManager *)sharedService;

- (void)ht_addLoadWithAdPageName:(NSString *)var_pageName andSection:(NSInteger)section andRow:(NSInteger)row andAdSize:(CGSize)size;

- (void)ht_loadSuccessWith:(HTAdBaseModel *)model;

- (void)ht_adDidHideWith:(HTAdBaseModel *)model;

// 重置某个页面的异步加载和显示
- (void)ht_resetAdViewWithPage:(NSString *)var_pageName;

@end

NS_ASSUME_NONNULL_END
