//
//  PositionDesiredViewController.m
//  WSDropMenuView
//
//  Created by TYRBL on 15/8/10.
//  Copyright (c) 2015年 Senro Wong. All rights reserved.
//

#import "PositionDesiredViewController.h"
#import "WSDropMenuView.h"

@interface PositionDesiredViewController ()<WSDropMenuViewDataSource,WSDropMenuViewDelegate>

@end

@implementation PositionDesiredViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.title = @"123";
    
    self.view.backgroundColor = [UIColor whiteColor];
    

    WSDropMenuView *dropMenu = [[WSDropMenuView alloc] initWithFrame:CGRectMake(0,111, self.view.frame.size.width, SCREEN_HEIGHT)];
    
    dropMenu.dataSource = self;
    dropMenu.delegate  =self;
    [self.view addSubview:dropMenu];
}


#pragma mark - WSDropMenuView DataSource -
- (NSInteger)dropMenuView:(WSDropMenuView *)dropMenuView numberWithIndexPath:(WSIndexPath *)indexPath{
    
    //WSIndexPath 类里面有注释
    
    if (indexPath.column == 0 && indexPath.row == WSNoFound) {
        
        return 20;
    }
    if (indexPath.column == 0 && indexPath.row != WSNoFound && indexPath.item == WSNoFound) {
        
        return 5;
    }
    
    if (indexPath.column == 0 && indexPath.row != WSNoFound && indexPath.item != WSNoFound && indexPath.rank == WSNoFound) {
        
        return 20;
    }
    
    if (indexPath.column == 1) {
        
        return 3;
    }
    
    return 0;
}

- (NSString *)dropMenuView:(WSDropMenuView *)dropMenuView titleWithIndexPath:(WSIndexPath *)indexPath{
    
    //return [NSString stringWithFormat:@"%ld",indexPath.row];
    
    //左边 第一级
    if (indexPath.column == 0 && indexPath.row != WSNoFound && indexPath.item == WSNoFound) {
        
        return [NSString stringWithFormat:@"one one %ld",indexPath.row];
    }
    
    if (indexPath.column == 0 && indexPath.row != WSNoFound && indexPath.item != WSNoFound && indexPath.rank == WSNoFound) {
        
        return [NSString stringWithFormat:@"第二级%ld",indexPath.item];
    }
    
    if (indexPath.column == 0 && indexPath.row != WSNoFound && indexPath.item != WSNoFound && indexPath.rank != WSNoFound) {
        
        return [NSString stringWithFormat:@"第三级%ld",indexPath.rank];
    }
    
    if (indexPath.column == 1 && indexPath.row != WSNoFound ) {
        
        return [NSString stringWithFormat:@"右边%ld",indexPath.row];
    }
    
    return @"";
    
}

#pragma mark - WSDropMenuView Delegate -

- (void)dropMenuView:(WSDropMenuView *)dropMenuView didSelectWithIndexPath:(WSIndexPath *)indexPath{
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
}

@end
