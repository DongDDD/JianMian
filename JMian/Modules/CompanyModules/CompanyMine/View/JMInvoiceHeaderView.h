//
//  JMInvoiceHeaderView.h
//  JMian
//
//  Created by mac on 2019/7/18.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol JMInvoiceHeaderViewDelegate <NSObject>

-(void)didClickBillActionWithTag:(NSInteger)tag;
@end

@interface JMInvoiceHeaderView : UIView

@property (weak, nonatomic) IBOutlet UIButton *YESBtn;
@property (weak, nonatomic) IBOutlet UIButton *NOBtn;

@property(nonatomic,weak)id<JMInvoiceHeaderViewDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
