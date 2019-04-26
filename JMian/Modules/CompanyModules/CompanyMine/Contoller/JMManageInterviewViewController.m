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

@interface JMManageInterviewViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIView *titleView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic ,strong)NSArray *listsArray;


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
    [cell setModel:model];
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
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
