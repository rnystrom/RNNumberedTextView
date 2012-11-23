//
//  RNViewController.m
//  example
//
//  Created by Ryan Nystrom on 11/23/12.
//  Copyright (c) 2012 Ryan Nystrom. All rights reserved.
//

#import "RNViewController.h"
#import "RNNumberedTextView.h"

@interface RNViewController ()

@property (weak, nonatomic) IBOutlet RNNumberedTextView *textView;

@end

@implementation RNViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.textView.lineNumberDelegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Line number delegate

- (UIView*)viewForNumberedTextView:(RNNumberedTextView*)textView lineNumber:(NSInteger)lineNumber withText:(NSString*)text {
    UILabel *label = (UILabel*)[textView dequeViewForLine:lineNumber];
    if (! label) {
        label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        label.textAlignment = NSTextAlignmentRight;
        label.font = [UIFont systemFontOfSize:12.f];
    }
    
    label.text = [NSString stringWithFormat:@"%i",lineNumber+1];
    
    return label;
}

@end
