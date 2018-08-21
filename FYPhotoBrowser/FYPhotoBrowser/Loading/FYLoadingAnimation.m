//
//  FYLoadingView.m
//  FFKit
//
//  Created by fan on 17/3/7.
//  Copyright © 2017年 fan. All rights reserved.
//

#import "FYLoadingAnimation.h"
#import "FYPhotoViewMacro.h"
#import "FYBallAnimation.h"

@interface FYLoadingAnimation()
@property (nonatomic) UIDeviceOrientation orient;
@end

@implementation FYLoadingAnimation

#pragma mark - Init
+ (instancetype)showLoadingForView:(UIView *)view animated:(BOOL)animated {
    return [FYLoadingAnimation showLoadingForView:view class:[FYBallAnimation class] animated:animated];
}

+ (instancetype)showLoadingForView:(UIView *)view class:(Class)class animated:(BOOL)animated {
    FYLoadingAnimation* animationView = [[class alloc] initWithView:view];
    [animationView showAnimated:animated];
    return animationView;
}

- (instancetype)initWithView:(UIView *)view {
    FYLoadingAnimation* animationView = [self initWithFrame:({
        CGRect rect = CGRectZero;
        rect.size.width = 150;
        rect.size.height = 150;
        rect.origin.x = (CGRectGetWidth(view.frame) - CGRectGetWidth(rect)) / 2;
        rect.origin.y = (CGRectGetHeight(view.frame) - CGRectGetHeight(rect)) / 2;
        rect;
    })];
    animationView.attachView = view;
    animationView.orient = UIDeviceOrientationPortrait;
    return animationView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.backView];
    }
    return self;
}

#pragma mark - overwrite
//- (void)didAddSubview:(UIView *)subview {
//    [self addDirectionNotification];
//}
//
//- (void)willRemoveSubview:(UIView *)subview {
//    [self removeNotification];
//}
//
//- (void)didMoveToSuperview {
//    if (!self.superview) {
//        [self hideAnimated:YES];
//    }
//}

#pragma mark - Methods
+ (void)hideLoadingForView:(UIView *)view animated:(BOOL)animated {
    FYLoadingAnimation* animationView = [self loadingForView:view];
    [animationView hideAnimated:animated];
}

- (void)showAnimated:(BOOL)animated {
    [self.attachView addSubview:self];
}

- (void)hideAnimated:(BOOL)animated {
    [self removeFromSuperview];
}

#pragma mark - tools
+ (FYLoadingAnimation*)loadingForView:(UIView*)view {
    FYLoadingAnimation* animationView;
    for (UIView* subView in view.subviews) {
        if ([subView isKindOfClass:[FYLoadingAnimation class]]) {
            animationView = (FYLoadingAnimation*)subView;
            break;
        }
    }
    
    return animationView;
}

#pragma mark - notif
- (void)addDirectionNotification {
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(OrientationDidChange:)name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
}

- (void)removeNotification {
    [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)OrientationDidChange:(NSNotification*)noti {
    UIDeviceOrientation interfaceOrientation = [UIDevice currentDevice].orientation;
    float angle = 0;
    
    switch (interfaceOrientation) {
        case UIDeviceOrientationPortrait: {
            switch (_orient) {
                case UIDeviceOrientationLandscapeLeft: {
                    angle = M_PI_2;
                }
                    break;
                case UIDeviceOrientationLandscapeRight: {
                    angle = -M_PI_2;
                }
                    break;
                case UIDeviceOrientationPortraitUpsideDown: {
                    angle = M_PI;
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
        case UIDeviceOrientationLandscapeLeft: {
            switch (_orient) {
                case UIDeviceOrientationPortrait: {
                    angle = -M_PI_2;
                }
                    break;
                case UIDeviceOrientationLandscapeRight: {
                    angle = -M_PI;
                }
                    break;
                case UIDeviceOrientationPortraitUpsideDown: {
                    angle = M_PI_2;
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
        case UIDeviceOrientationLandscapeRight: {
            switch (_orient) {
                case UIDeviceOrientationLandscapeLeft: {
                    angle = M_PI;
                }
                    break;
                case UIDeviceOrientationPortraitUpsideDown: {
                    angle = -M_PI_2;
                }
                    break;
                case UIDeviceOrientationPortrait: {
                    angle = M_PI_2;
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
        case UIDeviceOrientationPortraitUpsideDown: {
            switch (_orient) {
                case UIDeviceOrientationLandscapeLeft: {
                    angle = -M_PI_2;
                }
                    break;
                case UIDeviceOrientationLandscapeRight: {
                    angle = M_PI_2;
                }
                    break;
                case UIDeviceOrientationPortrait: {
                    angle = M_PI;
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
            
        default:
            break;
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        self.transform = CGAffineTransformMakeRotation(angle);
        self.center = CGPointMake(CGRectGetWidth(self.attachView.frame) / 2, CGRectGetHeight(self.attachView.frame) / 2);
    } completion:^(BOOL finished) {
        [self setNeedsLayout];
    }];
}

#pragma mark - layout
- (void)layoutSubviews {
    switch (self.orient) {
        case UIDeviceOrientationPortrait: {
            self.backView.layer.shadowOffset = CGSizeMake(4, 4);
        }
            break;
        case UIDeviceOrientationLandscapeLeft: {
            self.backView.layer.shadowOffset = CGSizeMake(-4, 4);
        }
            break;
        case UIDeviceOrientationLandscapeRight: {
            self.backView.layer.shadowOffset = CGSizeMake(4, -4);
        }
            break;
        case UIDeviceOrientationFaceDown: {
            self.backView.layer.shadowOffset = CGSizeMake(-4, -4);
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - getter
- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] initWithFrame:({
            CGRect rect;
            rect.size.width = 150;
            rect.size.height = 150;
            rect.origin = CGPointMake(0, 0);
            rect;
        })];
        _backView.backgroundColor = UICOLOR_RGB(70, 70, 70);
        _backView.layer.cornerRadius = 8;
        _backView.layer.shadowOpacity = 0.5;
        _backView.layer.shadowOffset = CGSizeMake(4, 4);
    }
    return _backView;
}


@end
