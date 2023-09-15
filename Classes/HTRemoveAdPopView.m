//
//  HTRemoveAdPopView.m
// 
//
//  Created by Apple on 2022/11/26.
//  Copyright © 2022 Apple. All rights reserved.
//

#import "HTRemoveAdPopView.h"

@interface HTRemoveAdPopView ()

@property (nonatomic, strong) UIButton *removeAdsBtn;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, assign) NSInteger var_adIndex;

@end

@implementation HTRemoveAdPopView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self lgjeropj_setupSubviews];
    }
    return self;
}


- (void)lgjeropj_setupSubviews {
    self.backgroundColor = [UIColor ht_colorWithHexString:@"#1A1A25"];
    self.layer.cornerRadius = 4;
    self.clipsToBounds = YES;
    
    [self addSubview:self.removeAdsBtn];
    [self addSubview:self.cancelBtn];
    
    [self.removeAdsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(29);
        make.leading.mas_equalTo(self).offset(15);
        make.trailing.mas_equalTo(self).inset(15);
        make.height.mas_equalTo(34);
    }];
    
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.removeAdsBtn.mas_bottom).offset(24);
        make.leading.mas_equalTo(self).offset(15);
        make.trailing.mas_equalTo(self).inset(15);
        make.height.mas_equalTo(34);
    }];
    
}

- (void)dismiss{
    if(self.superview){
        [self removeFromSuperview];
    }
}

+ (void)ht_showInView:(UIView *)targetView andPoint:(CGPoint)point andDoneBlock:(BLOCK_HTAdPopViewOperationBlock)doneBlock{
    if(targetView){
        for (UIView *view in targetView.subviews) {
            if([view isKindOfClass:HTRemoveAdPopView.class]){
                [view removeFromSuperview];
            }
        }
    }
    CGFloat originHeight = CGRectGetHeight(targetView.frame);
    CGFloat originY = 0;
    if(originHeight > 150){
        originY = (originHeight - 150) * 0.5;
    }else{
        originY = point.y;
    }
    originY = point.y;
    HTRemoveAdPopView *removeAdPopView = [[HTRemoveAdPopView alloc] initWithFrame:CGRectMake(point.x, originY, 230, 150)];
    removeAdPopView.tag = 3180065;
    [targetView addSubview:removeAdPopView];
    @weakify(removeAdPopView);
    [removeAdPopView.removeAdSubject subscribeNext:^(id  _Nullable x) {
        if(doneBlock){
            doneBlock(removeAdPopView_weak_, ENUM_HTAdPopViewButtonTypeGetPrmium);
        }
    }];
    [removeAdPopView.cancelSubject subscribeNext:^(id  _Nullable x) {
        if(doneBlock){
            doneBlock(removeAdPopView_weak_, ENUM_HTAdPopViewButtonTypeCancel);
        }
    }];
}

+(UIView *)ht_getBackView
{
    return (HTRemoveAdPopView *)[[[UIApplication sharedApplication] keyWindow] viewWithTag:3180065];
}

- (void)btnClick:(UIButton *)sender {
    if (sender == self.removeAdsBtn) {
        [self.removeAdSubject sendNext:nil];
    } else {
        [self.cancelSubject sendNext:nil];
    }
}

#pragma mark -- lzay load
- (UIButton *)removeAdsBtn {
    if (!_removeAdsBtn) {
        _removeAdsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_removeAdsBtn setTitle:LocalString(@"GET PREMIUM TO REMOVE ADS", nil) forState:UIControlStateNormal];
        [_removeAdsBtn setBackgroundColor:[UIColor ht_colorWithHexString:@"#CCCCCC"]];
        [_removeAdsBtn setTitleColor:[UIColor ht_colorWithHexString:@"#222222"] forState:UIControlStateNormal];
        _removeAdsBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_removeAdsBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _removeAdsBtn;
}

- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelBtn setTitle:LocalString(@"CANCEL", nil) forState:UIControlStateNormal];
        [_cancelBtn setBackgroundColor:[UIColor ht_colorWithHexString:@"#CCCCCC"]];
        [_cancelBtn setTitleColor:[UIColor ht_colorWithHexString:@"#222222"] forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_cancelBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (RACSubject *)removeAdSubject {
    if (!_removeAdSubject) {
        _removeAdSubject = [RACSubject subject];
    }
    return _removeAdSubject;
}

- (RACSubject *)cancelSubject {
    if (!_cancelSubject) {
        _cancelSubject = [RACSubject subject];
    }
    
    return _cancelSubject;
}


@end
