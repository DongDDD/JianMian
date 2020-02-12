//
//  JMSelectTaskTypeView.h
//  JMian
//
//  Created by mac on 2020/2/12.
//  Copyright © 2020 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol JMSelectTaskTypeViewDelegate <NSObject>
-(void)didClickTaskTypeWithTag:(NSInteger)tag;
 
@end
@interface JMSelectTaskTypeView : UIView
@property(nonatomic,weak)id<JMSelectTaskTypeViewDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
