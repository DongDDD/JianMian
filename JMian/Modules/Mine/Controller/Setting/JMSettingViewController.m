//
//  JMSettingViewController.m
//  JMian
//
//  Created by mac on 2019/4/25.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMSettingViewController.h"
#import "Masonry.h"
#import "JMUserChangeWindowView.h"
#import "JMHTTPManager+Login.h"
#import "JMJudgeViewController.h"
#import "JMHTTPManager+UpdateInfo.h"
#import "JMUserInfoModel.h"
@interface JMSettingViewController ()<JMUserChangeWindowViewDelegate>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray *titleArray;
@property(nonatomic,strong)JMUserChangeWindowView *windowView;


@end

@implementation JMSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    self.view.backgroundColor =  [UIColor colorWithRed:245/255.0 green:245/255.0 blue:246/255.0 alpha:1.0];
 

}

- (IBAction)userChange:(UITapGestureRecognizer *)sender {
    if (_windowView) {
        
        [_windowView setHidden:NO];
    }else{
        _windowView = [[JMUserChangeWindowView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _windowView.delegate = self;
        [self.view addSubview:_windowView];
    }

}

-(void)OKAction{

        [[JMHTTPManager sharedInstance]userChangeWithSuccessBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
            
            JMUserInfoModel *userInfo = [JMUserInfoModel mj_objectWithKeyValues:responsObject[@"data"]];
            [JMUserInfoManager saveUserInfo:userInfo];
            JMJudgeViewController *vc = [[JMJudgeViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            
        } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
            
        }];

    
}

-(void)deleteAction{
    [_windowView setHidden:YES];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
