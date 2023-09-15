

#import "LKFPrivateFunction.h"
#import "HTAccountModel.h"
#import "HTNetworkApi.h"

@implementation LKFPrivateFunction

+ (NSMutableDictionary *)lgjeropj_getVipParams {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString *var_p1String = @"";
    NSInteger var_p2String = 0;
    NSInteger var_sub1String = 0;
    NSString *var_sub2String = @"0";
    NSString *var_t1String = @"0";
    NSString *var_subidString = @"";
    if ([[HTAccountModel sharedInstance] ht_isVip]) {
        var_subidString = [HTAccountModel sharedInstance].var_bindAppId ?: @"";
        var_t1String = [HTAccountModel sharedInstance].var_toolVip ? @"2" : @"1";
        var_p2String = 2;
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"udf_isDeviceVip"]) {
            var_p1String = [[NSUserDefaults standardUserDefaults] stringForKey:@"udf_devicePid"];
            var_t1String = @"2";
        }
        if ([[HTAccountModel sharedInstance].var_familyPlanState isEqualToString:@"1"]) {
            var_p1String = [HTAccountModel sharedInstance].var_pid ?:@"";
            var_sub2String = [HTAccountModel sharedInstance].var_renewStatus;
        }
        if ([[HTAccountModel sharedInstance].var_bindPlanState isEqualToString:@"1"]) {
            var_p1String = [HTAccountModel sharedInstance].var_bindPid ?:@"";
            var_sub2String = [HTAccountModel sharedInstance].var_bindRenewStatus;
        }
        if ([[HTAccountModel sharedInstance] ht_isLocalVip]) {
            var_p1String = [[HTAccountModel sharedInstance] ht_pidByLocalVip];
            var_p2String = 1;
            NSString *var_localData = [[NSUserDefaults standardUserDefaults] objectForKey:STATIC_kIsFinishSubscribe];
            NSDictionary *localDataObj = [var_localData mj_JSONObject];
            NSString *var_renewStatus = kFormat(localDataObj[kSubscribeRenewStatusKey]).ht_isEmptyStr;
            var_sub1String = [var_renewStatus integerValue] > 0;
            var_t1String = @"1";
        }
    }
    [params setObject:var_p1String forKey:AsciiString(@"p1")];// 订阅产品ID
    [params setObject:@(var_p2String) forKey:AsciiString(@"p2")];// 0 未订阅 1 本地订阅 2 服务器订阅
    [params setObject:var_t1String forKey:AsciiString(@"t1")];
    [params setObject:@(var_sub1String) forKey:AsciiString(@"sub1")];
    [params setObject:var_sub2String forKey:AsciiString(@"sub2")];
    [params setObject:var_subidString forKey:AsciiString(@"subid")];
    [params setObject:[[NSBundle mainBundle] bundleIdentifier] forKey:AsciiString(@"apk_name")];
    return params;
}

@end
