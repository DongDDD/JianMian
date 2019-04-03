//
//  JMIntroduceContentView.m
//  JMian
//
//  Created by mac on 2019/4/1.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMIntroduceContentView.h"
#import "Masonry.h"
#import "DimensMacros.h"
#import "DimensMacros.h"

NSUInteger const maxLine = 6;

@interface JMIntroduceContentView ()

@property (assign, nonatomic) BOOL expand;
@property (strong, nonatomic) YYTextLayout *contentLayout;

@end
@implementation JMIntroduceContentView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
    
        UILabel *titleLab = [[UILabel alloc]init];
        titleLab.text = @"公司介绍";
        titleLab.font = [UIFont systemFontOfSize:17];
        titleLab.textColor = [UIColor colorWithRed:72/255.0 green:72/255.0 blue:72/255.0 alpha:1.0];
        [self addSubview:titleLab];
        
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(22);
            make.width.mas_equalTo(200);
            make.height.mas_equalTo(16);
            make.top.mas_equalTo(self.mas_top).offset(28);
        }];
        
        self.contenLab =[[YYLabel alloc]init];
        self.contenLab.numberOfLines = 0;
        self.contenLab.userInteractionEnabled = YES;
        
        NSString  *testString = @"1.负责线上产品的界面设计视觉交互设计并为\n2.新功能新产品提供创意及设计方案等负责线上产品的界面设计视觉交互6面设计面设计面设计面设计面设计面设计面设计设计\n3.并为新功能新产品提供创意及设计方案等淮准确理解产品需求和交互原型输岀优质的界果图够通过视觉元素有效把控网站的整66666666----66666666----66666666----66666666----66666666----66666666----66666666----66666666----66666666----66666666----";
        NSMutableAttributedString  *setString = [[NSMutableAttributedString alloc] initWithString:testString];
        setString.yy_font = [UIFont systemFontOfSize:15];
        setString.yy_lineSpacing = 14;
        setString.yy_alignment = NSTextAlignmentLeft;
        self.contenLab.attributedText = setString;

        YYTextHighlight *hi = [[YYTextHighlight alloc] init];
        hi.tapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
            YYTextContainer *container = [YYTextContainer containerWithSize:CGSizeMake(SCREEN_WIDTH - 51, MAXFLOAT)];
            container.maximumNumberOfRows = 0;
            self.contentLayout = [YYTextLayout layoutWithContainer:container text:setString.copy];
            if (self.contentLayout.rowCount > maxLine) {
                [self.contenLab mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.height.mas_equalTo(self.contentLayout.textBoundingSize.height);
                }];
            }
        };
        
        NSMutableAttributedString *more = [[NSMutableAttributedString alloc] initWithString:@"......展开"];
        [more yy_setTextHighlight:hi range:[more.string rangeOfString:@"展开"]];
        [more yy_setColor:UIColorFromHEX(0x666666) range:[more.string rangeOfString:@"......"]];
        [more yy_setColor:UIColorFromHEX(0x24BFFF) range:[more.string rangeOfString:@"展开"]];

        YYLabel *seeMore = [[YYLabel alloc] init];
        seeMore.attributedText = more;
        [seeMore sizeToFit];

        NSAttributedString *truncationToken = [NSAttributedString yy_attachmentStringWithContent:seeMore contentMode:UIViewContentModeCenter attachmentSize:seeMore.frame.size alignToFont:setString.yy_font alignment:YYTextVerticalAlignmentCenter];
        
        YYTextContainer *container = [YYTextContainer containerWithSize:CGSizeMake(SCREEN_WIDTH - 51, MAXFLOAT)];
        container.maximumNumberOfRows = maxLine;
        self.contentLayout = [YYTextLayout layoutWithContainer:container text:setString.copy];
//        self.contenLab.textLayout = self.contentLayout;
        self.contenLab.truncationToken = truncationToken;
        
        [self addSubview:self.contenLab];
        [self.contenLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(titleLab).offset(0);
            make.right.mas_equalTo(self).offset(-31);
            make.height.mas_equalTo(self.contentLayout.textBoundingSize.height);
            make.top.mas_equalTo(titleLab.mas_bottom).offset(21);
        }];



        
        self.spreadBtn = [[UIButton alloc]init];
        [self.spreadBtn setTitle:@"展开" forState:UIControlStateNormal];
        [self.spreadBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.spreadBtn setTitleColor:MASTER_COLOR forState:UIControlStateNormal];
        self.spreadBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.spreadBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        self.spreadBtn.titleLabel.font =[UIFont systemFontOfSize:14];
        self.spreadBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
        self.spreadBtn.backgroundColor = [UIColor whiteColor];
        

//        [self addSubview:self.spreadBtn];
//
//        [self.spreadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//
//            make.right.mas_equalTo(self.contenLab.mas_right);
//            make.width.mas_equalTo(50);
//
//            //            make.top.mas_equalTo(titleLab.mas_bottom).offset(21);
//            make.bottom.mas_equalTo(self.contenLab).mas_offset(0);
//
//        }];
//
        
        UIView * xian1View = [[UIView alloc]init];
        xian1View.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0];
        [self addSubview:xian1View];
        
        [xian1View mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(22);
            make.right.mas_equalTo(self.mas_right).offset(-22);
            make.height.mas_equalTo(1);
            make.top.mas_equalTo(self.mas_top);
        }];
        
        [self layoutIfNeeded];
        
//        UITapGestureRecognizer *spreadTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(spreadAction:)];
//
//
//        [self.contenLab addGestureRecognizer:spreadTap];
//
        
         
    
    }
    
    return self;
}



#pragma mark - 按钮点击事件，通过代理模式响应
-(void)btnClick:(UIButton *)btn {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickButton:)]) {
        [self.delegate didClickButton:self.contenLab.frame.size.height];
    }
}

//
//-(void)spreadAction:(id)tap{
//    
//    [self.contenLab mas_updateConstraints:^(MASConstraintMaker *make) {
//        
//        make.bottom.mas_equalTo(self.contenLab.mas_bottom).offset(30);
//        
//        
//    }];
//    
//    
//    
//    
//}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
