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
#import "JMVitaDetailModel.h"

@interface JMVitaOfPersonDetailViewController ()

@property(nonatomic,assign)CGFloat decriContentH;
@property(nonatomic,strong)JMWorkExperienceView *experienLastView;
@end

@implementation JMVitaOfPersonDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 

    [self setUI];
    
}

-(void)setUI{
//    UIScrollView *self.view = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//    [self.view addSubview:self.view];
    
    
    //工作经历
    UIView *experienBGView = [[UIView alloc]init];
    [self.view addSubview:experienBGView];
    
    if (self.experiencesArray.count > 0) {
        UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(20, 35, 100, 20)];
        titleLab.text = @"工作经历";
        titleLab.font = [UIFont systemFontOfSize:20.0f];
        [self.view addSubview:titleLab];
        
        UIView * lastView ;
        for (int i = 0 ; i < self.experiencesArray.count; i++) {
            
            JMWorkExperienceView *experienView = [[JMWorkExperienceView alloc]init];
            experienView.model = self.experiencesArray[i];
            [experienBGView addSubview:experienView];
            
            [experienView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(SCREEN_WIDTH);
                make.top.equalTo(lastView ? lastView.mas_bottom: titleLab.mas_bottom).offset(30);
                make.bottom.mas_equalTo(experienView.contentLabel.mas_bottom).offset(30);
            }];
            
            lastView = experienView;
    
        }
        [experienBGView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(lastView.mas_bottom);
        }];
    }

    JMSelfDescriptionView *descriptionView = [[JMSelfDescriptionView alloc]init];
    descriptionView.content = self.vitaDescription;
    [self.view addSubview:descriptionView];

    [descriptionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.top.mas_equalTo(experienBGView.mas_bottom);
        make.bottom.mas_equalTo(descriptionView.contentLabel.mas_bottom).offset(30);
    }];
//
//(0,descriptionView.frame.origin.y+descriptionView.frame.size.height,lastView.frame.origin.y+lastView.frame.size.height, SCREEN_WIDTH, 248)
    [self.view layoutIfNeeded];

    if (self.educationArray.count > 0) {
        UIView * lastView ;
        for (int i=0; i<self.educationArray.count; i++) {
            CGFloat Y = descriptionView.frame.origin.y+descriptionView.frame.size.height + lastView.frame.origin.y+lastView.frame.size.height;
            JMEducationView *educationView = [[JMEducationView alloc]initWithFrame:CGRectMake(0, Y,SCREEN_WIDTH, 248)];
            educationView.model = self.educationArray[i];
            [self.view addSubview:educationView];
//            [educationView mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.top.mas_equalTo(descriptionView.mas_bottom);
//                make.width.mas_equalTo(SCREEN_WIDTH);
//                make.height.mas_equalTo(248);
//            }];
            lastView = educationView;
            
        }
        !self.didLoadView ? : self.didLoadView(lastView.frame.origin.y+lastView.frame.size.height+300);
        
    }else{
        
        !self.didLoadView ? : self.didLoadView(descriptionView.frame.origin.y+descriptionView.frame.size.height+400);

    
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
