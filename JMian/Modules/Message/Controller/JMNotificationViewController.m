//
//  JMNotificationViewController.m
//  JMian
//
//  Created by mac on 2019/4/12.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMNotificationViewController.h"
#import "JMNotificationHeaderTableViewCell.h"
#import "JMNotificationTableViewCell.h"

@interface JMNotificationViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@end
static NSString *sectionCellViewIdent = @"sectionCellViewIdent";
static NSString *cellIdent = @"notificationCellIdent";


@implementation JMNotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"通知"];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 36;
    self.tableView.separatorStyle = UITableViewCellAccessoryNone;
    self.tableView.sectionHeaderHeight = 67.0f;
    self.tableView.sectionFooterHeight = 10.0f;
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}


//自定义section的头部
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    JMNotificationHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:sectionCellViewIdent];
    if (cell == nil) {
         cell = [[JMNotificationHeaderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:sectionCellViewIdent];
       }

return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
    {
        UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0)];
        view.backgroundColor = BG_COLOR;
        return view;
    }

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JMNotificationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdent];
        if (cell == nil) {
             cell = [[JMNotificationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdent];
           }
    
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
