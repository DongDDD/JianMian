//
//  ZSSDemoViewController.m
//  ZSSRichTextEditor
//
//  Created by Nicholas Hubbard on 11/29/13.
//  Copyright (c) 2013 Zed Said Studio. All rights reserved.
//

#import "ZSSDemoViewController.h"
#import "ZSSDemoPickerViewController.h"


#import "DemoModalViewController.h"


@interface ZSSDemoViewController ()

@end

@implementation ZSSDemoViewController


- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.title = @"Colors";
    
    // HTML Content to set in the editor
    NSString *html = @"<p>This editor is using <strong>custom toolbar colors</strong>.</p>";
    
    // Set the base URL if you would like to use relative links, such as to images.
    self.baseURL = [NSURL URLWithString:@"http://www.zedsaid.com"];
    
    // Set the toolbar item color
    self.toolbarItemTintColor = [UIColor redColor];
    
    // Set the toolbar selected color
    self.toolbarItemSelectedTintColor = [UIColor blackColor];
    
    // Set the HTML contents of the editor
    [self setHTML:html];
    
}


 

@end
