//
//  JMMyResumeCellConfigures.m
//  JMian
//
//  Created by Chitat on 2019/3/31.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMMyResumeCellConfigures.h"

@implementation JMMyResumeCellConfigures

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (void)initDataWithSection:(NSInteger)section {
    switch (section) {
        case JMMyResumeCellTypeIcon:
            self.rowsNum = 1;
            self.footerheight = 10;
            self.height = 98;
            self.cellId = JMMyResumeIconTableViewCellIdentifier;
            break;
        case JMMyResumeCellTypeHeader:
            self.rowsNum = 1;
            self.footerheight = 0;
            self.height = 75;
            self.cellId = JMMyResumeHeaderTableViewCellIdentifier;
            break;
        case JMMyResumeCellTypeCareerStatus:
            self.rowsNum = 1;
            self.footerheight = 0;
            self.height = 98;
            self.cellId = JMMyResumeCareerStatusTableViewCellIdentifier;
            break;
        case JMMyResumeCellTypeCareerObjective:
            self.rowsNum = 3;
            self.footerheight = 0;
            self.height = 70;
            self.cellId = JMMyResumeCareerObjectiveTableViewCellIdentifier;
            break;
        case JMMyResumeCellTypeCareerStatus2:
            self.rowsNum = 1;
            self.footerheight = 10;
            self.height = 98;
            self.cellId = JMMyResumeCareerStatus2TableViewCellIdentifier;
            break;
        case JMMyResumeCellTypeHeader2:
            self.rowsNum = 1;
            self.footerheight = 10;
            self.height = 75;
            self.cellId = JMMyResumeHeader2TableViewCellIdentifier;
            break;
        default:
            break;
    }

}

- (NSInteger)numberOfRowsInSection:(NSInteger)section {
    [self initDataWithSection:section];
    return self.rowsNum;
}

- (CGFloat)heightForFooterInSection:(NSInteger)section {
    [self initDataWithSection:section];
    return self.footerheight;
}

- (CGFloat)heightForRowsInSection:(NSInteger)section {
    [self initDataWithSection:section];
    return self.height;
}

- (NSString *)cellIdForSection:(NSInteger)section {
    [self initDataWithSection:section];
    return self.cellId;
}

- (void)didSelectedRowAtSection:(NSInteger)section {
    
}

- (void)setSection:(NSInteger)section {
    if (!_section) {
        
    }
}

@end
