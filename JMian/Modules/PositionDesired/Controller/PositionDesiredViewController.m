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
#import "JMHTTPManager+PositionDesired.h"
#import "JMSystemLabelsModel.h"




@interface PositionDesiredViewController ()<WSDropMenuViewDataSource,WSDropMenuViewDelegate,UITextFieldDelegate>

@property (nonatomic, strong) NSArray *firstArr,*secArr,*thirdArr;

@property (nonatomic, strong) SearchView *searchView;

@property (nonatomic, copy) NSString *labStr;
@property (nonatomic, copy) NSString *labIDStr;

@end

@implementation PositionDesiredViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.navigationController setNavigationBarHidden:NO];

    [self setTitle:@"期望职位"];
    [self setRightBtnTextName:@"保存"];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setSearchView];
  
    [self getData];
    
}
#pragma mark - 获取期望职位数据 -
-(void)rightAction{
    if (_labIDStr && _labIDStr) {
        
        [self.delegate sendPositoinData:_labStr labIDStr:_labIDStr];
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请选择好职位再保存"
                                                      delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
        [alert show];
    }
    
}
#pragma mark - 获取期望职位数据 -

-(void)getData{
    [[JMHTTPManager sharedInstance] fetchPositionLabelsWithMyId:@"967" mode:@"tree" successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
        self.firstArr =  [JMSystemLabelsModel mj_objectArrayWithKeyValuesArray:responsObject[@"data"]];
        
        WSDropMenuView *dropMenu = [[WSDropMenuView alloc] initWithFrame:CGRectMake(0,self.searchView.frame.origin.y+self.searchView.frame.size.height+15, self.view.frame.size.width, SCREEN_HEIGHT)];
        dropMenu.dataSource = self;
        dropMenu.delegate = self;
        [self.view addSubview:dropMenu];
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
   
}


#pragma mark - WSDropMenuView DataSource -

-(void)setSearchView{
    
    self.searchView = [[SearchView alloc]initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH-40, 33)];
    self.searchView.searchTextField.placeholder = @"                                        搜索";
    self.searchView.searchTextField.returnKeyType =UIReturnKeySearch;
    self.searchView.searchTextField.delegate = self;
    UIImageView *image=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"圆角矩形 5"]];
    
    self.searchView.searchTextField.leftView=image;
    self.searchView.searchTextField.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:self.searchView];
  
}


#pragma mark - WSDropMenuView DataSource -
- (NSInteger)dropMenuView:(WSDropMenuView *)dropMenuView numberWithIndexPath:(WSIndexPath *)indexPath{
    
    NSLog(@"---%@---",indexPath);
    //WSIndexPath 类里面有注释
    
    if (indexPath.column == 0 && indexPath.row == WSNoFound) {
        
        return self.firstArr.count;   //  一级
    }
    if (indexPath.column == 0 && indexPath.row != WSNoFound && indexPath.item == WSNoFound) {
        
        JMSystemLabelsModel *firstModel = self.firstArr[indexPath.row];
        _secArr = firstModel.children;
        return firstModel.children.count;                        //二级
    }
    
    if (indexPath.column == 0 && indexPath.row != WSNoFound && indexPath.item != WSNoFound && indexPath.rank == WSNoFound) {
        
        JMSystemLabelsModel *firstModel = self.firstArr[indexPath.row];
        JMSystemLabelsModel *secondModel = [JMSystemLabelsModel mj_objectWithKeyValues:firstModel.children[indexPath.item]];
        _thirdArr = secondModel.children;
        return secondModel.children.count;                   //三级
    }
    
   
    
    return 0;
}

- (NSString *)dropMenuView:(WSDropMenuView *)dropMenuView titleWithIndexPath:(WSIndexPath *)indexPath{
    
    //return [NSString stringWithFormat:@"%ld",indexPath.row];
    
    //左边 第一级
    if (indexPath.column == 0 && indexPath.row != WSNoFound && indexPath.item == WSNoFound) {
        
        JMSystemLabelsModel *firstModel = self.firstArr[indexPath.row];
        return firstModel.name;  //一级
    }
    
    if (indexPath.column == 0 && indexPath.row != WSNoFound && indexPath.item != WSNoFound && indexPath.rank == WSNoFound) {
        
        JMSystemLabelsModel *firstModel = self.firstArr[indexPath.row];
        JMSystemLabelsModel *secondModel = [JMSystemLabelsModel mj_objectWithKeyValues:firstModel.children[indexPath.item]];
//        _labStr = secondModel.name;

        return secondModel.name;
    }
    
    if (indexPath.column == 0 && indexPath.row != WSNoFound && indexPath.item != WSNoFound && indexPath.rank != WSNoFound) {
        
        JMSystemLabelsModel *firstModel = self.firstArr[indexPath.row];
        JMSystemLabelsModel *secondModel = [JMSystemLabelsModel mj_objectWithKeyValues:firstModel.children[indexPath.item]];
        JMSystemLabelsModel *thirdModel = [JMSystemLabelsModel mj_objectWithKeyValues:secondModel.children[indexPath.rank]];

        return thirdModel.name;
    }
    
    if (indexPath.column == 1 && indexPath.row != WSNoFound ) {
        
        return [NSString stringWithFormat:@"右边%ld",indexPath.row];
    }
    
    return @"";
    
}

#pragma mark - WSDropMenuView Delegate -

- (void)dropMenuView:(WSDropMenuView *)dropMenuView didSelectWithIndexPath:(WSIndexPath *)indexPath{
    
    _labStr = nil;
    _labIDStr = nil;

    if (indexPath.column == 0 && indexPath.row != WSNoFound && indexPath.item == WSNoFound) {
        //判断是否有第二级
        if (_firstArr.count && _secArr == nil) {
            JMSystemLabelsModel *firstModel = [JMSystemLabelsModel mj_objectWithKeyValues:_firstArr[indexPath.row]];
            _labStr = firstModel.name;
            _labIDStr = firstModel.label_id;
            NSLog(@"%@",firstModel.name);
            
        }
        
    }
    
    if (indexPath.column == 0 && indexPath.row != WSNoFound && indexPath.item != WSNoFound && indexPath.rank == WSNoFound) {
        //判断是否有第三级
        if (_secArr.count && _thirdArr == nil) {
            JMSystemLabelsModel *secondModel = [JMSystemLabelsModel mj_objectWithKeyValues:_secArr[indexPath.item]];
            _labStr = secondModel.name;
            _labIDStr = secondModel.label_id;
            NSLog(@"%@",secondModel.name);
            
        }
    }
    
    if (indexPath.column == 0 && indexPath.row != WSNoFound && indexPath.item != WSNoFound && indexPath.rank != WSNoFound) {
        //选择第三级直接输出
        if (_thirdArr.count) {
            JMSystemLabelsModel *thirdModel = [JMSystemLabelsModel mj_objectWithKeyValues:_thirdArr[indexPath.rank]];
            _labStr = thirdModel.name;
            _labIDStr = thirdModel.label_id;
            NSLog(@"%@",thirdModel.name);
            
        }

    }

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
}

@end
