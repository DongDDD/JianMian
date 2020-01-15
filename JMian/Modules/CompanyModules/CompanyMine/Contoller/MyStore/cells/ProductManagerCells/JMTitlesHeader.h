//
//  JMTitlesHeader.h
//  JMian
//
//  Created by mac on 2020/1/11.
//  Copyright © 2020 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, JMCategoriesType){
    JMCategoriesTypeFirst = 0 ,
    JMCategoriesTypeSecond,
};
@interface JMTitlesHeader : UIView
@property(nonatomic,strong)UIButton *btn1;
@property(nonatomic,strong)UIButton *btn2;

@property(nonatomic,strong)UIView *footerView;
@property(nonatomic,assign)JMCategoriesType viewType;
-(void)btn1Selected;
-(void)btn2Selected;

@end

NS_ASSUME_NONNULL_END
