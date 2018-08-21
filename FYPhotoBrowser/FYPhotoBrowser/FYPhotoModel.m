//
//  FYPhotoModel.m
//  FYPhotoBrowser
//
//  Created by fyz on 2018/8/12.
//  Copyright © 2018年 com.fyz. All rights reserved.
//

#import "FYPhotoModel.h"

@interface FYPhotoModel()
@end

@implementation FYPhotoModel

#pragma mark - Init
- (instancetype)initWithImage:(UIImage *)image {
    if (self = [super init]) {
        
    }
    return self;
}

- (instancetype)initWithUrl:(NSURL *)url {
    return [self initWithUrl:url placeHolderImage:nil];
}

- (instancetype)initWithUrl:(NSURL *)url placeHolderImage:(UIImage *)hoderImage {
    if (self = [super init]) {
        self.photoUrl = url;
        self.placeHolderImage = hoderImage;
    }
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

@end
