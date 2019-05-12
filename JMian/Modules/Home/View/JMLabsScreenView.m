//
//  JMLabsScreenView.m
//  JMian
//
//  Created by mac on 2019/5/11.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMLabsScreenView.h"
#import "UIView+Ext.h"
#import "NSString+Extension.h"
#import "DimensMacros.h"
#define ChooseCount 1  //可以选择多少个成员

@implementation JMLabsScreenView

-(instancetype)initWithFrame:(CGRect)frame
{
    if ( self ==  [super initWithFrame:frame] )
    {
//        [self createLabUI];
        self.selectedBtnArray = [[NSMutableArray alloc]init];
        self.backgroundColor = BG_COLOR;
        
    }
    return  self;
}



- (void)createLabUI_title:(NSString *)title labsArray:(NSArray *)labsArray
{
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(20, 34, 100, 14)];
    titleLab.text = title;
    titleLab.font = [UIFont systemFontOfSize:14];
    titleLab.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    [self addSubview:titleLab];

    
    NSArray * tagArr = labsArray;
    CGFloat tagBtnX = 20;
    CGFloat tagBtnY = titleLab.frame.origin.y+titleLab.frame.size.height+16;
    for (int i= 0; i<tagArr.count; i++) {
        
        CGSize tagTextSize = [tagArr[i] sizeWithFont:GlobalFont(14) maxSize:CGSizeMake(SCREEN_WIDTH-25, 29)];
        if (tagBtnX+tagTextSize.width+30 > SCREEN_WIDTH-32) {
            
            tagBtnX = 20;
            tagBtnY += 29+15;
        }
        
        _tagBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _tagBtn.tag = i;
        _tagBtn.frame = CGRectMake(tagBtnX, tagBtnY, tagTextSize.width+50, 30);
        _tagBtn.backgroundColor = [UIColor whiteColor];
        [_tagBtn setTitle:tagArr[i] forState:UIControlStateNormal];
        if (i == 0) {
//            [_tagBtn setTitleColor:MASTER_COLOR forState:UIControlStateNormal];
            _tagBtn.selected = YES;
        }else{
            _tagBtn.selected = NO;
        
        }
        [_tagBtn setTitleColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0] forState:UIControlStateNormal];
        [_tagBtn setTitleColor:MASTER_COLOR forState:UIControlStateSelected];
        _tagBtn.titleLabel.font = GlobalFont(16);
        _tagBtn.layer.cornerRadius = 15.3;
        _tagBtn.layer.masksToBounds = YES;
        _tagBtn.layer.borderWidth = 1;
//        [_tagBtn setBackgroundImage:[UIImage imageNamed:@"IDCard1"] forState:UIControlStateNormal];
//        [_tagBtn setBackgroundImage:[UIImage imageNamed:@"dingwei"] forState:UIControlStateSelected];

        _tagBtn.layer.borderColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:0.41].CGColor;
        [_tagBtn addTarget:self action:@selector(tagBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_tagBtn];
        
        tagBtnX = CGRectGetMaxX(_tagBtn.frame)+10;
    }
    
    !self.didCreateLabs ? : self.didCreateLabs(tagBtnY);

}


- (void)tagBtnClick:(UIButton *)sender
{
//多选
//    sender.selected = !sender.selected;
//    if (sender.selected)
//    {
//        if (_selectedBtnArray.count < 1 ) {
//            [sender setBackgroundColor:MASTER_COLOR];
//            [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//            [_selectedBtnArray addObject:sender];
//        }
//
//    }
//    if (!sender.selected)
//    {
//        [sender setBackgroundColor:[UIColor whiteColor]];
//        [sender setTitleColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0] forState:UIControlStateNormal];
//        [_selectedBtnArray removeObject:sender];
//    }
    //单选
    if (_tagBtn == nil){
        sender.selected = YES;
        _tagBtn = sender;
    }
    else  if (_tagBtn !=nil &&_tagBtn == sender){
        sender.selected = YES;
    } else if (_tagBtn!= sender && _tagBtn!=nil){
        _tagBtn.selected = NO;
        sender.selected = YES;
        _tagBtn = sender;
    }
    _selectIndex = sender.tag;
}


//-(NSMutableArray *)selectedBtnArray{
//    if (_selectedBtnArray==nil) {
//        _selectedBtnArray = [NSMutableArray array];
//    }
//    return _selectedBtnArray;
//}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
