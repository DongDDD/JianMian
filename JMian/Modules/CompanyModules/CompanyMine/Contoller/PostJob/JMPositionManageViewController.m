//
//  JMPositionManageViewController.m
//  JMian
//
//  Created by mac on 2019/6/5.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMPositionManageViewController.h"
#import "JMTitlesView.h"
#import "JMPostJobHomeViewController.h"
#import "JMPartTimeJobResumeViewController.h"
#import "JMBUserPostPositionViewController.h"
#import "JMBUserPostPartTimeJobViewController.h"

@interface JMPositionManageViewController ()

@property(nonatomic, strong)JMTitlesView *titleView;
@property(nonatomic, strong)JMPostJobHomeViewController *jobHomeListVC;
@property(nonatomic, strong)JMPartTimeJobResumeViewController *partTimeJobHomeListVC;
@property(nonatomic, strong)UIView *BGView;
@property(nonatomic, assign)NSUInteger index;
@property(nonatomic, strong)UIAlertController *alertController;

@end

@implementation JMPositionManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"职位管理";
    [self setRightBtnTextName:@"发布全职"];
    [self initView];
    // Do any additional setup after loading the view from its nib.
}

-(void)initView{
    [self.view addSubview:self.titleView];
    [self.view addSubview:self.BGView];
    [self.BGView addSubview:self.partTimeJobHomeListVC.view];
    [self.BGView addSubview:self.jobHomeListVC.view];
    self.BGView.backgroundColor = MASTER_COLOR;
    self.partTimeJobHomeListVC.view.backgroundColor = TITLE_COLOR;


}

-(void)rightAction{
    if (_index == 0) {
    
        
    }else if(_index == 1){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle: UIAlertControllerStyleActionSheet];
        [alert addAction:[UIAlertAction actionWithTitle:@"发布网络销售类" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            JMBUserPostPositionViewController *vc = [[JMBUserPostPositionViewController alloc]init];
            vc.title = @"发布网络销售职位";
            [self.navigationController pushViewController:vc animated:YES];
 
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"发布兼职类" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            JMBUserPostPartTimeJobViewController *vc = [[JMBUserPostPartTimeJobViewController alloc]init];
            vc.title = @"发布兼职";
            [self.navigationController pushViewController:vc animated:YES];
            
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {

            
        }]];
        [self presentViewController:alert animated:YES completion:nil];
        
    }

}

-(void)setCurrentIndex{
//    __weak typeof(self) ws = self;
////    [UIView animateWithDuration:0.3 animations:^{
//    CGRect Frame = self.BGView.frame;
//        Frame.origin.x = -_index*SCREEN_WIDTH ;
//        self.BGView.frame = Frame;
//    }];
    if (_index == 0) {
        _partTimeJobHomeListVC.view.hidden = YES;
        _jobHomeListVC.view.hidden = NO;
        [self setRightBtnTextName:@"发布全职"];

    }else if(_index == 1){
        _partTimeJobHomeListVC.view.hidden = NO;
        _jobHomeListVC.view.hidden = YES;
        [self setRightBtnTextName:@"发布兼职"];

    }


}
#pragma mark - getter

- (JMTitlesView *)titleView {
    if (!_titleView) {
        _titleView = [[JMTitlesView alloc] initWithFrame:(CGRect){0, 0, SCREEN_WIDTH, 43} titles:@[@"全职职位", @"兼职职位"]];
        _titleView.viewType = JMTitlesViewPositionManage;
        [_titleView setCurrentTitleIndex:0];
        __weak JMPositionManageViewController *weakSelf = self;
        _titleView.didTitleClick = ^(NSInteger index) {
            _index = index;
            [weakSelf setCurrentIndex];
        };
    }
    
    return _titleView;
}
//全职职位
-(JMPostJobHomeViewController *)jobHomeListVC{
    if (!_jobHomeListVC) {
        _jobHomeListVC = [[JMPostJobHomeViewController alloc]init];
        _jobHomeListVC.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.view.frame.size.height-_titleView.frame.size.height);
        [self addChildViewController:_jobHomeListVC];
    }
    return _jobHomeListVC;
}
//兼职职位
-(JMPartTimeJobResumeViewController *)partTimeJobHomeListVC{
    if (!_partTimeJobHomeListVC) {
        _partTimeJobHomeListVC = [[JMPartTimeJobResumeViewController alloc]init];
        _partTimeJobHomeListVC.viewType = JMPartTimeJobTypeManage;
        _partTimeJobHomeListVC.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        [self addChildViewController:_partTimeJobHomeListVC];
    }
    return _partTimeJobHomeListVC;
}

-(UIView *)BGView{
    if (!_BGView) {
        _BGView = [[UIView alloc]initWithFrame:CGRectMake(0,_titleView.frame.size.height, SCREEN_WIDTH*2, self.view.frame.size.height)];
    }
    return _BGView;
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
