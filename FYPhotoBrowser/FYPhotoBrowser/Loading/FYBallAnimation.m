//
//  FYBallAnimation.m
//  FFKit
//
//  Created by fan on 2017/4/18.
//  Copyright © 2017年 fan. All rights reserved.
//

#import "FYBallAnimation.h"
#import "FYPhotoViewMacro.h"

@interface FYBallAnimation () {
    
}
@property (nonatomic, strong) NSMutableArray* ballLists;
@property (nonatomic, strong) NSTimer* timer;
@property (nonatomic) CGFloat angle;

@end

@implementation FYBallAnimation

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self _setUp];
    }
    return self;
}

#pragma mark - init
- (void)_setUp {
    NSArray* colorList = @[UICOLOR_HEX(0xE3746B),
                           UICOLOR_HEX(0x397BF9),
                           UICOLOR_HEX(0xF4B400),
                           UICOLOR_HEX(0x0F9D58)];
    
    for (NSInteger i = 0; i < 4; i ++) {
        UIView* view = [[UIView alloc] initWithFrame:({
            CGRect rect = CGRectZero;
            rect.size.width = self.bounds.size.width * 0.2;
            rect.size.height = self.bounds.size.height * 0.2;
            rect.origin.x = (self.bounds.size.width - CGRectGetWidth(rect)) / 2;
            rect.origin.y = (self.bounds.size.height - CGRectGetHeight(rect)) / 2;
            rect;
        })];
        
        UIView* circleView = [[UIView alloc] initWithFrame:({
            CGRect rect = CGRectZero;
            rect.origin.x = 0;
            rect.origin.y = 0;
            rect.size.width = view.bounds.size.width;
            rect.size.height = view.bounds.size.width;
            rect;
        })];
        circleView.backgroundColor = colorList[i];
        circleView.layer.cornerRadius = circleView.bounds.size.width / 2;
        [view addSubview:circleView];
        
        CGFloat controlX = circleView.bounds.size.width * 0.8;
        
        circleView.layer.masksToBounds = YES;
        CAShapeLayer* layer = [CAShapeLayer layer];
        UIBezierPath* path = [[UIBezierPath alloc] init];
        [path moveToPoint:CGPointMake(circleView.bounds.size.width, 0)];
        [path addQuadCurveToPoint:CGPointMake(0, circleView.bounds.size.height) controlPoint:CGPointMake(controlX, controlX)];
        [path addLineToPoint:CGPointMake(circleView.bounds.size.width, circleView.bounds.size.height)];
        [path closePath];
        layer.path = path.CGPath;
        layer.fillColor = UICOLOR_HEX_ALPHA(0x000000, 0.15).CGColor;
        [circleView.layer addSublayer:layer];
        
        UIView* shadowView = [[UIView alloc] initWithFrame:({
            CGRect rect = CGRectZero;
            rect.origin.x = 0;
            rect.origin.y = CGRectGetMaxY(circleView.frame) * 0.9;
            rect.size = circleView.bounds.size;
            rect;
        })];
        shadowView.backgroundColor = UICOLOR_RGB(238, 238, 238);
        shadowView.layer.cornerRadius = shadowView.bounds.size.width / 2;
        
        CATransform3D trans = CATransform3DIdentity;
        trans.m34 = -1.0f / 500;
        trans = CATransform3DConcat(CATransform3DMakeRotation(M_PI_2 * 15 / 16, 1, 0, 0), trans);
        
        shadowView.layer.transform = trans;
        [view addSubview:shadowView];
        
        [self addSubview:view];
        [self.ballLists addObject:view];
    }
}

#pragma mark - overwrite
- (void)showAnimated:(BOOL)animated {
    if (!self.superview)
        [self.attachView addSubview:self];
    
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    
    self.timer = [NSTimer timerWithTimeInterval:0.03 target:self selector:@selector(update:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)hideAnimated:(BOOL)animated {
    [self.timer invalidate];
    self.timer = nil;
    
    [self removeFromSuperview];
}

#pragma mark - tools
- (void)update:(NSTimer*)timer {
    self.angle += 0.05;
    if (self.angle == 10) {
        self.angle = 0;
    }
    
    [self.ballLists enumerateObjectsUsingBlock:^(UIView*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CATransform3D trans = CATransform3DIdentity;
        trans.m34 = -1.0f / 300;
        CGFloat tempAngle = M_PI_2 * idx - self.angle;
        CGFloat radius = 40;
        
        obj.layer.transform = CATransform3DConcat(CATransform3DMakeTranslation(radius * sin(tempAngle), 0, radius * cos(tempAngle) + radius), trans);
    }];
}

#pragma mark - getter
- (NSMutableArray *)ballLists {
    if (!_ballLists) {
        _ballLists = [NSMutableArray array];
    }
    return _ballLists;
}

@end
