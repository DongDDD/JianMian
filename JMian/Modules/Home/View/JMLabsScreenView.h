//
//  JMLabsScreenView.h
//  JMian
//
//  Created by mac on 2019/5/11.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JMLabsScreenView : UIView

@property (nonatomic, strong) void(^didCreateLabs)(CGFloat);

- (void)createLabUI_title:(NSString *)title labsArray:(NSArray *)labsArray;
@property(nonatomic,strong)NSMutableArray *selectedBtnArray;
@property(nonatomic,strong)UIButton * tagBtn;
@property(nonatomic,assign)NSInteger selectIndex;

@end

NS_ASSUME_NONNULL_END
