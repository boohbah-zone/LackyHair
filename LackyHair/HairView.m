//
//  HairView.m
//  LackyHair
//
//  Created by Yamamoto Jumpei on 2014/01/12.
//  Copyright (c) 2014年 Yamamoto Jumpei. All rights reserved.
//

#import "HairView.h"


@implementation HairView
{
    NSUInteger _animationFrame;
    NSTimer* _timer;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void)timerFired
{
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    if(!_timer){
        _timer = [NSTimer
                  scheduledTimerWithTimeInterval:0.01
                  target:self
                  selector:@selector(timerFired)
                  userInfo:nil
                  repeats:YES];
    }
    
    
    int points = 100;
    CGContextRef c = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(c, [UIColor clearColor].CGColor);
    
    CGContextFillRect(c, rect);
    
    CGContextSetFillColorWithColor(c, [UIColor blackColor].CGColor);
    
    float freq = 30;
    for (int i = 0; i < points; i++) {
        float y = i;
        float x = sinf(i*M_PI/360 * 6) * cosf((i + _animationFrame)*M_PI * freq / 360) * 5 + 10;
        
        CGContextFillRect(c, CGRectMake(x, y, 1, 2));
    }
    _animationFrame++;
}

@end
