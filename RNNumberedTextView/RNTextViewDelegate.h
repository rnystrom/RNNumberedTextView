//
//  RNTextViewDelegate.h
//  Tranquility
//
//  Created by Ryan Nystrom on 11/22/12.
//  Copyright (c) 2012 Ryan Nystrom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RNForwardedTextViewDelegate.h"

@interface RNTextViewDelegate : NSObject
<UITextViewDelegate>

@property (weak, nonatomic) id <UITextViewDelegate> forwardingDelegate;
@property (weak) id <RNForwardedTextViewDelegate> delegatedTextView;

@end
