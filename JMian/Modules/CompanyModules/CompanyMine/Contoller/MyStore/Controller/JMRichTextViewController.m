//
//  JMRichTextViewController.m
//  JMian
//
//  Created by mac on 2020/2/28.
//  Copyright © 2020 mac. All rights reserved.
//

#import "JMRichTextViewController.h"
 
@interface JMRichTextViewController ()

@end

@implementation JMRichTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.view addSubview:self.richTextView];
    
    self.title = @"Standard";
    
    //Set Custom CSS
    NSString *customCSS = @"";
 
    // Export HTML
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Export" style:UIBarButtonItemStylePlain target:self action:@selector(exportHTML)];
    
    // HTML Content to set in the editor
    NSString *html = @"<div class='test'></div><!-- This is an HTML comment -->"
    "<p>This is a test of the <strong>ZSSRichTextEditor</strong> by <a title=\"Zed Said\" href=\"http://www.zedsaid.com\">Zed Said Studio</a></p>";
    
    // Set the base URL if you would like to use relative links, such as to images.
    self.baseURL = [NSURL URLWithString:@"http://www.zedsaid.com"];
    self.shouldShowKeyboard = NO;
    // Set the HTML contents of the editor
    [self setPlaceholder:@"This is a placeholder that will show when there is no content(html)"];
   [self setHTML:html];

    // Do any additional setup after loading the view from its nib.
}

- (void)showInsertURLAlternatePicker {
    
    [self dismissAlertView];
    
 
}


- (void)showInsertImageAlternatePicker {
    
    [self dismissAlertView];
    
 
}


- (void)exportHTML {
  
}

- (void)editorDidChangeWithText:(NSString *)text andHTML:(NSString *)html {
    
    NSLog(@"Text Has Changed: %@", text);
    
    NSLog(@"HTML Has Changed: %@", html);
    
}

- (void)hashtagRecognizedWithWord:(NSString *)word {
    
    NSLog(@"Hashtag has been recognized: %@", word);
    
}

- (void)mentionRecognizedWithWord:(NSString *)word {
    
    NSLog(@"Mention has been recognized: %@", word);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
