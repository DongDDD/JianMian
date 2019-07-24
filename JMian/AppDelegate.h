//
//  AppDelegate.h
//  JMian
//
//  Created by mac on 2019/3/22.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DimensMacros.h"
#import "JMAnswerOrHangUpView.h"
#import "JMVideoChatView.h"
#import "JMFeedBackChooseViewController.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate,AVAudioPlayerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSMutableArray *playArray;
@property (nonatomic, strong) MBProgressHUD *progressHUD;
@property(nonatomic,strong)NSDictionary *videoChatDic;
@property (strong, nonatomic)JMAnswerOrHangUpView *answerOrHangUpView;
@property (strong, nonatomic)JMVideoChatView *videoChatView;
@property (nonatomic, assign)BOOL isBackgroundTask;
//@property (strong, nonatomic) NSData *deviceToken;
@property(nonatomic,strong)JMFeedBackChooseViewController *feedBackChooseVC;


@end

