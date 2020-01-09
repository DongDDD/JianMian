//
//  TCommonContactSelectCellData.m
//  TXIMSDK_TUIKit_iOS
//
//  Created by annidyfeng on 2019/5/8.
//

#import "TCommonContactSelectCellData.h"
#import "TIMUserProfile+DataProvider.h"

@implementation TCommonContactSelectCellData

- (instancetype)init
{
    self = [super init];
    if (self) {
        _enabled = YES;
    }
    return self;
}

- (void)setProfile:(TIMUserProfile *)profile {
    NSData *data = profile.customInfo[@"gsname"];
    NSString *company_name = [[ NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    self.title = [profile showName];
    if (profile.faceURL.length) {
        self.avatarUrl = [NSURL URLWithString:profile.faceURL];
    }
    NSString *user_type =[profile.identifier substringFromIndex:[profile.identifier length]-1];
    if ([user_type isEqualToString:@"b"]) {
        self.company_name = company_name;         
    }
    self.identifier = profile.identifier;
}

- (NSComparisonResult)compare:(TCommonContactSelectCellData *)data
{
    return [self.title localizedCompare:data.title];
}

@end
