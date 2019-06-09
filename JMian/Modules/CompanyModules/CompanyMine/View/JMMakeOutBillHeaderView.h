//
//  JMMakeOutBillHeaderView.h
//  JMian
//
//  Created by mac on 2019/6/9.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol JMMakeOutBillHeaderViewDelegate <NSObject>

-(void)didClickBillActionWithTag:(NSInteger)tag;

@end
@interface JMMakeOutBillHeaderView : UIView
@property(nonatomic,weak)id<JMMakeOutBillHeaderViewDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
