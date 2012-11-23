//
//  RNNumberedTextView.h
//  Tranquility
//
//  Created by Ryan Nystrom on 11/22/12.
//  Copyright (c) 2012 Ryan Nystrom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RNNumberedTextViewDelegate.h"
#import "RNForwardedTextViewDelegate.h"

@interface RNNumberedTextView : UITextView
<RNForwardedTextViewDelegate>

@property (nonatomic, readonly) NSArray *lineNumberLabels;
@property (nonatomic, readonly) NSArray *lines;
@property (weak, nonatomic) id <RNNumberedTextViewDelegate> lineNumberDelegate;

- (UIView*)dequeViewForLine:(NSInteger)lineNumber;

@end
