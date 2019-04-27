//
//  JMMyDescriptionViewController.m
//  JMian
//
//  Created by chitat on 2019/4/28.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMMyDescriptionViewController.h"
#import "JMHTTPManager+Vita.h"

@interface JMMyDescriptionViewController ()
@property (weak, nonatomic) IBOutlet UITextView *myDescriptionTextView;

@end

@implementation JMMyDescriptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setRightBtnTextName:@"保存"];
}

- (void)updateVita {
    [[JMHTTPManager sharedInstance] updateVitaWith_work_status:nil education:nil work_start_date:nil description:self.myDescriptionTextView.text video_path:nil image_paths:nil successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
       
        [self.navigationController popViewControllerAnimated:YES];
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
}

- (IBAction)saveBtn:(id)sender {
    [self updateVita];
}

- (void)rightAction {
    [self updateVita];
}

- (void)setMyDescription:(NSString *)myDescription {
    _myDescription = myDescription;
    self.myDescriptionTextView.text = myDescription;
}

@end
