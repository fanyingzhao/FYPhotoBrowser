//
//  FYLoadingView.h
//  FFKit
//
//  Created by fan on 17/3/7.
//  Copyright © 2017年 fan. All rights reserved.
//

#import <UIKit/UIKit.h>


@class FYLoadingAnimation, FYBallAnimation, FYCommonAnimation;
typedef void (^FYLoadingCompletionBlock)(FYLoadingAnimation* loadingView);

@interface FYLoadingAnimation : UIView {
    CGFloat _progress;
}

@property (nonatomic, copy) FYLoadingCompletionBlock completionBlock;
@property (nonatomic, weak) UIView* attachView;
@property (nonatomic, strong) UIView* backView;
@property (nonatomic, assign) CGFloat progress;

+ (instancetype)showLoadingForView:(UIView*)view animated:(BOOL)animated;
+ (instancetype)showLoadingForView:(UIView*)view class:(Class)class animated:(BOOL)animated;
+ (void)hideLoadingForView:(UIView*)view animated:(BOOL)animated;

- (instancetype)initWithView:(UIView*)view;

- (void)showAnimated:(BOOL)animated;
- (void)hideAnimated:(BOOL)animated;

@end
