//
//  JMVersionDetailsView.h
//  JMian
//
//  Created by mac on 2019/10/11.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol JMVersionDetailsViewDelegate <NSObject>
-(void)updateAction;
-(void)deleteAction;
@end
@interface JMVersionDetailsView : UIView
@property (weak, nonatomic) IBOutlet UITextView *versionDetailTextView;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property(nonatomic,weak)id<JMVersionDetailsViewDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
