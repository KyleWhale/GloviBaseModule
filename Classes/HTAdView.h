//
//  HTAdView.h
//  Runner
//
//  Created by 李雪健 on 2023/9/14.
//

#import <UIKit/UIKit.h>
#import "HTAdBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@class HTAdView;
typedef void(^BLOCK_HTAdViewCloseButtonBlock) (HTAdView *view, HTAdBaseModel *var_adViewModel, UIView *var_ownerView, NSInteger index);
typedef void(^BLOCK_HTAdViewCloseBlock)(HTAdView *view, HTAdBaseModel *var_adViewModel, UIView *var_ownerView, NSInteger index);
typedef void(^BLOCK_HTAdViewLoadSuccessBlock)(BOOL success);

@interface HTAdView : UIView

#pragma mark - mrec
@property (nonatomic, assign) NSInteger rowIndex;
@property (nonatomic, strong) HTAdBaseModel *var_adViewModel;
@property (nonatomic, copy) BLOCK_HTAdViewCloseButtonBlock var_closeBlock;

// 仅仅显示，不加载广告，用作异步广告加载控制
- (void)ht_onlyShowWithAdViewModel:(HTAdBaseModel *)var_adViewModel andCloseButton:(BOOL)canClose andCloseBlock:(BLOCK_HTAdViewCloseButtonBlock)var_closeBlock;

// 自带加载广告
- (void)ht_loadAdWithIndex:(NSInteger)index andView:(UIView *)view andCloseButton:(BOOL)canClose andCloseBlock:(BLOCK_HTAdViewCloseButtonBlock)var_closeBlock;

// 隐藏广告
- (void)ht_hideMRECAdView;

#pragma mark - banner
- (void)ht_loadAdWithView:(UIView *)view;

- (void)ht_loadAdWithIndex:(NSInteger)index andView:(UIView *)ownerView andCloseButton:(BOOL)canClose andCloseBlock:(BLOCK_HTAdViewCloseBlock _Nullable)var_closeBlock andLoadBlock:(BLOCK_HTAdViewLoadSuccessBlock _Nullable)var_loadBlock;

- (void)ht_hideBannerAdView;

@end

NS_ASSUME_NONNULL_END
