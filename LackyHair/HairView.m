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
    BOOL _mode;
}

- (id)initWithFrame:(CGRect)frame mode:(BOOL)mode
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _mode = mode;
        

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
    
    
    int points = (80.0 + 20.0* sinf(_animationFrame*M_PI/360 * 2));
    CGContextRef c = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(c, [UIColor clearColor].CGColor);
    
    CGContextFillRect(c, rect);
    
    CGContextSetFillColorWithColor(c, [UIColor blackColor].CGColor);
    
    float freq = 30;
    for (int i = 0; i < points; i++) {

        if(_mode){
            float mag = _animationFrame > 100? 1:_animationFrame * 0.01;
            float y = i * mag ;
            float x = sinf(((i + _animationFrame)*M_PI * freq / 360)*mag) * 5 *i * 0.02 * mag*mag+ 10;
            CGContextFillRect(c, CGRectMake(x, y, 2, 5));
            
        }else{
            float y = i;
            float x = sinf(i*M_PI/360 * 6) * cosf((i + _animationFrame)*M_PI * freq / 360) * 5 + 10;
            CGContextFillRect(c, CGRectMake(x, y, 1, 1));
        }
        
    }
    _animationFrame++;
}

@end
