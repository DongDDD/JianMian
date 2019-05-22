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


@interface JMCompanyLikeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

static NSString *cellIdent = @"CellIdent";

@implementation JMCompanyLikeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setRightBtnTextName:@"清空"];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 212;
    [self.tableView registerNib:[UINib nibWithNibName:@"JMCompanyLikeTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdent];
    
    [self getListData];
    // Do any additional setup after loading the view from its nib.
}


-(void)getListData{

    [[JMHTTPManager sharedInstance]fetchListWith_type:nil page:nil per_page:nil SuccessBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];

}

#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

//
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    JMCompanyLikeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdent forIndexPath:indexPath];

    if(cell == nil)
    {
        cell = [[JMCompanyLikeTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdent];
    }

//    JMInterVIewModel *model = self.listsArray[indexPath.row];
//    cell.delegate = self;
//    cell.myRow = indexPath.row;
//    [cell setModel:model];

    return cell;
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
