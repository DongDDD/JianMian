//
//  JMManageInterviewViewController.m
//  JMian
//
//  Created by mac on 2019/4/19.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMManageInterviewViewController.h"
#import "JMMangerInterviewTableViewCell.h"
#import "JMHTTPManager+InterView.h"
#import "JMInterVIewModel.h"
#import "JMChooseTimeViewController.h"

@interface JMManageInterviewViewController ()<UITableViewDelegate,UITableViewDataSource,JMMangerInterviewTableViewCellDelegate,JMChooseTimeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIView *titleView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic ,strong)NSArray *listsArray;
@property (nonatomic ,strong)JMChooseTimeViewController * chooseTimeVC;
@property (nonatomic ,strong)JMInterVIewModel *model;

@end

static NSString *cellIdent = @"managerCellIdent";

@implementation JMManageInterviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"面试管理";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 189;
    [self.tableView registerNib:[UINib nibWithNibName:@"JMMangerInterviewTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdent];
    [self getListData];
}


-(void)getListData{
    [[JMHTTPManager sharedInstance]fetchInterViewListWithStatus:@"" page:@"1" per_page:@"7" successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
        if (responsObject[@"data"]) {
            
            self.listsArray = [JMInterVIewModel mj_objectArrayWithKeyValuesArray:responsObject[@"data"]];
            [self.tableView reloadData];
        }
//
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
        
        
    }];



}
#pragma mark - 点击事件
//代理点击事件
-(void)cellLeftBtnActionWith_row:(NSInteger)row{
    self.chooseTimeVC = [[JMChooseTimeViewController alloc]init];
    self.chooseTimeVC.delegate = self;
    [self addChildViewController:self.chooseTimeVC];
    [self.view addSubview:self.chooseTimeVC.view];
    self.chooseTimeVC.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [self.chooseTimeVC didMoveToParentViewController:self];
    
    self.model = self.listsArray[row];
    
}

-(void)cellRightBtnAction_row:(NSInteger)row{
    
    self.model = self.listsArray[row];
    [[JMHTTPManager sharedInstance]updateInterViewWith_Id:self.model.interview_id status:Interview_Delete successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"取消面试成功"
                                                      delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
        [alert show];
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
}

//修改面试时间

-(void)OKInteviewTimeViewAction:(NSString *)interviewTime{
    [self.chooseTimeVC willMoveToParentViewController:nil];
    [self.chooseTimeVC removeFromParentViewController];
    [self.chooseTimeVC.view removeFromSuperview];
    self.navigationController.navigationBarHidden = NO;
    [[JMHTTPManager sharedInstance]createInterViewWith_user_job_id:self.model.user_job_id time:interviewTime successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"邀请成功"
                                                      delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
        [alert show];
        
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
    
}

-(void)deleteInteviewTimeViewAction{
    
    [self.chooseTimeVC willMoveToParentViewController:nil];
    [self.chooseTimeVC removeFromParentViewController];
    [self.chooseTimeVC.view removeFromSuperview];
    
    self.navigationController.navigationBarHidden = NO;
}




#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listsArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JMMangerInterviewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdent forIndexPath:indexPath];
    
    if(cell == nil)
    {
        cell = [[JMMangerInterviewTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdent];
    }
    
    JMInterVIewModel *model = self.listsArray[indexPath.row];
    cell.delegate = self;
    cell.myRow = indexPath.row;
    [cell setModel:model];
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    _model = self.listsArray[indexPath.row];

    
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
