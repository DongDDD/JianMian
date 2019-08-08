//
//  JMMessageCell.m
//  JMian
//
//  Created by mac on 2019/4/30.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMMessageCell.h"
#import "DimensMacros.h"
#import "NSString+Extension.h"


@implementation JMMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupViews];
    }
    return self;
}


- (void)setupViews{
    self.backgroundColor = [UIColor clearColor];
    //head
    _head = [[UIImageView alloc] init];
    _head.backgroundColor = [UIColor grayColor];
    _head.contentMode = UIViewContentModeScaleAspectFit;
   
    [self addSubview:_head];

    //container
//    _container = [[UIView alloc] init];
//    _container.backgroundColor = [UIColor clearColor];
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)];
//    [_container addGestureRecognizer:tap];
//    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(onLongPress:)];
//    [_container addGestureRecognizer:longPress];
//    [self addSubview:_container];
//    _bubble = [[UIImageView alloc]init];
//    
//    [self addSubview:_bubble];
//    _content = [[UILabel alloc] init];
//    _content.font = [UIFont systemFontOfSize:14];
//    _content.numberOfLines = 0;
//    [_content sizeToFit];
//    [self addSubview:_content];
    
    //indicator
//    _indicator = [[UIActivityIndicatorView alloc] init];
//    _indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
//    [self addSubview:_indicator];
    //error
//    _error = [[UIImageView alloc] init];
//    _error.userInteractionEnabled = YES;
//    _error.backgroundColor = [UIColor redColor];
//    UITapGestureRecognizer *resendTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onReSend:)];
//    [_error addGestureRecognizer:resendTap];
    
//    [self addSubview:_error];
    

    
}

-(void)setIsDominator:(BOOL)isDominator{
    
    if (isDominator) {
//         [_head sd_setImageWithURL:[NSURL URLWithString:nil] placeholderImage:[UIImage imageNamed:@"notification "]];
        [_head setImage:[UIImage imageNamed:@"notification"]];
        [_head setBackgroundColor:MASTER_COLOR];
    }
}

-(void)setData:(JMMessageCellData *)data{
   
    [_head sd_setImageWithURL:[NSURL URLWithString:data.head] placeholderImage:[UIImage imageNamed:@"default_avatar"]];

    if(!data.isSelf){
        
        CGSize headSize = TMessageCell_Head_Size;
        _head.frame = CGRectMake(TMessageCell_Margin, TMessageCell_Margin, headSize.width, headSize.height);
       
    }else{ 
        
        CGSize headSize = TMessageCell_Head_Size;
        CGFloat headx = SCREEN_WIDTH - TMessageCell_Margin - headSize.width;
        _head.frame = CGRectMake(headx, TMessageCell_Margin, headSize.width, headSize.height);
 
    }
    
    
}


////点击事件
//- (void)onLongPress:(UIGestureRecognizer *)recognizer
//{
////    if([recognizer isKindOfClass:[UILongPressGestureRecognizer class]] &&
////       recognizer.state == UIGestureRecognizerStateBegan){
////        if(_delegate && [_delegate respondsToSelector:@selector(didLongPressMessage:inView:)]){
////            [_delegate didLongPressMessage:_data inView:_container];
////        }
////    }
//}
//
//- (void)onReSend:(UIGestureRecognizer *)recognizer
//{
////    if(_delegate && [_delegate respondsToSelector:@selector(didReSendMessage:)]){
////        [_delegate didReSendMessage:_data];
////    }
//}
//
//
//- (void)onTap:(UIGestureRecognizer *)recognizer
//{
//    if(_delegate && [_delegate respondsToSelector:@selector(didSelectMessage:)]){
//        [_delegate didSelectMessage:_data];
//    }
//}
@end
