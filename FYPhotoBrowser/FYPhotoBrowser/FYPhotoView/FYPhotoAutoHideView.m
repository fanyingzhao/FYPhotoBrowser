//
//  FYPhotoAutoHideView.m
//  FYPhotoBrowser
//
//  Created by fyz on 2018/8/12.
//  Copyright © 2018年 com.fyz. All rights reserved.
//

#import "FYPhotoAutoHideView.h"

typedef NS_ENUM(NSUInteger, PhotoResponseType) {
    PhotoResponseTypeUnidentified,       // 未识别
    PhotoResponseTypeScrollView,   // scrllview 响应
    PhotoResponseTypeSelf,         // 本身响应
    PhotoResponseTypeExtern,       // 外部响应
};

@interface FYPhotoAutoHideView()
@property (nonatomic) CGRect originFrame;
@property (nonatomic) PhotoResponseType responseType;     // 当前响应事件的类型
@end

@implementation FYPhotoAutoHideView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _originFrame = frame;
    }
    return self;
}

#pragma mark - Override
- (void)panGestureRecognizerHandler:(UIPanGestureRecognizer*)panGestureRecognizer {
    CGPoint translation = [panGestureRecognizer translationInView:self];
    
    switch (panGestureRecognizer.state) {
        case UIGestureRecognizerStateBegan: {
            [self recognizerGestureRecognizer:translation];
        }
            break;
        case UIGestureRecognizerStateChanged: {
            // 如果没有识别出，则继续识别
            if (self.responseType == PhotoResponseTypeUnidentified) {
                // 继续识别
                [self recognizerGestureRecognizer:translation];
            }
            
            if (self.responseType != PhotoResponseTypeSelf) {
                return;
            }

            CGPoint newCenter = CGPointMake(self.center.x + translation.x, self.center.y + translation.y);
            self.center = newCenter;

            [panGestureRecognizer setTranslation:CGPointZero inView:self];
        }
            break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateFailed:
        case UIGestureRecognizerStateCancelled: {
            [self handleGestureRecognizerEnd:self.frame];
            
            self.externShouldScroll = YES;
            self.scrollView.scrollEnabled = YES;
            self.responseType = PhotoResponseTypeUnidentified;
        }
            break;
        default:
            break;
    }
}

#pragma mark - Private
- (void)handleGestureRecognizerEnd:(CGRect)frame {
        // 到达边界自动消失
//        if (CGRectGetMidY(frame) > self.bounds.size.height / 2) {
//            if (CGRectGetMinY(frame) > self.bounds.size.height / 3) {
//                // 消失
//                return;
//            }
//        }else {
//            if (CGRectGetMaxY(frame) > self.bounds.size.height / 3) {
//                // 消失
//                return;
//            }
//        }
        
    // 位置重置
    [self resetFrame];
}

// 状态检测，判断要滚动的是谁
- (PhotoResponseType)getWillResponseEventView:(CGPoint)translation {
    if (translation.x == 0)
        return PhotoResponseTypeUnidentified;
    
    if (self.zoom)
        return PhotoResponseTypeScrollView;
    
    BOOL isHornScroll = ABS(translation.y) < ABS(translation.x);
    if (!isHornScroll) {
        return PhotoResponseTypeSelf;
    }
    
    if (self.scrollView.zoomScale > 1) {
        if (self.scrollView.contentOffset.x != 0 && [self getRealContentSize].width - self.scrollView.contentOffset.x != self.scrollView.bounds.size.width) {
            return PhotoResponseTypeScrollView;
        }else {
            // 边缘判断
            if (self.scrollView.contentOffset.x == 0) {
                if (translation.x < 0)
                    return PhotoResponseTypeScrollView;
                else if (translation.x > 0) {
                    if (self.leftIsExist)
                        return PhotoResponseTypeExtern;
                    else
                        return PhotoResponseTypeSelf;
                }
            }
            
            if ([self getRealContentSize].width - self.scrollView.contentOffset.x == self.scrollView.bounds.size.width) {
                if (translation.x > 0)
                    return PhotoResponseTypeScrollView;
                else if (translation.x < 0) {
                    if (self.rightIsExist)
                        return PhotoResponseTypeExtern;
                    else
                        return PhotoResponseTypeSelf;
                }
            }
        }
    }

    if (translation.x > 0 && self.leftIsExist) {
        return PhotoResponseTypeExtern;
    }else if (translation.x < 0 && self.rightIsExist) {
        return PhotoResponseTypeExtern;
    }
    
    return PhotoResponseTypeSelf;
}

- (void)recognizerGestureRecognizer:(CGPoint)translation {
    self.responseType = [self getWillResponseEventView:translation];
    switch (self.responseType) {
        case PhotoResponseTypeSelf:
            self.externShouldScroll = NO;
            self.scrollView.scrollEnabled = NO;
            break;
        case PhotoResponseTypeScrollView:
            self.externShouldScroll = NO;
            self.scrollView.scrollEnabled = YES;
            break;
        case PhotoResponseTypeExtern:
            self.scrollView.scrollEnabled = NO;
            self.externShouldScroll = YES;
            break;
        default:
            break;
    }
}

- (void)resetFrame {
    [UIView animateWithDuration:0.3f animations:^{
        self.frame = self.originFrame;
    }];
}

#pragma mark - Getter and Setter


@end
