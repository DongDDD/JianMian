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
 
//    _titleArray = @[@"切换身份",@"修改手机号",@"清除缓存",@"客服热线: 159-8910-9060",@"应用版本",@"关于平台",@"反馈意见",@"退出登录"];
    // Do any additional setup after loading the view from its nib.
//    [self setTableViewUI];
}

- (IBAction)userChange:(UITapGestureRecognizer *)sender {
    if (_windowView) {
        
        [_windowView setHidden:NO];
    }else{
        _windowView = [[JMUserChangeWindowView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _windowView.delegate = self;
        //    [JMUserChangeWindowView sharedUserChangeWindow];
        [self.view addSubview:_windowView];
    }

}

-(void)OKAction{
//    JMUserInfoModel *model = [JMUserInfoManager getUserInfo];

//    NSString *step;
//    if ([model.type isEqualToString:@"2"]) {
//        step = @"1";
//    }else if ([model.type isEqualToString:@"1"]){
//        step = @"";
//
//    }
    
    
    [[JMHTTPManager sharedInstance]updateUserInfoType:nil password:nil avatar:nil nickname:nil email:nil name:nil sex:nil ethnic:nil birthday:nil address:nil number:nil image_front:nil image_behind:nil user_step:nil enterprise_step:nil real_status:nil successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
        JMJudgeViewController *vc = [[JMJudgeViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];

//        //更改用户状态
//        if ([kFetchMyDefault(@"type") isEqualToString:@"company"]) {
//             kSaveMyDefault(@"type", @"person");
//        }else if ([kFetchMyDefault(@"type") isEqualToString:@"person"]){
//            kSaveMyDefault(@"type", @"company");
//        
//        }
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
    
}




-(void)deleteAction{
    [_windowView setHidden:YES];
}

//-(void)setTableViewUI{
//
//    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
//    _tableView.delegate = self;
//    _tableView.dataSource = self;
//    _tableView.rowHeight = 63.0f;
//    [self.view addSubview:_tableView];
//
//}
//
//#pragma mark - Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 4;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    if (section == 0){
//        return 1;
//    }else if (section == 1){
//        return 4;
//    }else if (section == 2){
//
//        return 2;
//    }else if (section == 3){
//      return 1;
//    }
//    return 0;
//
//}
//
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    static NSString *CellTableIndentifier = @"CellTableIdentifier";
//    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
//
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        cell.textLabel.text = _titleArray[indexPath.row];
//        cell.textLabel.font = [UIFont fontWithName:@"MicrosoftYaHei" size:14];
//        cell.textLabel.textColor = UIColorFromHEX(0x4d4d4d);
//
//
//    return cell;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//
//        return 10;
//
//}
//- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
//    view.tintColor = [UIColor redColor];
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
