//
//  FYPhotBrowserCollectionViewCell.m
//  FYPhotoBrowser
//
//  Created by fyz on 2018/8/12.
//  Copyright © 2018年 com.fyz. All rights reserved.
//

#import "FYPhotBrowserCollectionViewCell.h"
#import "FYPhotoView/FYPhotoView.h"

@interface FYPhotBrowserCollectionViewCell()
@end

@implementation FYPhotBrowserCollectionViewCell

#pragma mark - Init
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

#pragma mark - Methods

#pragma mark - Private
- (void)reset {
    [self.photoView reset];
}

#pragma mark - Override
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"externShouldScroll"]) {
        BOOL edit = [change[@"new"] boolValue];
        if (self.delegate && [self.delegate respondsToSelector:@selector(photoBrowser:imageViewEditDidChnaged:)]) {
            [self.delegate photoBrowser:self imageViewEditDidChnaged:edit];
        }
    }else
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
}

#pragma mark - Getter and Setter
- (void)setPhotoViewClass:(Class)photoViewClass {
    if (_photoViewClass == photoViewClass)
        return;

#warning 优化
    _photoViewClass = photoViewClass;
    
    if (_photoView) {
        [_photoView removeFromSuperview];
        [_photoView removeObserver:self forKeyPath:@"externShouldScroll"];
    }
    _photoView = [[photoViewClass alloc] initWithFrame:({
        CGRect rect = CGRectZero;
        rect.origin.x = 0;
        rect.size.width = self.bounds.size.width - rect.origin.x * 2;
        rect.size.height = self.bounds.size.height;
        rect.origin.y = 0;
        rect;
    })];
    [_photoView reset];
    [_photoView addObserver:self forKeyPath:@"externShouldScroll" options:NSKeyValueObservingOptionNew context:nil];
    [self addSubview:_photoView];
}

- (FYPhotoModel *)model {
    return self.photoView.imageModel;
}

- (void)setModel:(FYPhotoModel *)model {
    self.photoView.imageModel = model;
    
    
    [self reset];
}

@end
