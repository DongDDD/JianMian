//
//  JMSelfDescriptionView.m
//  JMian
//
//  Created by mac on 2019/4/18.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMSelfDescriptionView.h"
#import "Masonry.h"
#import "DimensMacros.h"

@implementation JMSelfDescriptionView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
                UILabel *titleLabel = [[UILabel alloc]init];
                titleLabel.text = @"自我描述";
                titleLabel.font = [UIFont systemFontOfSize:19];
                [self addSubview:titleLabel];
        
                [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(self.mas_left).offset(20);
                    make.width.mas_equalTo(100);
                    make.height.mas_equalTo(19);
                    make.top.mas_equalTo(self.mas_top).offset(35);
                }];
        
                //内容

                self.contentLabel = [[UILabel alloc]init];
                self.contentLabel.font = [UIFont systemFontOfSize:14];
                self.contentLabel.textColor =  TITLE_COLOR;
                self.contentLabel.numberOfLines = 0;
//
                NSMutableParagraphStyle  *paragraphStyle2 = [[NSMutableParagraphStyle alloc] init];
                NSString  *testString2 = @"1.负责线上产品的界面设计视觉交互设计并为\n2.新功能新产品提供创意及设计方案等负责线上产品的界面设计视觉交互设计\n3.并为新功能新产品提供创意及设计方案等淮准确理解产品需求和交互原型输\n3.岀优质的界果图够通过视觉元素有效把控网站的整体设计风格";
                NSMutableAttributedString  *setString2 = [[NSMutableAttributedString alloc] initWithString:testString2];
                [setString2  addAttribute:NSParagraphStyleAttributeName value:paragraphStyle2 range:NSMakeRange(0, [testString2 length])];
                [self.contentLabel  setAttributedText:setString2];
                [paragraphStyle2  setLineSpacing:13.5];

//                contentLabel.frame = CGRectMake(titleLabel.frame.origin.x, titleLabel.frame.origin.y+titleLabel.frame.size.height, self.frame.size.width-20,0);
                [self addSubview:self.contentLabel];
//
                [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(titleLabel.mas_left);
                    make.right.mas_equalTo(self).offset(-38);
                    make.top.mas_equalTo(titleLabel.mas_bottom).offset(30);
                   
                }];
//
        UIView * xian1View = [[UIView alloc]init];
        xian1View.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0];
        [self addSubview:xian1View];
        
        [xian1View mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(22);
            make.right.mas_equalTo(self.mas_right).offset(-22);
            make.height.mas_equalTo(1);
            make.bottom.mas_equalTo(self.mas_bottom);
        }];

//        [self layoutIfNeeded];
//        CGFloat H = contentLabel.frame.origin.y+contentLabel.frame.size.height;
//        !self.didLoadContentLab ? : self.didLoadContentLab(H);

//        self.didLoadContentLab(contentLabel.frame.origin.y+contentLabel.frame.size.height);
        
        
            }
            return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
