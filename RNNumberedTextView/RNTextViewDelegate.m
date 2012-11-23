//
//  RNTextViewDelegate.m
//  Tranquility
//
//  Created by Ryan Nystrom on 11/22/12.
//  Copyright (c) 2012 Ryan Nystrom. All rights reserved.
//

#import "RNTextViewDelegate.h"

@implementation RNTextViewDelegate

- (void)textViewDidChange:(UITextView *)textView {
    if (self.forwardingDelegate && [self.forwardingDelegate respondsToSelector:@selector(textViewDidChange:)]) {
        [self.forwardingDelegate textViewDidChange:textView];
    }
    if (self.delegatedTextView && [self.delegatedTextView respondsToSelector:@selector(textViewDidChange:)]) {
        [self.delegatedTextView textViewDidChange:textView];
    }
}

@end
