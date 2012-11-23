//
//  RNNumberedTextViewDelegate.h
//  Tranquility
//
//  Created by Ryan Nystrom on 11/22/12.
//  Copyright (c) 2012 Ryan Nystrom. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RNNumberedTextView;

@protocol RNNumberedTextViewDelegate <NSObject>

@required
- (UIView*)viewForNumberedTextView:(RNNumberedTextView*)textView lineNumber:(NSInteger)lineNumber withText:(NSString*)text;

@end
