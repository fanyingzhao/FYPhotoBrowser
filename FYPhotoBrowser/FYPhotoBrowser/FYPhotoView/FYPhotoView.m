//
//  FYPhotoView.m
//  FYPhotoBrowser
//
//  Created by fyz on 2018/8/12.
//  Copyright © 2018年 com.fyz. All rights reserved.
//

#import "FYPhotoView.h"
#import "UIImageView+WebCache.h"
#import "FYPhotoModel.h"
#import "FYBallAnimation.h"
#import "FYCircleAnimation.h"

@implementation FYPhotoScrollView
#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}
@end

@interface FYPhotoView() <UIScrollViewDelegate>
@property (nonatomic, strong) Class loadingViewClass;
@end

@implementation FYPhotoView

#pragma mark - Init
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addGestureRecognizer:self.panGestureRecognizer];
        [self addSubview:self.scrollView];
        [self.scrollView addSubview:self.imageView];
        [self.imageView addSubview:self.effectView];
        self.externShouldScroll = YES;
        
        self.loadingViewClass = [FYCircleAnimation class];
    }
    return self;
}

#pragma mark - Methods
- (CGSize)getRealContentSize {
    return CGSizeMake(self.scrollView.zoomScale * self.scrollView.bounds.size.width, self.scrollView.zoomScale * self.scrollView.bounds.size.height);
}

- (void)reset {
    self.scrollView.zoomScale = 1;
}

#pragma mark - Override
- (void)layoutSubviews {
    
}

#pragma mark - Events
- (void)panGestureRecognizerHandler:(UIPanGestureRecognizer*)panGestureRecognizer {
    switch (panGestureRecognizer.state) {
        case UIGestureRecognizerStateBegan: {

        }
            break;
        case UIGestureRecognizerStateChanged: {
           
        }
            break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateFailed:
        case UIGestureRecognizerStateCancelled: {
           
        }
            break;
        default:
            break;
    }
}

#pragma mark - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

//开始缩放
- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view{
    self.zoom = YES;
}
//结束缩放
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale{
    self.zoom = NO;
}

//缩放中
- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    // 延中心点缩放
//    CGFloat imageScaleWidth = scrollView.zoomScale * self.imageNormalWidth;
//    CGFloat imageScaleHeight = scrollView.zoomScale * self.imageNormalHeight;
//
//    CGFloat imageX = 0;
//    CGFloat imageY = 0;
//    imageX = floorf((self.frame.size.width - imageScaleWidth) / 2.0);
//    imageY = floorf((self.frame.size.height - imageScaleHeight) / 2.0);
//    self.imageView.frame = CGRectMake(imageX, imageY, imageScaleWidth, imageScaleHeight);
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {

}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {

}

#pragma mark - Private
- (void)shouldResponseTouchEvent {
    if (self.delegate && [self.delegate respondsToSelector:@selector(photoView:didOutterShouldScroll:)])
        [self.delegate photoView:self didOutterShouldScroll:_externShouldScroll];
}

#pragma mark - Getter and Setter
- (void)setImageModel:(FYPhotoModel *)imageModel {
    _imageModel = imageModel;
    
    if (!imageModel.photoUrl)
        return;
    
    // 取消前面的重用
    self.effectView.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    [FYLoadingAnimation hideLoadingForView:self animated:YES];
    
    FYLoadingAnimation* animationView = [FYLoadingAnimation showLoadingForView:self class:self.loadingViewClass animated:YES];
    [self.imageView sd_setImageWithURL:imageModel.photoUrl placeholderImage:imageModel.placeHolderImage options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        dispatch_async(dispatch_get_main_queue(), ^{
            animationView.progress = receivedSize / (float)expectedSize;
        });
    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        [FYLoadingAnimation hideLoadingForView:self animated:YES];
        [UIView animateWithDuration:0.2 animations:^{
            self.effectView.effect = nil;
        }];
    }];
}

- (UIPanGestureRecognizer *)panGestureRecognizer {
    if (!_panGestureRecognizer) {
        _panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognizerHandler:)];
    }
    return _panGestureRecognizer;
}

- (FYPhotoScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[FYPhotoScrollView alloc] initWithFrame:self.bounds];
        _scrollView.minimumZoomScale = 1.0f;
        _scrollView.maximumZoomScale = 2.0f;
        _scrollView.delegate = self;
        _scrollView.bounces = NO;
        _scrollView.decelerationRate = UIScrollViewDecelerationRateFast;
    }
    return _scrollView;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _imageView.backgroundColor = [UIColor blueColor];
    }
    return _imageView;
}

- (BOOL)isEdit {
    return _edit;
}

- (void)setEdit:(BOOL)edit {
    [self willChangeValueForKey:@"edit"];
    _edit = edit;
    [self didChangeValueForKey:@"edit"];
}

- (BOOL)isZoom {
    return _zoom;
}

- (void)setZoom:(BOOL)zoom {
    [self willChangeValueForKey:@"zoom"];
    _zoom = zoom;
    [self didChangeValueForKey:@"zoom"];
}

- (BOOL)externShouldScroll {
    return _externShouldScroll;
}

- (void)setExternShouldScroll:(BOOL)externShouldScroll {
    [self willChangeValueForKey:@"externShouldScroll"];
    _externShouldScroll = externShouldScroll;
    [self didChangeValueForKey:@"externShouldScroll"];
    
    [self shouldResponseTouchEvent];
}

- (UIVisualEffectView *)effectView {
    if (!_effectView) {
        UIBlurEffect * blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        _effectView = [[UIVisualEffectView alloc] initWithEffect:blur];
        _effectView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    }
    return _effectView;
}

@end
