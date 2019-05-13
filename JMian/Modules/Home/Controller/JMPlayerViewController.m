//
//  JMPlayerViewController.m
//  JMian
//
//  Created by mac on 2019/5/13.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMPlayerViewController.h"


@interface JMPlayerViewController ()
@property (strong, nonatomic) AVPlayerViewController *playerVC;

@end

@implementation JMPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.model.userNickname;
    [self initPlayerView];
    // Do any additional setup after loading the view.
}

-(void)initPlayerView{
    //创建AVPlayerViewController控制器
    AVPlayerViewController *playerVC = [[AVPlayerViewController alloc] init];
    playerVC.player = self.player;
    playerVC.view.frame = self.view.frame;
    [self.view addSubview:playerVC.view];
    self.playerVC = playerVC;
    //调用控制器的属性player的开始播放方法
    [self.playerVC.player play];
    
    
}


-(void)fanhui
{
    [super fanhui];
    [self.playerVC.player pause];

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
