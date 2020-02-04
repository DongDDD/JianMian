//
//  JMGoodsDescTableViewCell.h
//  JMian
//
//  Created by mac on 2020/2/1.
//  Copyright © 2020 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
extern NSString *const JMGoodsDescTableViewCellIdentifier;
@protocol JMGoodsDescTableViewCellDelegate <NSObject>

-(void)getGoodsH:(CGFloat)H;

@end
@interface JMGoodsDescTableViewCell : UITableViewCell<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UILabel *lab;
@property(nonatomic,copy)NSString *descStr;
@property(nonatomic,weak)id<JMGoodsDescTableViewCellDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
