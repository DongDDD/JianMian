//
//  JMPartTimeJobLabsCollectionViewCell.m
//  JMian
//
//  Created by mac on 2019/6/10.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMPartTimeJobLabsCollectionViewCell.h"
#import "DimensMacros.h"

@implementation JMPartTimeJobLabsCellData

@end

@implementation JMPartTimeJobLabsCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil].lastObject;
//        [self.labsNameBtn setTitleColor:MASTER_COLOR forState:UIControlStateSelected];
//              [self.labsNameBtn setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
//        
//        UIView *backgroundView = [UIView new];
//        backgroundView.backgroundColor = MASTER_COLOR;
//        self.selectedBackgroundView = backgroundView;

    }
    return self;
}

-(void)setLabData:(JMPartTimeJobLabsCellData *)labData{
    self.labName.text = labData.name;
//    [self.labsNameBtn setTitle:labData.name forState:UIControlStateNormal];
}
//- (IBAction)didClickLab:(UIButton *)sender {
//    sender.selected = !sender.selected;
//}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
