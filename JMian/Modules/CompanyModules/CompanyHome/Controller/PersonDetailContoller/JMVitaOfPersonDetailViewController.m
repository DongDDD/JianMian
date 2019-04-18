//
//  JMVitaOfPersonDetailViewController.m
//  JMian
//
//  Created by mac on 2019/4/17.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMVitaOfPersonDetailViewController.h"
#import "JMWorkExperienceView.h"
#import "JMSelfDescriptionView.h"
#import "JMEducationView.h"
#import "DimensMacros.h"
#import "Masonry.h"

@interface JMVitaOfPersonDetailViewController ()

@property(nonatomic,assign)CGFloat decriContentH;

@end

@implementation JMVitaOfPersonDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    
    [self setUI];
    
    
}

-(void)setUI{
//    UIScrollView *self.view = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//    [self.view addSubview:self.view];
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(20, 35, 100, 20)];
    titleLab.text = @"工作经历";
    titleLab.font = [UIFont systemFontOfSize:20.0f];
    [self.view addSubview:titleLab];
    
    
    JMWorkExperienceView *experienView = [[JMWorkExperienceView alloc]init];
    [self.view addSubview:experienView];
    
    [experienView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.top.mas_equalTo(titleLab.mas_bottom).offset(30);
        make.bottom.mas_equalTo(experienView.contentLabel.mas_bottom).offset(30);
    }];
    
    
    JMWorkExperienceView *experienView2 = [[JMWorkExperienceView alloc]init];
    [self.view addSubview:experienView2];

    [experienView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.top.mas_equalTo(experienView.mas_bottom).offset(30);
        make.bottom.mas_equalTo(experienView2.contentLabel.mas_bottom).offset(30);
    }];
    
    

    JMSelfDescriptionView *descriptionView = [[JMSelfDescriptionView alloc]init];
    [self.view addSubview:descriptionView];
    
    [descriptionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.top.mas_equalTo(experienView2.mas_bottom);
        make.bottom.mas_equalTo(descriptionView.contentLabel.mas_bottom).offset(30);
    }];
    
    
    JMEducationView *educationView = [[JMEducationView alloc]init];
    [self.view addSubview:educationView];
    
    [educationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.left.mas_equalTo(self.view);
        make.top.mas_equalTo(descriptionView.mas_bottom);
        make.height.mas_equalTo(248);
    }];
    
//    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 1500);
    
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
