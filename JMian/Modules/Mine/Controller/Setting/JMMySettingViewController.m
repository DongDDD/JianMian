//
//  JMMySettingViewController.m
//  JMian
//
//  Created by mac on 2019/5/6.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMMySettingViewController.h"
#import "JMUserChangeWindowView.h"
#import "LoginViewController.h"
#import "JMHTTPManager+Login.h"
#import "NavigationViewController.h"
#import "JMJudgeViewController.h"
#import "JMVideoPlayManager.h"

@interface JMMySettingViewController ()<UITableViewDelegate,UITableViewDataSource,JMUserChangeWindowViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong)NSArray *titleArray;
@property(nonatomic,strong)JMUserChangeWindowView *myWindowView;

@end

@implementation JMMySettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = BG_COLOR;
    self.tableView.sectionIndexColor = BG_COLOR;
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    _titleArray = @[@"修改手机号",@"清除缓存",@"客服热线: 159-8910-9060",@"应用版本"];
    
    // Do any additional setup after loading the view from its nib.
}


#pragma mark - Table view data source
//section
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        
        return 10;
    }else if (section == 2){
        return 10;

    }else if (section == 3){
        return 10;
    }
    
    return 0;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        
        return 1;
    }else if (section == 1){
        return 4;
        
    }else if (section == 2){
        return 2;
        
    }else if (section == 3){
        return 1;
        
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:TTextMessageCell_ReuseId];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TTextMessageCell_ReuseId];
        //            cell.delegate = self;
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = _titleArray[indexPath.row];
    cell.textLabel.textColor = TITLE_COLOR;
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"切换身份";
        }
        

    }else if (indexPath.section == 1){
        
            cell.textLabel.text = _titleArray[indexPath.row];
        
        
    }else if (indexPath.section == 2){
        if (indexPath.row == 0) {
            cell.textLabel.text = @"关于平台";
        }else if (indexPath.row == 1){
            cell.textLabel.text = @"反馈意见";
        }
    }else if (indexPath.section == 3){
        cell.textLabel.text = @"退出登录";
   
    }
 
    return cell;
}





- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     if (indexPath.section == 0) {
     
         if (_myWindowView) {
             
             [_myWindowView setHidden:NO];
         }else{
             _myWindowView = [[JMUserChangeWindowView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
             _myWindowView.delegate = self;
             [self.view addSubview:_myWindowView];
         }
     
     }
    if (indexPath.section == 3) {
        
        [[JMHTTPManager sharedInstance] logoutWithSuccessBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
            
            kRemoveMyDefault(@"token");
            kRemoveMyDefault(@"usersig");
            //token为空执行
            
            [[TIMManager sharedInstance] logout:^() {
                NSLog(@"logout succ");
            } fail:^(int code, NSString * err) {
                NSLog(@"logout fail: code=%d err=%@", code, err);
            }];
            LoginViewController *login = [[LoginViewController alloc] init];
            NavigationViewController *naVC = [[NavigationViewController alloc] initWithRootViewController:login];
            [UIApplication sharedApplication].delegate.window.rootViewController = naVC;
        } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
            
            
        }];
    }
    
}

-(void)deleteAction{
    [_myWindowView setHidden:YES];
}

-(void)OKAction{
    
    [[JMHTTPManager sharedInstance]userChangeWithSuccessBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
        JMUserInfoModel *userInfo = [JMUserInfoModel mj_objectWithKeyValues:responsObject[@"data"]];
        [JMUserInfoManager saveUserInfo:userInfo];
        kSaveMyDefault(@"usersig", userInfo.usersig);
        NSLog(@"usersig-----:%@",userInfo.usersig);
        JMJudgeViewController *vc = [[JMJudgeViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
        [[TIMManager sharedInstance] logout:^() {
            NSLog(@"logout succ");
        } fail:^(int code, NSString * err) {
            NSLog(@"logout fail: code=%d err=%@", code, err);
        }];
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
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
