//
//  DYWaterflowLayout.m
//  DYWaterflowLayout
//
//  Created by yang on 16/9/2.
//  Copyright © 2016年 yang. All rights reserved.
//

#import "DYWaterflowLayout.h"

/**  Default column count */
static const NSInteger DYDefaultColumnCount = 2;
/** Default column margin */
static const CGFloat DYDefaultColumnMargin = 10;
/** Default row margin */
static const CGFloat DYDefaultRowMargin = 10;
/** Default edgeInsets */
static const UIEdgeInsets DYDefaultEdgeInsets = {10, 10, 10, 10};

@interface DYWaterflowLayout()

@property (nonatomic, strong) NSMutableArray *attrsArray;

@property (nonatomic, strong) NSMutableArray *columnHeights;

@property (nonatomic, assign) CGFloat contentHeight;

- (CGFloat)rowMargin;
- (CGFloat)columnMargin;
- (NSInteger)columnCount;
- (UIEdgeInsets)edgeInsets;
@end

@implementation DYWaterflowLayout

#pragma mark - data
- (CGFloat)rowMargin
{
    if ([self.delegate respondsToSelector:@selector(rowMarginInWaterflowLayout:)]) {
        return [self.delegate rowMarginInWaterflowLayout:self];
    } else {
        return DYDefaultRowMargin;
    }
}

- (CGFloat)columnMargin
{
    if ([self.delegate respondsToSelector:@selector(columnMarginInWaterflowLayout:)]) {
        return [self.delegate columnMarginInWaterflowLayout:self];
    } else {
        return DYDefaultColumnMargin;
    }
}

- (NSInteger)columnCount
{
    if ([self.delegate respondsToSelector:@selector(columnCountInWaterflowLayout:)]) {
        return [self.delegate columnCountInWaterflowLayout:self];
    } else {
        return DYDefaultColumnCount;
    }
}

- (UIEdgeInsets)edgeInsets
{
    if ([self.delegate respondsToSelector:@selector(edgeInsetsInWaterflowLayout:)]) {
        return [self.delegate edgeInsetsInWaterflowLayout:self];
    } else {
        return DYDefaultEdgeInsets;
    }
}

#pragma mark - lazy
- (NSMutableArray *)columnHeights
{
    if (!_columnHeights) {
        _columnHeights = [NSMutableArray array];
    }
    return _columnHeights;
}

- (NSMutableArray *)attrsArray
{
    if (!_attrsArray) {
        _attrsArray = [NSMutableArray array];
    }
    return _attrsArray;
}

/**
 * Initialize
 */
- (void)prepareLayout
{
    [super prepareLayout];
    
    self.contentHeight = 0;
    
    //  remove columnHeight
    [self.columnHeights removeAllObjects];
    for (NSInteger i = 0; i < self.columnCount; i++) {
        [self.columnHeights addObject:@(self.edgeInsets.top)];
    }
    
    // remove attrs
    [self.attrsArray removeAllObjects];
    
    // create Attributes of item
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (NSInteger i = 0; i < count; i++) {
      
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.attrsArray addObject:attrs];
    }
}


- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.attrsArray;
}

/**
 * return cell Attributes at IndexPath
 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
   
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
   
    CGFloat collectionViewW = self.collectionView.frame.size.width;
    
    // setup layoutAttributes frame
    CGFloat w = (collectionViewW - self.edgeInsets.left - self.edgeInsets.right - (self.columnCount - 1) * self.columnMargin) / self.columnCount;
    CGSize size = [self.delegate waterflowLayout:self heightForItemAtIndexPath:indexPath];
    CGFloat h = 0;
    if (size.width != 0) {
         h = w * size.height / size.width;
    }                                                                                              
    // find minColumnHeight
    NSInteger destColumn = 0;
    CGFloat minColumnHeight = [self.columnHeights[0] doubleValue];
    for (NSInteger i = 1; i < self.columnCount; i++) {
        
        CGFloat columnHeight = [self.columnHeights[i] doubleValue];
        
        if (minColumnHeight > columnHeight) {
            minColumnHeight = columnHeight;
            destColumn = i;
        }
    }
    
    CGFloat x = self.edgeInsets.left + destColumn * (w + self.columnMargin);
    CGFloat y = minColumnHeight;
    if (y != self.edgeInsets.top) {
        y += self.rowMargin;
    }
    attrs.frame = CGRectMake(x, y, w, h);
    
    // save min height column
    self.columnHeights[destColumn] = @(CGRectGetMaxY(attrs.frame));
    
   
    CGFloat columnHeight = [self.columnHeights[destColumn] doubleValue];
    if (self.contentHeight < columnHeight) {
        self.contentHeight = columnHeight;
    }
    return attrs;
}

- (CGSize)collectionViewContentSize
{

    return CGSizeMake(0, self.contentHeight + self.edgeInsets.bottom);
}
@end
