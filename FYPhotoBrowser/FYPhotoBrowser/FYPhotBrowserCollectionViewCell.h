//
//  FYPhotBrowserCollectionViewCell.h
//  FYPhotoBrowser
//
//  Created by fyz on 2018/8/12.
//  Copyright © 2018年 com.fyz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FYPhotBrowserCollectionViewCell, FYPhotoModel;

@protocol FYPhotBrowserCollectionViewCellDelegate <NSObject>
- (void)photoBrowser:(FYPhotBrowserCollectionViewCell*)cell imageViewEditDidChnaged:(BOOL)isEdit;
@end

@class FYPhotoView;

@interface FYPhotBrowserCollectionViewCell : UICollectionViewCell
@property (nonatomic, weak) id<FYPhotBrowserCollectionViewCellDelegate> delegate;
@property (nonatomic, assign) Class photoViewClass;
@property (nonatomic, strong, readonly) FYPhotoView* photoView;
@property (nonatomic, strong) FYPhotoModel* model;

@end
