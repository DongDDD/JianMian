//
//  JMCompanyLikeViewController.m
//  JMian
//
//  Created by mac on 2019/4/28.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMCompanyLikeViewController.h"
#import "JMCompanyLikeTableViewCell.h"
#import "JMHTTPManager+CompanyLike.h"
#import "JMHTTPManager+CreateConversation.h"
#import "JMUserInfoModel.h"
#import "JMUserInfoManager.h"
#import "JMBTypeLikeModel.h"
#import "JMCTypeLikeModel.h"
#import "JMTitlesView.h"
#import "JMBPartTimeJobLikeModel.h"
#import "JMCPartTimeJobLikeModel.h"
#import "JMMessageListModel.h"
#import "JMChatViewController.h"


@interface JMCompanyLikeViewController ()<UITableViewDelegate,UITableViewDataSource,JMCompanyLikeTableViewCellDelegate>
@property (nonatomic, strong) JMTitlesView *titleView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic ,strong)NSArray *listsArray;
@property (nonatomic ,copy)NSString *mode;
@property (nonatomic ,assign)NSInteger index;

@end

static NSString *cellIdent = @"CellIdent";

@implementation JMCompanyLikeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self setRightBtnTextName:@"清空"];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 212;
    [self.tableView registerNib:[UINib nibWithNibName:@"JMCompanyLikeTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdent];
//    JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
    [self.view addSubview:self.titleView];
    self.mode = @"1";
    [self getListData];
    [self.view addSubview:self.noDataView];
    [self.noDataView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.titleView.mas_bottom);
    }];
    
    // Do any additional setup after loading the view from its nib.
}


-(void)getListData{

    [[JMHTTPManager sharedInstance]fetchListWith_type:nil page:nil per_page:nil mode:self.mode SuccessBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        if (responsObject[@"data"]) {
            JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
             if ([userModel.type isEqualToString:B_Type_UESR]) {
                 if ([self.mode isEqualToString: @"1"]) {
                     //全职
                     self.listsArray = [JMBTypeLikeModel mj_objectArrayWithKeyValuesArray:responsObject[@"data"]];
                 }else if ([self.mode isEqualToString: @"2"]){
                     //兼职
                     self.listsArray = [JMBPartTimeJobLikeModel mj_objectArrayWithKeyValuesArray:responsObject[@"data"]];
                 }
             }else{
                 if ([self.mode isEqualToString: @"1"]) {
                     //全职
                     self.listsArray = [JMCTypeLikeModel mj_objectArrayWithKeyValuesArray:responsObject[@"data"]];
                 }else if([self.mode isEqualToString: @"2"]){
                     //兼职
                     self.listsArray = [JMCPartTimeJobLikeModel mj_objectArrayWithKeyValuesArray:responsObject[@"data"]];
                 }
             
             }
            if (self.listsArray.count == 0) {
                [self.noDataView setHidden:NO];
            }else{
                [self.noDataView setHidden:YES];

            }
            
            
            
        }
        [self.tableView reloadData];
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];

}

//创建聊天
-(void)createChatRequstWithForeign_key:(NSString *)foreign_key user_id:(NSString *)user_id{
    
    [[JMHTTPManager sharedInstance]createChat_type:self.mode recipient:user_id foreign_key:foreign_key successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        JMMessageListModel *messageListModel = [JMMessageListModel mj_objectWithKeyValues:responsObject[@"data"]];
 
        JMChatViewController *vc = [[JMChatViewController alloc]init];
//        
        vc.myConvModel = messageListModel;
        [self.navigationController pushViewController:vc animated:YES];
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
}

#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JMCompanyLikeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdent forIndexPath:indexPath];
    
    if(cell == nil)
    {
        cell = [[JMCompanyLikeTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdent];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
    if ([userModel.type isEqualToString:B_Type_UESR]) {
        if ([self.mode isEqualToString:@"1"]) {
            JMBTypeLikeModel *model = self.listsArray[indexPath.row];
            
            [cell setBTypeLikeModel:model];
            
        }else if ([self.mode isEqualToString:@"2"]){
            JMBPartTimeJobLikeModel *model = self.listsArray[indexPath.row];
            
            [cell setBPartTimeJobLikeModel:model];
            
        
        }
    }else{
        if ([self.mode isEqualToString:@"1"]) {
 
            [cell setCTypeLikeModel:self.listsArray[indexPath.row]];
            
        }else if ([self.mode isEqualToString:@"2"]){
 
            [cell setCPartTimeJobLikeModel:self.listsArray[indexPath.row]];

        }
        
        
    }
    return cell;
    
}


-(void)deleteActionWithFavorite_id:(NSString *)favorite_id{
    [[JMHTTPManager sharedInstance]deleteLikeWith_Id:favorite_id  mode:self.mode SuccessBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        [self getListData];
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
}


-(void)chatActionWithRecipient:(NSString *_Nullable)recipient foreign_key:(NSString *_Nonnull)foreign_key{
    [self createChatRequstWithForeign_key:foreign_key user_id:recipient];
    
}

-(void)movePageContentView{
    switch (_index) {
        case 0:
            self.mode = @"1";
            break;
        case 1:
            self.mode = @"2";
            break;
        default:
            break;
    }
    [self getListData];

}

#pragma mark - Getter

- (JMTitlesView *)titleView {
    if (!_titleView) {
        JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
        NSString *str1;NSString *str2;
        if ([userModel.type isEqualToString:B_Type_UESR]) {
            str1 = @"全职人才";
            str2 = @"兼职人才";
        }else{
            str1 = @"全职职位";
            str2 = @"兼职职位";
        }
        
        _titleView = [[JMTitlesView alloc] initWithFrame:(CGRect){0, 0, SCREEN_WIDTH, 43} titles:@[str1,str2]];
        __weak JMCompanyLikeViewController *weakSelf = self;
        _titleView.didTitleClick = ^(NSInteger index) {
            _index = index;
            [weakSelf movePageContentView];
        };
    }
    
    return _titleView;
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
