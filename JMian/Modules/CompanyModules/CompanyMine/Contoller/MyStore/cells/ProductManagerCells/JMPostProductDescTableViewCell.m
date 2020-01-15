//
//  JMPostProductDescTableViewCell.m
//  JMian
//
//  Created by mac on 2020/1/12.
//  Copyright © 2020 mac. All rights reserved.
//

#import "JMPostProductDescTableViewCell.h"
#import "JMPartTimeJobResumeFooterView.h"
#import "DimensMacros.h"
NSString *const JMPostProductDescTableViewCellIdentifier = @"JMPostProductDescTableViewCellIdentifier";

@interface JMPostProductDescTableViewCell ()<JMPartTimeJobResumeFooterViewDelegate>
@property(nonatomic,strong)JMPartTimeJobResumeFooterView *decriptionTextView;

@end
@implementation JMPostProductDescTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.contentView addSubview:self.decriptionTextView];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

 

-(JMPartTimeJobResumeFooterView *)decriptionTextView{
    if (_decriptionTextView == nil) {
        _decriptionTextView = [JMPartTimeJobResumeFooterView new];
        _decriptionTextView.frame = CGRectMake(10, 0, SCREEN_WIDTH-20, 200);
        _decriptionTextView.delegate = self;
//        _decriptionTextView.contentTextView.inputAccessoryView = self.myToolbar;
        _decriptionTextView.titleLab.text = @"商品描述";
        _decriptionTextView.wordsLenghLabel.text = @"0/200";
        _decriptionTextView.contentTextView.backgroundColor = BG_COLOR;
//        [_decriptionTextView setViewType:JMPartTimeJobResumeFooterViewTypeGroup];
        //        _decriptionTextView.contentTextView.delegate = self;
        
    }
    return _decriptionTextView;
}
@end
