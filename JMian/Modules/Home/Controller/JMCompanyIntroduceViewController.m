//
//  JMCompanyIntroduceViewController.m
//  JMian
//
//  Created by mac on 2019/3/30.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMCompanyIntroduceViewController.h"
#import "JMCompanyIntroduceHeaderView.h"

@interface JMCompanyIntroduceViewController ()

@property(nonatomic,strong)JMCompanyIntroduceHeaderView *headerView;
@property(nonatomic,strong)UIScrollView *scrollView;


@end

@implementation JMCompanyIntroduceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"公司介绍";
    [self setHeaderView];
}


-(void)setScrollVew{
    self.scrollView = [[UIScrollView alloc]init];
    

}

-(void)setHeaderView{
    self.headerView = [[JMCompanyIntroduceHeaderView alloc]init];
    self.headerView.backgroundColor = MASTER_COLOR;
    [self.view addSubview:self.headerView];
    
    
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
