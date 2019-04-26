//
//  JMPostJobHomeViewController.m
//  JMian
//
//  Created by mac on 2019/4/17.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMPostJobHomeViewController.h"
#import "JMTitlesView.h"
#import "JMPageView.h"
#import "JMPostNewJobViewController.h"
#import "JMHTTPManager+Work.h"
#import "JMHTTPManager+Login.h"
#import "JMIDCardIdentifyViewController.h"
#import "JMHomeWorkModel.h"
#import "JMPostJobHomeTableViewCell.h"


@interface JMPostJobHomeViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) JMTitlesView *titleView;

@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) NSArray *childVCs;
@property (nonatomic, strong) UITableViewController *currentVC;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSNumber *statusNum;
@property (nonatomic, strong) NSArray *dataArray;
@property (weak, nonatomic) IBOutlet UILabel *tipsLab;
@property (weak, nonatomic) IBOutlet UIButton *postOrIdentityBtn;

@end

static NSString *cellIdent = @"cellIdent";


@implementation JMPostJobHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.hidesBackButton = YES;
    [self setTitle:@"职位管理"];
    [self setRightBtnTextName:@"发布职位"];
    
    [self setupInit];
  
    [self getListData];
    
    [self getUserStatus];
    
    [self setTableViewUI];
    
  
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self getListData];

    

}

-(void)getUserStatus{

    [[JMHTTPManager sharedInstance] fetchUserInfoWithSuccessBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
        JMUserInfoModel *userInfo = [JMUserInfoModel mj_objectWithKeyValues:responsObject[@"data"]];
        [JMUserInfoManager saveUserInfo:userInfo];
        
        JMUserInfoModel *model = [JMUserInfoManager getUserInfo];
        model = [JMUserInfoManager getUserInfo];
        
        if ([model.card_status isEqualToString:@"3"]) {
            
            [self.postOrIdentityBtn setTitle:@"发布职位" forState:UIControlStateNormal];
            [self setRightBtnTextName:@"发布职位"];
            
        }else if ([model.card_status isEqualToString:@"1"]){
            
            [self.postOrIdentityBtn setTitle:@"去实名认证" forState:UIControlStateNormal];
            [self setRightBtnTextName:@""];
            self.tipsLab.text = @"营业执照认证中...\n发布岗位需实名认证";
            
        }
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
    
}


- (IBAction)gotoIdentify:(id)sender {
    JMUserInfoModel *model = [JMUserInfoManager getUserInfo];
    model = [JMUserInfoManager getUserInfo];
   
    if ([model.card_status isEqualToString:@"1"]) {
   
        JMIDCardIdentifyViewController *vc = [[JMIDCardIdentifyViewController alloc]init];
        
        [self.navigationController pushViewController:vc animated:YES];

        
     
    }else if ([model.card_status isEqualToString:@"3"]){
  
        self.hidesBottomBarWhenPushed=YES;
        
        JMPostNewJobViewController *vc = [[JMPostNewJobViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
        self.hidesBottomBarWhenPushed=NO;
        
    
    }
    
    
}


-(void)rightAction{
    self.hidesBottomBarWhenPushed=YES;
    
    JMPostNewJobViewController *vc = [[JMPostNewJobViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
    self.hidesBottomBarWhenPushed=NO;
    
  

}

- (void)setupInit {
    [self.view addSubview:self.titleView];

}
#pragma mark - 获取数据

-(void)getListData{
    [[JMHTTPManager sharedInstance]fetchWorkPaginateWith_city_ids:nil company_id:nil label_id:nil work_label_id:nil education:nil experience_min:nil experience_max:nil salary_min:nil salary_max:nil subway_names:nil status:_statusNum page:nil per_page:nil SuccessBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
        
        if (responsObject[@"data"]) {
            
            self.dataArray = [JMHomeWorkModel mj_objectArrayWithKeyValuesArray:responsObject[@"data"]];
            [self.tableView reloadData];
        }

    
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
        
        
        
    }];

}


- (JMTitlesView *)titleView {
    if (!_titleView) {
        _titleView = [[JMTitlesView alloc] initWithFrame:(CGRect){0, 0, SCREEN_WIDTH, 43} titles:@[@"已发布", @"已下线"]];
        __weak JMPostJobHomeViewController *weakSelf = self;

        _titleView.didTitleClick = ^(NSInteger index) {
            _index = index;
            if (index==0) {
                _statusNum = @1;//已发布职位
                [weakSelf getListData];
            }else{
                _statusNum = @0;//已下线职位
                [weakSelf getListData];
            }
        };
    }
    
    return _titleView;
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
  
    //重用单元格
    JMPostJobHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdent];
    //初始化单元格
    if(cell == nil)
    {
        cell = [[JMPostJobHomeTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdent];
        //自带有两种基础的tableView样式，UITableViewCellStyleValue1、2. 后面的文章会讲解自定义样式
    }
    
    JMHomeWorkModel *model = self.dataArray[indexPath.row];
    [cell setModel:model];

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //    JMNotificationViewController *vc = [[JMNotificationViewController alloc]init];
    //
    //    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)setTableViewUI{
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.titleView.frame.origin.y+self.titleView.frame.size.height, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 78.0f;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"JMPostJobHomeTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdent];
    [self.view addSubview:_tableView];
    
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
