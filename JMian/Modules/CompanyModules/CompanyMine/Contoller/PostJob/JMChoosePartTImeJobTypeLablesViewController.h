//
//  JMChoosePartTImeJobTypeLablesViewController.h
//  JMian
//
//  Created by mac on 2019/7/1.
//  Copyright © 2019 mac. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
typedef enum : NSUInteger {
    JMChoosePartTImeJobTypeLablesViewTypePartTimeJob,
    JMChoosePartTImeJobTypeLablesViewTypeHome,
} JMChoosePartTImeJobTypeLablesViewType;
@protocol JMChoosePartTImeJobTypeLablesViewControllerDelegate <NSObject>

-(void)didChooseWithType_id:(NSString *)type_id typeName:(NSString *)typeName;

@end
@interface JMChoosePartTImeJobTypeLablesViewController : BaseViewController
@property(nonatomic,weak)id<JMChoosePartTImeJobTypeLablesViewControllerDelegate>delegate;
@property(nonatomic,assign)JMChoosePartTImeJobTypeLablesViewType viewType;
@property(nonatomic,strong)UIViewController *myVC;
@end

NS_ASSUME_NONNULL_END
