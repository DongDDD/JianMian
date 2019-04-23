//
//  JMWelfareViewController.m
//  JMian
//
//  Created by mac on 2019/4/19.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMWelfareViewController.h"
#import "UIView+Ext.h"
#import "NSString+Extension.h"

@interface JMWelfareViewController ()

@property(nonatomic,strong)UIView *footView;
@property(nonatomic,strong)NSMutableArray *selectedBtnArray;
@end

@implementation JMWelfareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.selectedBtnArray = [[NSMutableArray alloc]init];
    self.title = @"福利亮点";
    [self setRightBtnTextName:@"保存"];
    [self setheaderUI];
    [self createLabUI];
}


#pragma mark - UI布局

-(void)setheaderUI {
    UILabel *lab = [[UILabel alloc]init];
    lab.text = @"选择福利标签";
    lab.font = GlobalFont(20);
    [self.view addSubview:lab];
    
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(25);
        make.left.mas_equalTo(self.view).offset(21);
        make.height.mas_equalTo(19);
    }];
    
    UILabel*lab2 = [[UILabel alloc]init];
    lab2.text = @"可选3项";
    lab2.font = GlobalFont(15);
    lab2.textColor = TEXT_GRAY_COLOR;
    [self.view addSubview:lab2];
    
    [lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lab.mas_bottom).offset(16);
        make.left.mas_equalTo(lab);
        make.height.mas_equalTo(15);
    }];

    self.footView = [[UIView alloc]init];
    self.footView.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0];
    [self.view addSubview:self.footView];
    
    [self.footView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(22);
        make.right.mas_equalTo(self.view.mas_right).offset(-22);
        make.height.mas_equalTo(1);
        make.bottom.mas_equalTo(lab2.mas_bottom).offset(25);
    }];

}

- (void)createLabUI
{
    NSArray * tagArr = [NSArray arrayWithObjects:@"五险一金",@"双休",@"下午茶",@"年终奖金",@"全勤奖",@"地铁周边",@"发展前景好",@"弹性工作",@"餐补等",@"生日福利",@"上升空间大",@"包吃住",@"老板nice",@"节日晚会",@"旅游活动",@"涨薪快",@"大平台",@"妹纸多", nil];
    CGFloat tagBtnX = 16;
    CGFloat tagBtnY = 129;
    for (int i= 0; i<tagArr.count; i++) {
        
        CGSize tagTextSize = [tagArr[i] sizeWithFont:GlobalFont(14) maxSize:CGSizeMake(SCREEN_WIDTH-32, 31)];
        if (tagBtnX+tagTextSize.width+30 > SCREEN_WIDTH-32) {
            
            tagBtnX = 16;
            tagBtnY += 30+25;
        }
        
        UIButton * tagBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        tagBtn.tag = i;
        tagBtn.frame = CGRectMake(tagBtnX, tagBtnY, tagTextSize.width+50, 30);
        [tagBtn setTitle:tagArr[i] forState:UIControlStateNormal];
        [tagBtn setTitleColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0] forState:UIControlStateNormal];
//        [tagBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        tagBtn.titleLabel.font = GlobalFont(16);
        tagBtn.layer.cornerRadius = 15.3;
        tagBtn.layer.masksToBounds = YES;
        tagBtn.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1.0];
//        tagBtn.layer.borderWidth = 1;
//        tagBtn.layer.borderColor = [UIColor orangeColor].CGColor;
        [tagBtn addTarget:self action:@selector(tagBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:tagBtn];
        
        tagBtnX = CGRectGetMaxX(tagBtn.frame)+10;
    }
}
#pragma mark - 点击事件

-(void)rightAction{

    [self.delegate sendBtnLabData:self.selectedBtnArray];
    [self.navigationController popViewControllerAnimated:YES];


}



- (void)tagBtnClick:(UIButton *)btn
{
   
        btn.selected = !btn.selected;
        if (btn.selected)
        {
            if (self.selectedBtnArray.count<3) {
                [btn setBackgroundColor:MASTER_COLOR];
                [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

                [self.selectedBtnArray addObject:btn];
            }else{
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"只能添加3项"
                                                              delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
                [alert show];
            }
        }
        if (!btn.selected)
        {
            [btn setBackgroundColor:[UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1.0]];
            [btn setTitleColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0] forState:UIControlStateNormal];
            [self.selectedBtnArray removeObject:btn];

            
        }
    

    
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
