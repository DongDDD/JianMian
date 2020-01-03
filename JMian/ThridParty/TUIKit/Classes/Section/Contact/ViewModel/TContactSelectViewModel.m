//
//  TContactSelectViewModel.m
//  TXIMSDK_TUIKit_iOS
//
//  Created by annidyfeng on 2019/5/8.
//

#import "TContactSelectViewModel.h"
#import "TCommonContactSelectCellData.h"
#import "NSString+Common.h"
#import "THeader.h"
#import "ReactiveObjC.h"
@import ImSDK;

@interface TContactSelectViewModel()
@property NSDictionary<NSString *, NSArray<TCommonContactSelectCellData *> *> *dataDict;
@property NSArray *groupList;
@property BOOL isLoadFinished;
@end

@implementation TContactSelectViewModel


- (void)loadContacts
{
    self.isLoadFinished = NO;
    
    NSArray<TIMFriend *> *friends = [[TIMFriendshipManager sharedInstance] queryFriendList];
    if (friends.count > 0) {
        [self fillList:[self allProfiles:friends]];
    }
    else {
        @weakify(self)
        [[TIMFriendshipManager sharedInstance] getFriendList:^(NSArray<TIMFriend *> *friends) {
            @strongify(self)
            [self fillList:[self allProfiles:friends]];
        } fail:nil];
    }
}

- (void)setSourceIds:(NSArray<NSString *> *)ids
{
    [[TIMFriendshipManager sharedInstance] getUsersProfile:ids forceUpdate:NO succ:^(NSArray<TIMUserProfile *> *profiles) {
        [self fillList:profiles];
    } fail:nil];
}

- (NSArray<TIMUserProfile *> *)allProfiles:(NSArray<TIMFriend *> *)friends
{
    NSMutableArray *arr = [NSMutableArray new];
    for (TIMFriend *fr in friends) {
        [arr addObject:fr.profile];
    }
    return arr;
}

- (void)fillList:(NSArray<TIMUserProfile *> *)profiles
{
    NSMutableDictionary *dataDict = @{}.mutableCopy;
    NSMutableArray *groupList = @[].mutableCopy;
    NSMutableArray *nonameList = @[].mutableCopy;
    
    for (TIMUserProfile *profile in profiles) {
        NSString *user_type =[profile.identifier substringFromIndex:[profile.identifier length]-1];

        NSData *bstepData = profile.customInfo[@"bstep"];
        NSData *cstepData = profile.customInfo[@"astep"];
        NSData *abilityData = profile.customInfo[@"jianzhi"];

        NSString *company_stepStr = [[ NSString alloc] initWithData:bstepData encoding:NSUTF8StringEncoding];
        NSString *user_stepStr = [[ NSString alloc] initWithData:cstepData encoding:NSUTF8StringEncoding];
        NSString *ability = [[ NSString alloc] initWithData:abilityData encoding:NSUTF8StringEncoding];

        NSInteger company_stepInt = [company_stepStr integerValue];
        NSInteger user_stepInt = [user_stepStr integerValue];
        NSInteger ability_count = [ability integerValue];

        if ([user_type isEqualToString:@"a"]) {
            if (!(user_stepInt > 5 || ability_count > 0)) {
                    continue;         
            }
        }
//
//        if ([user_type isEqualToString:@"b"]) {
//            if (company_stepInt < 5) {
//                return;
//            }
//        }
        if ([user_type isEqualToString:@"b"]) {
            if (company_stepInt < 4) {
                continue;
            }
            
        }
        
        TCommonContactSelectCellData *data = [TCommonContactSelectCellData new];
        [data setProfile:profile];
        
        if (self.avaliableFilter && !self.avaliableFilter(data)) {
            continue;
        }
        if (self.disableFilter) {
            data.enabled = !self.disableFilter(data);
        }
        
        NSString *group = [[data.title firstPinYin] uppercaseString];
        if (group.length == 0 || !isalpha([group characterAtIndex:0])) {
            [nonameList addObject:data];
            continue;
        }
        NSMutableArray *list = [dataDict objectForKey:group];
        if (!list) {
            list = @[].mutableCopy;
            dataDict[group] = list;
            [groupList addObject:group];
        }
        [list addObject:data];
    }
    
    [groupList sortUsingSelector:@selector(localizedStandardCompare:)];
    if (nonameList.count) {
        [groupList addObject:@"#"];
        dataDict[@"#"] = nonameList;
    }
    for (NSMutableArray *list in [self.dataDict allValues]) {
        [list sortUsingSelector:@selector(compare:)];
    }
    
    self.groupList = groupList;
    self.dataDict = dataDict;
    self.isLoadFinished = YES;
}

@end
