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

@implementation JMMessageCellData : NSObject
//- (id)init
//{
//    self = [super init];
//    if(self){
//        _status = Msg_Status_Sending;
//    }
//    return self;
//}
@end




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
    _bubble = [[UIImageView alloc]init];
    
    [self addSubview:_bubble];
    _content = [[UILabel alloc] init];
    _content.font = [UIFont systemFontOfSize:14];
    _content.numberOfLines = 0;
    [_content sizeToFit];
    [self addSubview:_content];
    
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
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    
}

-(void)setData:(JMMessageCellData *)data{

//    _data = data;
    
   
//    _head.image = GETImageFromURL(data.head);
      [_head sd_setImageWithURL:[NSURL URLWithString:data.head] placeholderImage:[UIImage imageNamed:@"default_avatar"]];
    _content.text = data.content;
  //行距
    NSString  *testString = _content.text;
    NSMutableParagraphStyle  *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    NSMutableAttributedString  *setString = [[NSMutableAttributedString alloc] initWithString:testString];
    [setString  addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [testString length])];
    [_content  setAttributedText:setString];
    [paragraphStyle  setLineSpacing:2];

    if(!data.isSelf){
        
        CGSize headSize = TMessageCell_Head_Size;
        _head.frame = CGRectMake(TMessageCell_Margin, TMessageCell_Margin, headSize.width, headSize.height);
        CGFloat contentx = _head.frame.origin.x + _head.frame.size.width + TMessageCell_Margin;
        CGFloat contenty = _head.frame.origin.y+10;
        CGSize size = [_content sizeThatFits:CGSizeMake(SCREEN_WIDTH*0.6, MAXFLOAT)];
        _content.frame = CGRectMake(contentx+10, contenty, size.width, size.height);
       
        //气泡
        _bubble.image = [self getBubbleImgWithImgName:@"other_bubble" rectMoveX:20];
        
    }else{
        
        CGSize headSize = TMessageCell_Head_Size;
        CGFloat headx = SCREEN_WIDTH - TMessageCell_Margin - headSize.width;
        CGSize contentSize = [self getlabelRectWith:_content.text];
        _head.frame = CGRectMake(headx, TMessageCell_Margin, headSize.width, headSize.height);
        CGFloat contentx = _head.frame.origin.x -TMessageCell_Margin - contentSize.width-10;
        CGFloat contenty = _head.frame.origin.y+10;
        CGSize size = [_content sizeThatFits:CGSizeMake(SCREEN_WIDTH*0.6, MAXFLOAT)];
        _content.frame = CGRectMake(contentx, contenty, size.width, size.height);
       
        //气泡
        _bubble.image = [self getBubbleImgWithImgName:@"me_bubble" rectMoveX:8];
      
    }
    
    
}

-(UIImage *)getBubbleImgWithImgName:(NSString *)imgName rectMoveX:(CGFloat)rectMoveX
{
    CGRect rect = CGRectZero;

    rect = _content.frame;
    rect.origin.x =  rect.origin.x -rectMoveX;
    rect.origin.y =  rect.origin.y -13;
    
    rect.size.width =  rect.size.width + 26;
    rect.size.height = rect.size.height + 26;
    _bubble.frame = rect;
    UIImage* img=[UIImage imageNamed:imgName];//原图
    UIEdgeInsets edge=UIEdgeInsetsMake(40, 18, 18,20);
    img= [img resizableImageWithCapInsets:edge resizingMode:UIImageResizingModeStretch];
  
    return img;
    
}


- (CGFloat)getHeight:(JMMessageCellData *)data
{
    CGSize containerSize = [self getlabelRectWith:data.content];
    CGFloat height = containerSize.height + TMessageCell_Margin * 3;
    CGFloat minHeight = TMessageCell_Head_Size.height + 2 * TMessageCell_Margin;
    if(height < minHeight){
        height = minHeight;
    }
    return height;
}



- (CGSize)getlabelRectWith:(NSString *)text
{
//    NSDictionary *attributes = @{NSFontAttributeName: textFont};
//    CGRect rect = [text boundingRectWithSize:maxSize
//                                     options:NSStringDrawingUsesLineFragmentOrigin
//                                  attributes:attributes
//                                     context:nil];
    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:14] maxSize:CGSizeMake(SCREEN_WIDTH*0.6, MAXFLOAT) andlineSpacing:2];
    return size;
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
