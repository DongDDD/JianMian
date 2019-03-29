//
//  JobDetailsViewController.m
//  JMian
//
//  Created by mac on 2019/3/28.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JobDetailsViewController.h"

#import "Masonry.h"

@interface JobDetailsViewController ()

@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)UIView *footOfVideoView;

@property(nonatomic,strong)UIImageView *videoImageView;



@end

@implementation JobDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    [self setScrollView];
    [self setFootOfVideoView];
    [self setVideoImgView];
    
    
}

#pragma mark - UI布局

-(void)setScrollView{
    self.scrollView = [[UIScrollView alloc]init];
    self.scrollView.backgroundColor = [UIColor grayColor];
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height+200);
    [self.view addSubview:self.scrollView];
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(64);
        make.left.and.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom);
        
        
    }];

}

#pragma mark - 简介信息
-(void)setFootOfVideoView{
    
    self.footOfVideoView = [[UIView alloc]init];
    self.footOfVideoView.backgroundColor = [UIColor redColor];
    
    
    [self.scrollView addSubview:self.footOfVideoView];
   
    [self.footOfVideoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom);
        make.height.mas_equalTo(136);
       
    }];
 
}

-(void)setVideoImgView{
    self.videoImageView = [[UIImageView alloc]init];
    self.videoImageView.backgroundColor = [UIColor blueColor];
    [self.scrollView addSubview:self.videoImageView];
    [self.videoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.scrollView.mas_top);
        make.left.and.right.equalTo(self.view);
        make.bottom.equalTo(self.footOfVideoView.mas_top);
    }];

   
    UIButton *playBtn = [[UIButton alloc]init];
    [playBtn setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
    [playBtn addTarget:self action:@selector(playAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:playBtn];
    [playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.videoImageView.mas_centerX);
        make.top.mas_equalTo(self.scrollView.mas_top).offset(295);
        make.height.and.with.mas_equalTo(141);
    }];
    
    
    
    
    


}

-(void)playAction{
   
    
  
    [UIView animateWithDuration:0.2 animations:^{
    [self.videoImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self.view.mas_bottom);
        
    }];

        [self.view layoutIfNeeded];//强制绘制
    } completion:^(BOOL finished) {
        NSLog(@"播放视频");

    }];
    




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
