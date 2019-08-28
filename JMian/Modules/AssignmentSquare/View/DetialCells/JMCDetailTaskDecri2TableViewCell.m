//
//  JMCDetailTaskDecri2TableViewCell.m
//  JMian
//
//  Created by mac on 2019/8/20.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMCDetailTaskDecri2TableViewCell.h"
NSString *const JMCDetailTaskDecri2TableViewCellIdentifier = @"JMCDetailTaskDecri2TableViewCellIdentifier";
@interface JMCDetailTaskDecri2TableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation JMCDetailTaskDecri2TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(JMCDetailModel *)model{
//    self.contentLab.text = model.myDescription;
    if (model.myDescription.length == 0) {
        [self.textView setText:@"暂无描述"];
    }else{
        [self.textView setText:model.myDescription];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        
        paragraphStyle.lineSpacing = 5;// 字体的行间距
        
        NSDictionary *attributes = @{
                                     NSFontAttributeName:[UIFont systemFontOfSize:14],
                                     NSParagraphStyleAttributeName:paragraphStyle
                                     };
        
        self.textView.attributedText = [[NSAttributedString alloc] initWithString:self.textView.text attributes:attributes];
        
    }
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
