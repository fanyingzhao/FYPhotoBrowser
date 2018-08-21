//
//  FYPhotoBrowserViewController.m
//  FYPhotoBrowser
//
//  Created by fyz on 2018/8/12.
//  Copyright © 2018年 com.fyz. All rights reserved.
//

#import "FYPhotoBrowserViewController.h"
#import "FYPhotBrowserCollectionViewCell.h"
#import "FYPhotoBrowserCollectionView.h"
#import "FYPhotoAutoHideView.h"

@interface FYPhotoBrowserViewController () <UIScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, FYPhotBrowserCollectionViewCellDelegate>
@property (nonatomic, strong) FYPhotoBrowserCollectionView* collectionView;

@end

@implementation FYPhotoBrowserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.collectionView];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Methods
- (void)addImageModel:(FYPhotoModel *)imageModel index:(NSInteger)index {
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.photos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    Class class = [FYPhotoAutoHideView class];
    if (self.delegate && [self.delegate respondsToSelector:@selector(photoBrowser:imageViewClassWithIndex:)]) {
        Class temp = [self.delegate photoBrowser:self imageViewClassWithIndex:indexPath.row];
        if ([temp isKindOfClass:[FYPhotoView class]]) {
            class = temp;
        }
    }
    
    FYPhotBrowserCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([FYPhotBrowserCollectionViewCell class]) forIndexPath:indexPath];
    cell.backgroundColor = [UIColor orangeColor];
    cell.photoViewClass = class;
    ((FYPhotoAutoHideView*)cell.photoView).leftIsExist = indexPath.row ? YES : NO;
    ((FYPhotoAutoHideView*)cell.photoView).rightIsExist = self.photos.count - indexPath.row > 1 ? YES : NO;
    cell.delegate = self;
    cell.model = self.photos[indexPath.row];
    if (self.delegate && [self.delegate respondsToSelector:@selector(photoBrowser:configCell:indexPath:)]) {
        [self.delegate photoBrowser:self configCell:cell indexPath:indexPath];
    }
    
    return cell;
}

#pragma mark - Private

#pragma mark - FYPhotBrowserCollectionViewCellDelegate
- (void)photoBrowser:(FYPhotBrowserCollectionViewCell *)cell imageViewEditDidChnaged:(BOOL)isEdit {
    self.collectionView.scrollEnabled = isEdit;
}

#pragma mark - Getter and Setter
- (FYPhotoBrowserCollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 0.0f;
        layout.minimumInteritemSpacing = 0.0f;
        layout.itemSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height);
        
        _collectionView = [[FYPhotoBrowserCollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.backgroundColor = [UIColor orangeColor];
        _collectionView.showsVerticalScrollIndicator = false;
        _collectionView.showsHorizontalScrollIndicator = false;
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.bounces = false;
        _collectionView.alwaysBounceVertical = NO;
        [_collectionView registerClass:[FYPhotBrowserCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([FYPhotBrowserCollectionViewCell class])];
    }
    return _collectionView;
}
@end
