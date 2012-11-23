//
//  RNNumberedTextView.m
//  Tranquility
//
//  Created by Ryan Nystrom on 11/22/12.
//  Copyright (c) 2012 Ryan Nystrom. All rights reserved.
//

#import "RNTextViewDelegate.h"     
#import "RNNumberedTextView.h"

@implementation RNNumberedTextView {
    NSMutableArray *_lineNumberLabels;
    NSMutableArray *_delegates;
    RNTextViewDelegate *_internalDelegate;
    CGFloat _lineHeight;
}

#pragma mark - UITextView

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self _init];
    }
    return self;
}

- (id)init {
    if (self = [super init]) {
        [self _init];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self _init];
    }
    return self;
}

- (void)_init {
    self.clipsToBounds = NO;
    
    _internalDelegate = [[RNTextViewDelegate alloc] init];
    _internalDelegate.delegatedTextView = self;
    _lineNumberLabels = [NSMutableArray array];
    _delegates = [NSMutableArray array];
    
    self.delegate = _internalDelegate;
    
    _lineNumberLabels = [NSMutableArray array];
    
    // set font to update default line size
    self.font = [UIFont systemFontOfSize:15.f];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self updateLineNumbers];
}

#pragma mark - Actions

- (void)updateLineNumbers {
    NSString *text = self.text;
    NSArray *lines = [text componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    
    [lines enumerateObjectsUsingBlock:^(NSString *line, NSUInteger idx, BOOL *stop) {
        UIView *lineView = [self.lineNumberDelegate viewForNumberedTextView:self lineNumber:idx withText:line];
        if (idx >= [_lineNumberLabels count] && lineView) {
            if (lineView) {
                lineView.backgroundColor = [UIColor clearColor];
                [self addSubview:lineView];
                [_lineNumberLabels addObject:lineView];
            }
        }
    }];
    
    // seems to be best set here
    __block CGFloat runningHeight = -10.f;
    CGFloat left = -40.f;
    [_lineNumberLabels enumerateObjectsUsingBlock:^(UIView *lineView, NSUInteger idx, BOOL *stop) {
        if (lineView.superview) {
            [self addSubview:lineView];
        }
        
        if (idx >= [lines count]) {
            lineView.hidden = YES;
        }
        else {
            lineView.hidden = NO;
            lineView.frame = CGRectMake(left, runningHeight, lineView.bounds.size.width, _lineHeight);
            CGSize lineSize = [lines[idx] sizeWithFont:self.font constrainedToSize:CGSizeMake(self.bounds.size.width, 9999) lineBreakMode:NSLineBreakByWordWrapping];
            runningHeight += lineSize.height;
        }
    }];
}

#pragma mark - Helper

- (UIView*)dequeViewForLine:(NSInteger)lineNumber {
    if (lineNumber < [_lineNumberLabels count]) {
        return _lineNumberLabels[lineNumber];
    }
    return nil;
}

#pragma mark - Getters

- (NSArray*)lineNumberLabels {
    return _lineNumberLabels;
}

- (NSArray*)lines {
    return [self.text componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
}

#pragma mark - Setters

- (void)setDelegate:(id<UITextViewDelegate>)delegate {
    if (delegate == _internalDelegate) {
        [super setDelegate:_internalDelegate];
    }
    else {
        _internalDelegate.forwardingDelegate = delegate;
    }
}

- (void)setFont:(UIFont *)font {
    [super setFont:font];
    
    CGSize maxSize = CGSizeMake(self.contentSize.width, 9999);
    CGSize expectedSize = [@"testing" sizeWithFont:font constrainedToSize:maxSize lineBreakMode:NSLineBreakByWordWrapping];
    _lineHeight = expectedSize.height;
    [self updateLineNumbers];
}

#pragma mark - Forwarding

- (void)textViewDidChange:(UITextView *)textView {
    [self updateLineNumbers];
}

@end
