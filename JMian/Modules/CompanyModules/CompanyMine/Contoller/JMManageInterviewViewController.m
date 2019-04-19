//
//  JMManageInterviewViewController.m
//  JMian
//
//  Created by mac on 2019/4/19.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMManageInterviewViewController.h"
#import "JMMangerInterviewTableViewCell.h"

@interface JMManageInterviewViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIView *titleView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

static NSString *cellIdent = @"managerCellIdent";

@implementation JMManageInterviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 189;
    [self.tableView registerNib:[UINib nibWithNibName:@"JMMangerInterviewTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdent];

}


#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //    JMAllMessageTableViewCell *cell = [[JMAllMessageTableViewCell alloc]init];
    JMMangerInterviewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdent forIndexPath:indexPath];
//    [cell setData:[_data objectAtIndex:indexPath.row]];
    
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
