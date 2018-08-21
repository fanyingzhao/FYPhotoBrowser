//
//  FYCircleAnimation.m
//  FYPhotoBrowser
//
//  Created by fyz on 2018/8/20.
//  Copyright © 2018年 com.fyz. All rights reserved.
//

#import "FYCircleAnimation.h"

// 图片下载进度指示器内部控件间的间距
#define HZWaitingViewItemMargin 10
#define HZWaitingViewBackgroundColor [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7]
@implementation FYCircleAnimation

#pragma mark - Init
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = HZWaitingViewBackgroundColor;
        self.clipsToBounds = YES;
        self.mode = 0;
    }
    return self;
}

#pragma mark - Override
- (void)drawRect:(CGRect)rect {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGFloat xCenter = rect.size.width * 0.5;
    CGFloat yCenter = rect.size.height * 0.5;
    [[UIColor whiteColor] set];
    
    switch (self.mode) {
        case 0: {
            CGFloat radius = MIN(rect.size.width * 0.5, rect.size.height * 0.5) - HZWaitingViewItemMargin;
            
            CGFloat w = radius * 2 + HZWaitingViewItemMargin;
            CGFloat h = w;
            CGFloat x = (rect.size.width - w) * 0.5;
            CGFloat y = (rect.size.height - h) * 0.5;
            CGContextAddEllipseInRect(ctx, CGRectMake(x, y, w, h));
            CGContextFillPath(ctx);
            
            [HZWaitingViewBackgroundColor set];
            CGContextMoveToPoint(ctx, xCenter, yCenter);
            CGContextAddLineToPoint(ctx, xCenter, 0);
            float offset = 0.001;
            if (self.progress == 1)
                offset = 0;
            CGFloat to = - M_PI * 0.5 + self.progress * M_PI * 2 + offset; // 初始值
            CGContextAddArc(ctx, xCenter, yCenter, radius, - M_PI * 0.5, to, 1);
            CGContextClosePath(ctx);
            
            CGContextFillPath(ctx);
        }
            break;
            
        default: {
            CGContextSetLineWidth(ctx, 4);
            CGContextSetLineCap(ctx, kCGLineCapRound);
            CGFloat to = - M_PI * 0.5 + self.progress * M_PI * 2 + 0.05; // 初始值0.05
            CGFloat radius = MIN(rect.size.width, rect.size.height) * 0.5 - HZWaitingViewItemMargin;
            CGContextAddArc(ctx, xCenter, yCenter, radius, - M_PI * 0.5, to, 0);
            CGContextStrokePath(ctx);
        }
            break;
    }
}

- (void)showAnimated:(BOOL)animated {
    [self initUI];
}

- (void)setFrame:(CGRect)frame {
    frame.size.width = 50;
    frame.size.height = 50;
    self.layer.cornerRadius = 25;
    [super setFrame:frame];
}

#pragma mark - Private
- (void)initUI {
    if (!self.superview) {
        if (!self.superview) {
            [self.attachView addSubview:self];
            self.center = CGPointMake(CGRectGetMidX(self.attachView.bounds), CGRectGetMidY(self.attachView.bounds));
        }
        self.backView.hidden = YES;
    }
}

#pragma mark - Getter and Setter
- (void)setProgress:(CGFloat)progress {
    if (progress >= 1) {
        progress = 1;
    }else if (progress <= 0) {
        progress = 0;
    }
    
    _progress = progress;
    [self setNeedsDisplay];
}

@end
