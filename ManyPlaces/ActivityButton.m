//
//  ActivityButton.m
//  ManyPlaces
//
//  Created by Tin Nguyen on 7/19/15.
//  Copyright (c) 2015 Tin Nguyen. All rights reserved.
//

#import "ActivityButton.h"

@interface ActivityButton ()

@property (nonatomic,strong) UIActivityIndicatorView *indicator;

@end

@implementation ActivityButton


- (void)startAnimating
{
    [self setImage:[UIImage new] forState:UIControlStateDisabled];
    
    self.enabled = NO;
    
    CGFloat x = 0.0;
    CGFloat y = 0.0;

    if (self.indicator == nil) {
        self.indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        self.indicator.frame = CGRectMake(x, y, 24.0, 24.0);
        self.indicator.hidesWhenStopped = YES;
        self.indicator.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin |
        UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        
        [self addSubview:self.indicator];
    }
    
    [self.indicator startAnimating];
}

- (void)stopAnimating
{
    [self.indicator stopAnimating];
    self.enabled = YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
