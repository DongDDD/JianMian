//
//  JMCreateGroupViewController.m
//  JMian
//
//  Created by mac on 2019/12/19.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMCreateGroupViewController.h"
#import "JMBFriendViewController.h"
#import "JMCFriendViewController.h"
#import "JMTitlesView.h"
#import "DimensMacros.h"
#import <ImSDK/ImSDK.h>
#import "THelper.h"
@interface JMCreateGroupViewController ()<JMBFriendViewControllerDelegate,JMCFriendViewControllerDelegate>
@property(nonatomic,strong)JMBFriendViewController *BFriendsVC;
@property(nonatomic,strong)JMCFriendViewController *CFriendsVC;
@property(nonatomic,strong)JMTitlesView *titleView;
@property(nonatomic,assign)NSInteger index;

@property(nonatomic,strong)NSMutableArray *groupArray;

@end

@implementation JMCreateGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    self.title = @"发起群聊";
    [self setRightBtnTextName:@"完成"];
    // Do any additional setup after loading the view from its nib.
}

-(void)rightAction{
    NSLog(@"%@",self.groupArray);
    NSMutableArray *userId_arr = [NSMutableArray array];
    NSMutableArray *name_arr = [NSMutableArray array];
    for (JMFriendListData *data in self.groupArray) {
        if ([data.type isEqualToString:B_Type_UESR]) {
            NSString *userId_IM = [NSString stringWithFormat:@"%@b",data.friend_user_id];
            [userId_arr addObject:userId_IM];
        }else if ([data.type isEqualToString:C_Type_USER]){
            NSString *userId_IM = [NSString stringWithFormat:@"%@a",data.friend_user_id];
            [userId_arr addObject:userId_IM];
        }
        [name_arr addObject:data.friend_nickname];
    }
    NSMutableArray *members = [NSMutableArray array];
    
    for (NSString *str_id  in userId_arr) {
        TIMCreateGroupMemberInfo *member = [[TIMCreateGroupMemberInfo alloc] init];
        member.member = str_id;
        member.role = TIM_GROUP_MEMBER_ROLE_MEMBER;
        [members addObject:member];
    }
    
    NSString  *string = [name_arr componentsJoinedByString:@"、"];
    NSString  *string2;
    if (string.length > 9) {
        NSString *str =  [string substringToIndex:9];
        string2 = [NSString stringWithFormat:@"%@...",str];
    }else{
        string2 = string;
    }
    
    TIMCreateGroupInfo *info = [[TIMCreateGroupInfo alloc] init];
    info.groupName = string2;
    info.groupType = @"Private";
    info.membersInfo = members;
    
    //发送创建请求后的回调函数
    [[TIMGroupManager sharedInstance] createGroup:info succ:^(NSString *groupId) {
        [self.navigationController popViewControllerAnimated:YES];
    } fail:^(int code, NSString *msg) {
        [THelper makeToastError:code msg:msg];
        
    }];
    
//    [[TIMGroupManager sharedInstance] inviteGroupMember:@"TGID1JYSZEAEQ" members:members succ:^(NSArray* arr) {
//        for (TIMGroupMemberResult * result in arr) {
//            NSLog(@"user %@ status %d", result.member, result.status);
//        }
//        [self.navigationController popViewControllerAnimated:YES];
//    } fail:^(int code, NSString* err) {
//        NSLog(@"failed code: %d %@", code, err);
//    }];
    
}

-(void)initView{
    [self.view addSubview:self.titleView];
    [self.view addSubview:self.BFriendsVC.view];
    [self.view addSubview:self.CFriendsVC.view];
    
    [self.BFriendsVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleView.mas_bottom);
        make.bottom.mas_equalTo(self.view);
        make.left.right.mas_equalTo(self.view);
    }];
    [self.CFriendsVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleView.mas_bottom);
        make.bottom.mas_equalTo(self.view);
        make.left.right.mas_equalTo(self.view);
    }];

}

-(void)setCurrentIndex{
       if (_index == 0) {
            [self.BFriendsVC.view setHidden:NO];
            [self.CFriendsVC.view setHidden:YES];

        }else if (_index == 1){
            [self.BFriendsVC.view setHidden:YES];
            [self.CFriendsVC.view setHidden:NO];
        }

}
#pragma mark - myDelegate
//企业用户
-(void)BFriendViewControllerDidCancelFriendWithModel:(JMFriendListData *)data{
    [self.groupArray removeObject:data];
}

-(void)BFriendViewControllerDidSelectedFriendWithModel:(JMFriendListData *)data{
    [self.groupArray addObject:data];
}

//个人用户
-(void)CFriendViewControllerDidCancelFriendWithModel:(JMFriendListData *)data{
    [self.groupArray removeObject:data];
}

-(void)CFriendViewControllerDidSelectedFriendWithModel:(JMFriendListData *)data{
    [self.groupArray addObject:data];

}

#pragma mark - lazy

- (JMTitlesView *)titleView {
    if (!_titleView) {
        _titleView = [[JMTitlesView alloc] initWithFrame:(CGRect){0, SafeAreaTopHeight, SCREEN_WIDTH, 43} titles:@[ @"企业用户",@"个人用户"]];
        __weak JMCreateGroupViewController *weakSelf = self;
        _titleView.didTitleClick = ^(NSInteger index) {
            _index = index;
            [weakSelf setCurrentIndex];
        };
    }
    
    return _titleView;
}

-(JMBFriendViewController *)BFriendsVC{
    if (!_BFriendsVC) {
        _BFriendsVC = [[JMBFriendViewController alloc]init];
        _BFriendsVC.view.frame = self.view.frame;
        _BFriendsVC.delegate = self;
        _BFriendsVC.viewType = JMBFriendViewControllerViewTypeGroup;
        [self addChildViewController:_BFriendsVC];
        
    }
    return _BFriendsVC;
}

-(JMCFriendViewController *)CFriendsVC{
    if (!_CFriendsVC) {
        _CFriendsVC = [[JMCFriendViewController alloc]init];
        [_CFriendsVC.view setHidden:YES];
        _CFriendsVC.view.frame = self.view.frame;
        _CFriendsVC.viewType = JMCFriendViewControllerViewTypeGroup;
        _CFriendsVC.delegate = self;

        [self addChildViewController:_CFriendsVC];
        
    }
    return _CFriendsVC;
}

-(NSMutableArray *)groupArray{
    if (_groupArray.count == 0) {
        _groupArray = [NSMutableArray array];
    }
    return _groupArray;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
