//
//  FYPhotoView.h
//  FYPhotoBrowser
//
//  Created by fyz on 2018/8/12.
//  Copyright © 2018年 com.fyz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FYPhotoModel, FYPhotoScrollView, FYPhotoView;

@protocol FYPhotoViewDelegate <NSObject>
// photoView 是否自己响应了触摸事件
- (void)photoView:(FYPhotoView*)photoView didOutterShouldScroll:(BOOL)externShouldScroll;
@end

@interface FYPhotoView : UIView {
    BOOL _edit;
    BOOL _zoom;
    BOOL _externShouldScroll;
}

@property (nonatomic, strong) UIImageView* imageView;

@property (nonatomic, weak) id<FYPhotoViewDelegate> delegate;

@property (nonatomic) BOOL externShouldScroll;          // 外部是否应该滚动
@property (nonatomic, getter=isZoom) BOOL zoom;         // 当前是否是放大模式
@property (nonatomic, strong) FYPhotoModel* imageModel;

@property (nonatomic ,strong) UIVisualEffectView * effectView;  // 模糊

// 手势
@property (nonatomic, strong) UIPanGestureRecognizer* panGestureRecognizer;

// 缩放
@property (nonatomic, strong) FYPhotoScrollView* scrollView;
//默认是屏幕的宽和高
@property (assign, nonatomic) CGFloat imageNormalWidth; // 图片未缩放时宽度
@property (assign, nonatomic) CGFloat imageNormalHeight; // 图片未缩放时高度

- (CGSize)getRealContentSize;   // 得到实时的内容大小
- (void)reset;                  // 重置

@end

@interface FYPhotoScrollView : UIScrollView
@end

