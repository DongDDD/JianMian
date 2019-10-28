//
//  JMVersionDetailsView.m
//  JMian
//
//  Created by mac on 2019/10/11.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMVersionDetailsView.h"

@implementation JMVersionDetailsView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        
        paragraphStyle.lineSpacing = 8;// 字体的行间距
        
        NSDictionary *attributes = @{
                                     NSFontAttributeName:[UIFont systemFontOfSize:13],
                                     NSParagraphStyleAttributeName:paragraphStyle
                                     };
        
        self.versionDetailTextView.attributedText = [[NSAttributedString alloc] initWithString:self.versionDetailTextView.text attributes:attributes];
    }
    return self;
}


- (IBAction)updateAction:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(updateAction)]) {
        [_delegate updateAction];
    }
    
}
- (IBAction)deleteAction:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(deleteAction)]) {
        [_delegate deleteAction];
        
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
