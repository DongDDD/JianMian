//
//  JMPostGoodsImagesView.h
//  JMian
//
//  Created by mac on 2019/6/17.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol JMPostGoodsImagesViewDelegate <NSObject>

-(void)gotoUploadImageAction;

@end
@interface JMPostGoodsImagesView : UIView
@property (weak, nonatomic) IBOutlet UIButton *goodsImageBtn;
@property (nonatomic, weak)id<JMPostGoodsImagesViewDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
