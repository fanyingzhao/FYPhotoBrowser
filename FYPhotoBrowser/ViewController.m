//
//  ViewController.m
//  FYPhotoBrowser
//
//  Created by fyz on 2018/8/12.
//  Copyright © 2018年 com.fyz. All rights reserved.
//

#import "ViewController.h"
#import "FYPhotoBrowser/FYPhotoBrowserViewController.h"
#import "FYPhotoModel.h"

@interface ViewController ()
@property (nonatomic, strong) UIButton* btn;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.view addSubview:self.btn];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Events
- (void)btnClick:(UIButton*)sender {
    FYPhotoBrowserViewController* vc = [[FYPhotoBrowserViewController alloc] init];
    
    NSArray* urls = @[
                      @"http://ww2.sinaimg.cn/bmiddle/9ecab84ejw1emgd5nd6eaj20c80c8q4a.jpg",
                      @"http://ww2.sinaimg.cn/bmiddle/642beb18gw1ep3629gfm0g206o050b2a.gif",
                      @"http://ww4.sinaimg.cn/bmiddle/9e9cb0c9jw1ep7nlyu8waj20c80kptae.jpg",
                      @"http://ww3.sinaimg.cn/bmiddle/8e88b0c1gw1e9lpr1xydcj20gy0o9q6s.jpg",
                      @"http://ww2.sinaimg.cn/bmiddle/8e88b0c1gw1e9lpr2n1jjj20gy0o9tcc.jpg",
                      @"http://ww4.sinaimg.cn/bmiddle/8e88b0c1gw1e9lpr4nndfj20gy0o9q6i.jpg",
                      @"http://ww3.sinaimg.cn/bmiddle/8e88b0c1gw1e9lpr57tn9j20gy0obn0f.jpg",
                      @"http://ww2.sinaimg.cn/bmiddle/677febf5gw1erma104rhyj20k03dz16y.jpg",
                      @"http://ww4.sinaimg.cn/bmiddle/677febf5gw1erma1g5xd0j20k0esa7wj.jpg",
                      @"http://img.zcool.cn/community/0117e2571b8b246ac72538120dd8a4.jpg@1280w_1l_2o_100sh.jpg",
                      @"http://img07.tooopen.com/images/20170316/tooopen_sy_201956178977.jpg",
                      @"http://www.qqma.com/imgpic2/cpimagenew/2018/4/5/6e1de60ce43d4bf4b9671d7661024e7a.jpg",
                      @"http://img.zcool.cn/community/011a5859ac137ea8012028a92fc78a.jpg@1280w_1l_2o_100sh.jpg",
                      @"http://img.zcool.cn/community/01c60259ac0f91a801211d25904e1f.jpg@1280w_1l_2o_100sh.jpg",
                      @"http://pic.58pic.com/58pic/15/57/84/70H58PICCJt_1024.jpg",
                      @"http://img.zcool.cn/community/012cb757939a8e0000018c1b7482be.jpg@1280w_1l_2o_100sh.png",
                      @"http://img.zcool.cn/community/01021657d55c8d0000012e7e9c4676.jpg@1280w_1l_2o_100sh.png",
                      @"http://img.zcool.cn/community/01b23d59ac1384a801211d25cd596b.jpg@3000w_1l_2o_100sh.jpg"];
    
    NSMutableArray* array = [NSMutableArray array];
    for (NSString* url in urls) {
        FYPhotoModel* model = [[FYPhotoModel alloc] initWithUrl:[NSURL URLWithString:url]];
        model.placeHolderImage = [UIImage imageNamed:@"1.jpg"];
        [array addObject:model];
    }
    vc.photos = [array copy];;
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - Getter and Setter
- (UIButton *)btn {
    if (!_btn) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.frame = ({
            CGRect rect = CGRectZero;
            rect.origin.x = 100;
            rect.origin.y = 100;
            rect.size.width = 100;
            rect.size.height = 100;
            rect;
        });
        _btn.backgroundColor = [UIColor orangeColor];
        [_btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}
@end
