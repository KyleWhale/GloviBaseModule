//
//  HTAdLovinManager.m
// 
//
//  Created by Apple on 2022/11/20.
//  Copyright © 2022 Apple. All rights reserved.
//

#import "HTAdLovinManager.h"
#import "HTAdViewManager.h"
#import "HTCommonConfiguration.h"

@interface HTAdLovinManager ()

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation HTAdLovinManager

+ (HTAdLovinManager *)sharedService {
    static HTAdLovinManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[HTAdLovinManager alloc] init];
    });
    return manager;
}

- (void)ht_addLoadWithAdPageName:(NSString *)var_pageName andSection:(NSInteger)section andRow:(NSInteger)row andAdSize:(CGSize)size{
    NSDictionary *applovinDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"udf_applovin"];
    NSString *var_adId = applovinDict[@"mrec"];
    if([NSString ht_isEmpty:var_adId] || !HTCommonConfiguration.lgjeropj_shared.BLOCK_appLovinSDKBlock()){
        return;
    }
    NSArray *array = [self ht_isExistLoadWithAdId:var_adId andPageName:var_pageName section:section row:row];
    if(array.count > 0){
        [self.nativeLoadSuccessSignal sendNext:array.lastObject];
        return;
    }
    HTAdBaseModel *model = [HTAdViewManager lgjeropj_adModel];
    model.var_adId = var_adId;
    model.var_pageName = var_pageName;
    model.section = section;
    model.row = row;
    model.var_loadSuccess = NO;
    model.var_advertSize = size;
    [model ht_startLoadAdView];
    [self.dataArray addObject:model];
}

- (void)ht_loadSuccessWith:(HTAdBaseModel *)model{
    if(model.var_insertCell){
        return;
    }
    [self.nativeLoadSuccessSignal sendNext:model];
}

- (void)ht_adDidHideWith:(HTAdBaseModel *)model{
    NSArray *array = [self ht_isExistLoadWithAdId:model.var_adId andPageName:model.var_pageName section:model.section row:model.row];
    if(array && array.count > 0){
        [self.dataArray removeObjectsInArray:array];
    }
}

- (void)ht_resetAdViewWithPage:(NSString *)var_pageName {
    
    NSString *predicateString = [NSString stringWithFormat:AsciiString(@"SELF.%@ == %@"), @"var_pageName", @"%@"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:predicateString, var_pageName];
    NSArray *resultArray = [self.dataArray filteredArrayUsingPredicate:predicate];
    if(resultArray && resultArray.count > 0){
        [self.dataArray removeObjectsInArray:resultArray];
    }
}

#pragma mark - Private Method
//判断是否已经加载过，避免重复加载，判断依据：广告ID+页面+分组+行
- (NSArray *)ht_isExistLoadWithAdId:(NSString *)var_adId andPageName:(NSString *)var_pageName section:(NSInteger)section row:(NSInteger)row {
    NSString *predicateString = [NSString stringWithFormat:AsciiString(@"SELF.%@ == %@ && SELF.%@ == %@ && SELF.section == %ld && SELF.row == %ld"), @"var_adId", @"%@", @"var_pageName", @"%@"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:predicateString, var_adId, var_pageName, section, row];
    NSArray *resultArray = [self.dataArray filteredArrayUsingPredicate:predicate];
    return resultArray;
}

- (NSMutableArray *)dataArray{
    if(!_dataArray){
        _dataArray = @[].mutableCopy;
    }
    return _dataArray;
}

- (RACSubject *)nativeLoadSuccessSignal {
    if (!_nativeLoadSuccessSignal) {
        _nativeLoadSuccessSignal = [RACSubject subject];
    }
    return _nativeLoadSuccessSignal;
}

@end


