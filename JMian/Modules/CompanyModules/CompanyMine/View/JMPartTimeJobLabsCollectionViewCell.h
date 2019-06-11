//
//  JMPartTimeJobLabsCollectionViewCell.h
//  JMian
//
//  Created by mac on 2019/6/10.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface JMPartTimeJobLabsCellData : NSObject

@property (nonatomic, copy) NSString *label_id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *is_enabled;


@end

//@protocol JMPartTimeJobLabsCollectionViewCellDelegate <NSObject>
//
//-(void)didClickLabCellWithLabs:(NSArray *)labs;
//
//@end

@interface JMPartTimeJobLabsCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *labName;
@property (nonatomic , strong)JMPartTimeJobLabsCellData *labData;
//@property (nonatomic, weak)id<JMPartTimeJobLabsCollectionViewCellDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
