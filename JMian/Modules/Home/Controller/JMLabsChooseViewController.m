//
//  JMLabsChooseViewController.m
//  JMian
//
//  Created by mac on 2019/5/11.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMLabsChooseViewController.h"
#import "JMLabsScreenView.h"
#import "Masonry.h"
#import "DimensMacros.h"

#define BottomBtnH 42

@interface JMLabsChooseViewController ()<JMLabsScreenViewDelegate>
@property(nonatomic,strong)NSArray *array1;
@property(nonatomic,strong)NSArray *array2;
@property(nonatomic,strong)NSArray *array3;
@property(nonatomic,strong)NSArray *array4;

//@property(nonatomic,strong)JMLabsScreenView *labsView;
//@property(nonatomic,strong)JMLabsScreenView *labsView;
//@property(nonatomic,strong)JMLabsScreenView *labsView;

//@property(nonatomic,strong)JMLabsScreenView *labsView;
@end

@implementation JMLabsChooseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor whiteColor];
    UIView *bgView = [[UIView alloc]initWithFrame:self.view.bounds];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = 0.3;
    [self.view addSubview:bgView];
    [self initBtnView];
    [self initLabsView];
    
    
}

-(void)initBtnView{

    UIButton *leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0,SCREEN_HEIGHT-300, self.view.frame.size.width/2, BottomBtnH)];
    [leftBtn addTarget:self action:@selector(leftAction:) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setTitle:@"重置" forState:UIControlStateNormal];
    [leftBtn setBackgroundColor:[UIColor whiteColor]];
    [leftBtn setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:leftBtn];
    
    UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(leftBtn.frame.size.width,SCREEN_HEIGHT-300, self.view.frame.size.width/2, BottomBtnH)];
    [rightBtn addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setTitle:@"确认" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn setBackgroundColor:MASTER_COLOR];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:rightBtn];

}


-(void)initLabsView
{
    NSArray *titleArray = @[@"最低学历",@"工作经验",@"薪资要求"];
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.view.frame.size.height-300)];
    scrollView.alwaysBounceVertical = YES; //垂直
    scrollView.backgroundColor = BG_COLOR;
    [self.view addSubview:scrollView];
    CGFloat Y = 0.0;
    JMLabsScreenView *labsView;
    for (int i=0; i<3; i++) {
        
        labsView = [[JMLabsScreenView alloc]init];
        labsView.delegate = self;
        __weak JMLabsScreenView *weakLabsView = labsView;
        //labs标签决定最终高度，高度通过闭包传出来
        labsView.didCreateLabs = ^(CGFloat lastLabsY) {
            weakLabsView.frame = CGRectMake(0, Y, SCREEN_WIDTH, lastLabsY+36);
            NSLog(@"Y=------%f",lastLabsY);
        };
        labsView = weakLabsView;
        [labsView createLabUI_title:titleArray[i] labsArray:[self getArray_index:i]];
        [scrollView addSubview:labsView];
        Y = labsView.frame.origin.y + labsView.frame.size.height;
    }
    
    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, Y+20);
    
}

-(void)didChooseLabsTitle_str:(NSString *)str index:(NSInteger)index{
    if (_delegate && [_delegate respondsToSelector:@selector(didChooseLabsTitle_str:index:)]) {
        [_delegate didChooseLabsTitle_str:str index:index];
    }
    
    NSLog(@"-------%@%ld",str,(long)(index-1));

}



-(void)leftAction:(UIButton *)btn
{
    if (_delegate && [_delegate respondsToSelector:@selector(resetAction)]) {
        [_delegate resetAction];
    }


}
-(void)rightAction:(UIButton *)btn
{
    if (_delegate && [_delegate respondsToSelector:@selector(OKAction)]) {
        [_delegate OKAction];
    }
    
}







-(NSArray *)getArray_index:(NSInteger )index
{
    NSArray *array;
    switch (index) {
        case 0:
            array = @[@"全部",@"初中",@"高中",@"中专",@"大专",@"本科",@"硕士",@"博士"];
            break;
        case 1:
            array = @[@"全部",@"应届生",@"1年",@"1～3年",@"3～5年",@"5～10年",@"10年以上"];
            break;
        case 2:
            array = @[@"全部",@"3k",@"3-5k",@"5-8k",@"8-12k",@"12-20k",@"20-50k",@"50k以上"];
            break;
        default:
            break;
    }
    
    return array;

}



//-(NSArray *)_array1{
//    if (_array1 == nil) {
//        _array1 = @[@"全部",@"初中",@"高中",@"中专",@"大专",@"本科",@"硕士",@"博士",];
//    }
//    return _array1;
//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
