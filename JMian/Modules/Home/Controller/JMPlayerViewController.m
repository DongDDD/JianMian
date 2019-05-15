//
//  JMPlayerViewController.m
//  JMian
//
//  Created by mac on 2019/5/13.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMPlayerViewController.h"


@interface JMPlayerViewController ()<AVPlayerViewControllerDelegate>
@property (strong, nonatomic) AVPlayerViewController *playerVC;
@property (nonatomic, strong) MBProgressHUD *progressHUD;

@end

@implementation JMPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.topTitle;
    [self.view addSubview:self.progressHUD];
    [self initPlayerView];
    // Do any additional setup after loading the view.
}

-(void)initPlayerView{
    //创建AVPlayerViewController控制器
    AVPlayerViewController *playerVC = [[AVPlayerViewController alloc] init];
    playerVC.delegate = self;
    playerVC.player = self.player;
    playerVC.view.frame = self.view.frame;
    [self.view addSubview:playerVC.view];
    self.playerVC = playerVC;
    //调用控制器的属性player的开始播放方法
    [self.playerVC.player play];
    
    
}


-(void)playerViewControllerDidStartPictureInPicture:(AVPlayerViewController *)playerViewController{
    [self.progressHUD setHidden:YES];


}
-(void)fanhui
{
    [super fanhui];
    [self.playerVC.player pause];

}

#pragma mark - 菊花
-(MBProgressHUD *)progressHUD{
    if (!_progressHUD) {
        _progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
        _progressHUD.progress = 0.6;
        _progressHUD.dimBackground = YES; //设置有遮罩
        _progressHUD.label.text = @"视频上传中"; //设置进度框中的提示文字
        _progressHUD.detailsLabel.text = @"请耐心等待...";
        [_progressHUD showAnimated:YES]; //显示进度框
    }
    return _progressHUD;
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
