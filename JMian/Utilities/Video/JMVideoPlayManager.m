//
//  JMVideoPlayManager.m
//  JMian
//
//  Created by mac on 2019/5/14.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMVideoPlayManager.h"

@implementation JMVideoPlayManager

+ (instancetype)sharedInstance {
    static JMVideoPlayManager *_manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[JMVideoPlayManager alloc] init];
        _manager.B_User_playArray = [NSMutableArray array];
        _manager.C_User_playArray = [NSMutableArray array];
    });
    return _manager;
}

//-(void)setB_User_playArray:(NSMutableArray *)B_User_playArray
//{
//    
//    self.B_User_playArray = [NSMutableArray array];
//}
//
//-(void)setC_User_playArray:(NSMutableArray *)C_User_playArray
//{
//    self.C_User_playArray = [NSMutableArray array];
//    
//    
//}
//
//-(NSMutableArray *)B_User_playArray
//{
//    if (self.B_User_playArray == nil) {
//        self.B_User_playArray = [NSMutableArray array];
//    }
//    return self.B_User_playArray;
//}
//
//

@end
