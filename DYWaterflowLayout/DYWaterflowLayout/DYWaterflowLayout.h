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
/**
 *   Asks the delegate for the size of the specified item’s cell.
 *
 *  @param waterflowLayout The layout object requesting the information.
 *  @param indexPath       The index path of the item.
 *
 *  @return The original size of the specified item. Both width and height must be greater than 0.
 */
- (CGSize)waterflowLayout:(DYWaterflowLayout *)waterflowLayout heightForItemAtIndexPath:(NSIndexPath *)indexPath;

@optional
/**
 *   Asks the delegate for the column count of the layout.
 *
 *  @param waterflowLayout The layout object requesting the information.
 *
 *  @return column count of the layout.    Default is 2 if not implemented
 */
- (CGFloat)columnCountInWaterflowLayout:(DYWaterflowLayout *)waterflowLayout;

/**
 *  Asks the delegate for the column margin of the layout.
 *
 *  @param waterflowLayout The layout object requesting the information.
 *
 *  @return The layout column margin.      Default is 10 if not implemented
 */
- (CGFloat)columnMarginInWaterflowLayout:(DYWaterflowLayout *)waterflowLayout;

/**
 *  Asks the delegate for the row margin of the layout.
 *
 *  @param waterflowLayout The layout object requesting the information.
 *
 *  @return The layout row margin.          Default is 10 if not implemented
 */
- (CGFloat)rowMarginInWaterflowLayout:(DYWaterflowLayout *)waterflowLayout;

/**
 *  Asks the delegate for the edgeInsets of the layout.
 *
 *  @param waterflowLayout The layout object requesting the information.
 *
 *  @return The layout edgeInsets.          Default is {10, 10, 10, 10} if not implemented
 */
- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(DYWaterflowLayout *)waterflowLayout;
@end

@interface DYWaterflowLayout : UICollectionViewLayout

@property (nonatomic, weak) id<DYWaterflowLayoutDelegate> delegate;
@end
