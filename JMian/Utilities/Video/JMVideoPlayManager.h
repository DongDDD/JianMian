//
//  JMVideoPlayManager.h
//  JMian
//
//  Created by mac on 2019/5/14.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JMVideoPlayManager : NSObject

@property(nonatomic,strong)NSMutableArray *B_User_playArray;
@property(nonatomic,strong)NSMutableArray *C_User_playArray;
//
//-(void)setB_User_playArray:(NSMutableArray * _Nonnull)B_User_playArray;
//-(void)setC_User_playArray:(NSMutableArray * _Nonnull)C_User_playArray;


+ (instancetype)sharedInstance;
@end

NS_ASSUME_NONNULL_END
