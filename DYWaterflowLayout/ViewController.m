//
//  ViewController.m
//  DYWaterflowLayout
//
//  Created by yang on 16/9/2.
//  Copyright © 2016年 yang. All rights reserved.
//

#import "ViewController.h"
#import "DYWaterflowLayout.h"
#import <MJRefresh.h>
#import "DYImageCell.h"
@interface ViewController ()<UICollectionViewDataSource,DYWaterflowLayoutDelegate>

@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) NSArray *imageSizes;
@property (nonatomic, assign) NSInteger items;
@property (nonatomic, weak) UICollectionView *collectionView;
@end

@implementation ViewController

- (NSArray *)imageSizes {
    if (!_imageSizes) {
        _imageSizes = @[
                       [NSValue valueWithCGSize:CGSizeMake(550, 681)],
                       [NSValue valueWithCGSize:CGSizeMake(404, 621)],
                       [NSValue valueWithCGSize:CGSizeMake(880, 580)],
                       [NSValue valueWithCGSize:CGSizeMake(550, 825)],
                       [NSValue valueWithCGSize:CGSizeMake(540, 816)],
                       [NSValue valueWithCGSize:CGSizeMake(500, 749)],
                       [NSValue valueWithCGSize:CGSizeMake(404, 605)]
                       ];
    }
    return _imageSizes;
}
- (NSArray *)images
{
    if (!_images) {
        _images = @[
                       @"meimei1.jpg",
                       @"meimei2.jpg",
                       @"meimei3.jpg",
                       @"meimei4.jpg",
                       @"meimei5.jpg",
                       @"meimei6.jpg",
                       @"meimei7.jpg"
                       ];
    }
    return _images;
}

static NSString * const DYImageId = @"imageCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupLayout];
    
    [self setupRefresh];
}

- (void)setupRefresh
{
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewShops)];
    [self.collectionView.mj_header beginRefreshing];
    
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreShops)];
    self.collectionView.mj_footer.hidden = YES;
}

- (void)loadNewShops
{
    

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.items = 10;
        
        [self.collectionView reloadData];
        
        [self.collectionView.mj_header endRefreshing];
    });
}

- (void)loadMoreShops
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.items += 10;
        
        [self.collectionView reloadData];
        
        [self.collectionView.mj_footer endRefreshing];
    });
}

- (void)setupLayout
{

    DYWaterflowLayout *layout = [[DYWaterflowLayout alloc] init];
    layout.delegate = self;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.dataSource = self;
    [self.view addSubview:collectionView];
      [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([DYImageCell class]) bundle:nil] forCellWithReuseIdentifier:DYImageId];
    
    self.collectionView = collectionView;
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    self.collectionView.mj_footer.hidden = self.items == 0;
    return self.items;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DYImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DYImageId forIndexPath:indexPath];
    
    cell.imageV.image = [UIImage imageNamed:self.images[indexPath.item % 7]] ;
    
    return cell;
}

#pragma mark - <DYWaterflowLayoutDelegate>
- (CGSize)waterflowLayout:(DYWaterflowLayout *)waterflowLayout heightForItemAtIndexPath:(NSIndexPath *)indexPath
{
  
    
   return [self.imageSizes[indexPath.item % 7] CGSizeValue];
   

}

- (CGFloat)rowMarginInWaterflowLayout:(DYWaterflowLayout *)waterflowLayout
{
    return 10;
}

- (CGFloat)columnCountInWaterflowLayout:(DYWaterflowLayout *)waterflowLayout
{
    return 2;
}

- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(DYWaterflowLayout *)waterflowLayout
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

@end
