//
//  HTRemoveAdPopView.h
// 
//
//  Created by Apple on 2022/11/26.
//  Copyright © 2022 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReactiveObjC.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, ENUM_HTAdPopViewButtonType) {
    ENUM_HTAdPopViewButtonTypeGetPrmium,
    ENUM_HTAdPopViewButtonTypeCancel,
};

@class HTRemoveAdPopView;
typedef void(^BLOCK_HTAdPopViewOperationBlock)(HTRemoveAdPopView *var_popView, ENUM_HTAdPopViewButtonType type);

@interface HTRemoveAdPopView : UIView
@property (nonatomic, strong) RACSubject *removeAdSubject;
@property (nonatomic, strong) RACSubject *cancelSubject;

- (void)dismiss;

+ (void)ht_showInView:(UIView *)targetView andPoint:(CGPoint)point andDoneBlock:(BLOCK_HTAdPopViewOperationBlock)doneBlock;

+(UIView *)ht_getBackView;
@end

NS_ASSUME_NONNULL_END
