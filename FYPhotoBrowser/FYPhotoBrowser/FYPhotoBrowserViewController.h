    //
//  FYPhotoBrowserViewController.h
//  FYPhotoBrowser
//
//  Created by fyz on 2018/8/12.
//  Copyright © 2018年 com.fyz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FYPhotoModel, FYPhotoView, FYPhotoBrowserViewController, FYPhotBrowserCollectionViewCell;

@protocol FYPhotoBrowserViewControllerDelegate <NSObject>
@optional
- (Class)photoBrowser:(FYPhotoBrowserViewController*)controller imageViewClassWithIndex:(NSInteger)index;
- (Class)photoBrowser:(FYPhotoBrowserViewController*)controller loadingViewClassWithIndex:(NSInteger)index;

- (void)photoBrowser:(FYPhotoBrowserViewController*)controller configCell:(FYPhotBrowserCollectionViewCell*)cell indexPath:(NSIndexPath*)indexPath;
- (void)photoBrowser:(FYPhotoBrowserViewController*)controller willShow:(FYPhotBrowserCollectionViewCell*)cell;
@end

@interface FYPhotoBrowserViewController : UIViewController
@property (nonatomic, weak) id<FYPhotoBrowserViewControllerDelegate> delegate;
@property (nonatomic, strong) NSArray* photos;

- (void)addImageModel:(FYPhotoModel*)imageModel index:(NSInteger)index;

@end
