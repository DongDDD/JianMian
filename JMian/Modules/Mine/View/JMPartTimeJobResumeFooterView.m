//
//  JMPartTimeJobResumeFooterView.m
//  JMian
//
//  Created by mac on 2019/6/2.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMPartTimeJobResumeFooterView.h"
#import "DimensMacros.h"
@interface JMPartTimeJobResumeFooterView ()<UITextViewDelegate>

@property(nonatomic,strong)UILabel *wordsLenghLabel;
@property(nonatomic,strong)UILabel *titleLab;

@end

@implementation JMPartTimeJobResumeFooterView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
        [self initLayout];
     
    }
    return self;

}

-(void)initView{
    _titleLab = [[UILabel alloc]init];
    _titleLab.textColor = TITLE_COLOR;
    _titleLab.font = kFont(14);
    [self addSubview:_titleLab];

    _contentTextView = [[UITextView alloc]init];
    _contentTextView.delegate = self;
    _contentTextView.textColor = TITLE_COLOR;
    _contentTextView.font = kFont(14);
    [self addSubview:_contentTextView];
    
    _placeHolder = [[UILabel alloc]init];
    _placeHolder.textColor = TEXT_GRAY_COLOR;
    _placeHolder.font = kFont(14);
    _placeHolder.numberOfLines = 0;
    [self addSubview:_placeHolder];
    
    _wordsLenghLabel = [[UILabel alloc]init];
    _wordsLenghLabel.textColor = MASTER_COLOR;
    _wordsLenghLabel.font = kFont(13);
    _wordsLenghLabel.text = @"0/500";
    [self addSubview:_wordsLenghLabel];
    
    
}

-(void)initLayout{
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(20);
        make.left.mas_equalTo(self).offset(20);
    }];
    [_contentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_titleLab).offset(20);
        make.left.mas_equalTo(self).offset(20);
        make.right.mas_equalTo(self).offset(-20);
        make.bottom.mas_equalTo(self).offset(-30);
    }];
    [_placeHolder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_contentTextView);
        make.left.mas_equalTo(_contentTextView);
    }];
    [_wordsLenghLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).offset(-20);
        make.bottom.mas_equalTo(self).offset(-10);
    }];
    
}

-(void)setViewType:(JMPartTimeJobResumeFooterViewType)viewType{
    switch (viewType) {
        case JMPartTimeJobResumeFooterViewTypeDefault:
            _titleLab.text = @"工作描述";
            _placeHolder.text = @"可描述你的工作技能、岗位职责、特长等等.. ";
            
            break;
            
        case JMPartTimeJobResumeFooterViewTypePartTimeJob:
            _titleLab.text = @"职位描述";
            _placeHolder.text = @"例如\n职位要求、\n性别要求、\n工作时段等等   ";
            break;
        case JMPartTimeJobResumeFooterViewTypeGoodsDesc:
            _placeHolder.text = @"例如\n品牌名称:\n品牌型号:\n产品颜色:\n生产企业等等";

            break;
        case JMPartTimeJobResumeFooterViewTypeCommentDesc:
            _placeHolder.text = @"请填写评价";
            
            break;
        default:
            break;
    }
    
    
//    if (viewType == JMPartTimeJobResumeFooterViewTypeGoodsDesc) {
////        _titleLab.text = @"例如";
//        _placeHolder.text = @"例如\n品牌名称:\n品牌型号:\n产品颜色:\n生产企业等等";
//    }else{
//        _titleLab.text = @"工作描述";
//        _placeHolder.text = @"可描述你的工作技能、岗位职责、特长等等.. ";
//    
//    }
}


-(void)setContent:(NSString *)content{
    _contentTextView.text = content;
    self.wordsLenghLabel.text = [NSString stringWithFormat:@"%lu/500", (unsigned long)content.length];
    if (content.length > 0) {
        self.placeHolder.hidden = YES;
    }

    
}

-(void)textViewDidBeginEditing:(UITextView *)textView{

    self.placeHolder.hidden = YES;

}

//正在改变
- (void)textViewDidChange:(UITextView *)textView
{
    
    
    self.wordsLenghLabel.text = [NSString stringWithFormat:@"%lu/500", (unsigned long)textView.text.length];
  
    if (textView.text.length >= 500) {

        textView.text = [textView.text substringToIndex:500];
        _wordsLenghLabel.text = @"500/500";
     
    }
    
    if (textView.text.length == 0) {
        _placeHolder.hidden = NO;
   
    }
    
}
-(BOOL)textViewShouldEndEditing:(UITextView *)textView{
    if (textView.text.length == 0) {
        _placeHolder.hidden = NO;

    }
    if (_delegate && [_delegate respondsToSelector:@selector(sendContent:)]) {
        [_delegate sendContent:textView.text];
    }
    return YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
