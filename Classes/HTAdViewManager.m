//
//  HTAdViewManager.m
//  Runner
//
//  Created by 李雪健 on 2023/9/14.
//

#import "HTAdViewManager.h"

@implementation HTAdViewManager

+ (HTAdBaseModel *)lgjeropj_adModel {
    return [[NSClassFromString(@"HTAdLovinLoadModel") alloc] init];
}

+ (HTAdView *)lgjeropj_mrecAdView {
    return [[NSClassFromString(@"HTMRECAdContainerView") alloc] init];
}

+ (HTAdView *)lgjeropj_bannerAdView {
    return [[NSClassFromString(@"HTBannerAdView") alloc] init];
}

@end
