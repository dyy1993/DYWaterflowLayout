//
//  DYWaterflowLayout.h
//  DYWaterflowLayout
//
//  Created by yang on 16/9/2.
//  Copyright © 2016年 yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DYWaterflowLayout;

@protocol DYWaterflowLayoutDelegate <NSObject>
@required
- (CGSize)waterflowLayout:(DYWaterflowLayout *)waterflowLayout heightForItemAtIndexPath:(NSIndexPath *)indexPath;

@optional
- (CGFloat)columnCountInWaterflowLayout:(DYWaterflowLayout *)waterflowLayout;
- (CGFloat)columnMarginInWaterflowLayout:(DYWaterflowLayout *)waterflowLayout;
- (CGFloat)rowMarginInWaterflowLayout:(DYWaterflowLayout *)waterflowLayout;
- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(DYWaterflowLayout *)waterflowLayout;
@end

@interface DYWaterflowLayout : UICollectionViewLayout

@property (nonatomic, weak) id<DYWaterflowLayoutDelegate> delegate;
@end
