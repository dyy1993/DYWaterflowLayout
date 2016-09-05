# DYWaterflowLayout

==============
[![CocoaPods](http://img.shields.io/cocoapods/v/DYWaterflowLayout.svg?style=flat)](http://cocoapods.org/?q=DYWaterflowLayout)&nbsp;
[![CocoaPods](http://img.shields.io/cocoapods/p/DYWaterflowLayout.svg?style=flat)](http://cocoapods.org/?q=DYWaterflowLayout)&nbsp;


###简单的瀑布流布局

## <a id="Installation"></a> Installation【安装】

### From CocoaPods【使用CocoaPods】

```ruby
pod 'DYWaterflowLayout'
```

### Manually【手动导入】
- Drag all source files under floder `DYWaterflowLayout ` to your project.【将`DYWaterflowLayout`文件夹中的所有源代码拽入项目中】
- Import the main header file：`#import "DYWaterflowLayout.h"`【导入主头文件：`#import "DYWaterflowLayout.h"`】





##使用
#####创建布局
```objc
DYWaterflowLayout *layout = [[DYWaterflowLayout alloc] init];
layout.delegate = self;
UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    
```
#####实现代理
```objc
- (CGSize)waterflowLayout:(DYWaterflowLayout *)waterflowLayout heightForItemAtIndexPath:(NSIndexPath *)indexPath
{
  //返回对应图片的大小
   return [self.imageSizes[indexPath.item % 7] CGSizeValue];
}
    
```
Demo<br>
![](https://github.com/dyy1993/DYWaterflowLayout/raw/master/demo.gif)
