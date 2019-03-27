//
//  PositionDesiredViewController.m
//  WSDropMenuView
//
//  Created by TYRBL on 15/8/10.
//  Copyright (c) 2015年 Senro Wong. All rights reserved.
//

#import "PositionDesiredViewController.h"
#import "WSDropMenuView.h"
#import "SearchView.h"



@interface PositionDesiredViewController ()<WSDropMenuViewDataSource,WSDropMenuViewDelegate,UITextFieldDelegate>

@property (nonatomic,strong) NSArray *firstNSArrays;

@property(nonatomic,strong)SearchView *searchView;



@end

@implementation PositionDesiredViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.firstNSArrays = @[@"产品",@"设计",@"汽车",@"运营/客服",@"实习储备",@"旅游",@"教育培训",@"酒店/餐饮 /零售",@"市场会展",@"生产制造",@"行政人事",@"医疗健康",@"财务法务",@"IT科技",@"销售",@"采购贸易",@"文化传媒",@"物流仓储",@"房地产物业",@"房地产物业",@"金融",@"咨询管理 /翻译"];
    
  
    self.view.backgroundColor = [UIColor whiteColor];
    

    WSDropMenuView *dropMenu = [[WSDropMenuView alloc] initWithFrame:CGRectMake(0,111, self.view.frame.size.width, SCREEN_HEIGHT)];
    
    dropMenu.dataSource = self;
    dropMenu.delegate  =self;
    [self.view addSubview:dropMenu];
    
    
    [self setSearchView];
}
#pragma mark - WSDropMenuView DataSource -

-(void)setSearchView{
    self.searchView = [[SearchView alloc]initWithFrame:CGRectMake(20, NAVIGATION_BAR_HEIGHT+21, SCREEN_WIDTH-40, 33)];
    self.searchView.searchTextField.placeholder = @"                                            搜索";
    self.searchView.searchTextField.returnKeyType =UIReturnKeySearch;
    self.searchView.searchTextField.delegate = self;
    UIImageView *image=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"圆角矩形 5"]];
    
    self.searchView.searchTextField.leftView=image;
    self.searchView.searchTextField.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:self.searchView];
    //    UITextField * searhbar = [UITextField searchBarWithTextField];
    //     searhbar.placeholder = @"  请输入公司或职位名称";
    //
    //
    //    searhbar.frame = CGRectMake(20,64,SCREEN_WIDTH-40,33);
    //    [self.view addSubview:searhbar];
    //
    
    
    
    
}


#pragma mark - WSDropMenuView DataSource -
- (NSInteger)dropMenuView:(WSDropMenuView *)dropMenuView numberWithIndexPath:(WSIndexPath *)indexPath{
    
    //WSIndexPath 类里面有注释
    
    if (indexPath.column == 0 && indexPath.row == WSNoFound) {
        
        return self.firstNSArrays.count;   //  一级
    }
    if (indexPath.column == 0 && indexPath.row != WSNoFound && indexPath.item == WSNoFound) {
        
        return 5;                        //二级
    }
    
    if (indexPath.column == 0 && indexPath.row != WSNoFound && indexPath.item != WSNoFound && indexPath.rank == WSNoFound) {
        
        return 20;                   //三级
    }
    
   
    
    return 0;
}

- (NSString *)dropMenuView:(WSDropMenuView *)dropMenuView titleWithIndexPath:(WSIndexPath *)indexPath{
    
    //return [NSString stringWithFormat:@"%ld",indexPath.row];
    
    //左边 第一级
    if (indexPath.column == 0 && indexPath.row != WSNoFound && indexPath.item == WSNoFound) {
        
        return self.firstNSArrays[indexPath.row];  //一级
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
