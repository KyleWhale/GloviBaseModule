//
//  HTAdBaseModel.h
//  GloviBaseModule
//
//  Created by 李雪健 on 2023/9/14.
//

#import "FLBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HTAdBaseModel : FLBaseModel

@property (nonatomic, copy) NSString *var_adId;//广告ID
@property (nonatomic, copy) NSString *var_pageName;
@property (nonatomic, assign) BOOL var_loadSuccess;
@property (nonatomic, assign) NSInteger section;
@property (nonatomic, assign) NSInteger row;
@property (nonatomic, strong, nullable) UIView *adView;
@property (nonatomic, assign) CGSize var_advertSize;
@property (nonatomic, assign) BOOL var_insertCell;//是否已经加入到cell中

- (void)ht_startLoadAdView;

@end

NS_ASSUME_NONNULL_END
