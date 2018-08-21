//
//  FYPhotoModel.h
//  FYPhotoBrowser
//
//  Created by fyz on 2018/8/12.
//  Copyright © 2018年 com.fyz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// PNG， JPG， GIF， WebP

@interface FYPhotoModel : NSObject

@property (nonatomic, copy) NSURL* photoUrl;
@property (nonatomic, strong) UIImage* placeHolderImage;

- (instancetype)initWithImage:(UIImage*)image;
- (instancetype)initWithUrl:(NSURL*)url;
- (instancetype)initWithUrl:(NSURL*)url placeHolderImage:(UIImage*)hoderImage;

@end
