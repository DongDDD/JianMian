//
//  JMGreetView.h
//  JMian
//
//  Created by mac on 2019/5/4.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol JMGreetViewDelegate <NSObject>

-(void)addGreetAction;

@end

@interface JMGreetView : UIView <UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIButton *bottomBtn;
@property(nonatomic,weak)id<JMGreetViewDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
