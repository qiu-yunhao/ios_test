# ios_test
## Day1 计时器
### 知识点：
* AutoLayout
* UITableView
## Day2 花式button
### 知识点：
* UISegemnt
* 手势识别
* 动画效果
### 问题：
* 目前的动画效果不能叠加，也就是说，仅在单次操作中有效，换手势后无效
* 不会实现长按拖动，用的动画效果实现的，有点杀鸡焉用牛刀
* 不会刷新视图/视图刷新无效？
### 体验：
* extension真滴牛逼，在维护代码和给编程人员的扩展性方面简直不要太爽，告别了Android不断封装的时代
* swift在底层动画上的封装很到位，初学上手很快，不像Android要了解很多知识

## Day3 番茄钟
### 进度
* 实现倒计时
* 实现圆形进度条
### 知识点：
* 多线程
* 自定义View 
### 问题
* 对动画属性完全不理解
* UIView.animate 和 CABAsicAnimate搞不明白
* 收回我昨天对swift的赞扬，都不是啥好东西
* ios无法禁用home键，怎么实现专注模式

## Day4 轮播图
### 实现方式
* scrollerView
* collectionView
### 知识点
* 自定义view
* collectionView相关子item的设置
* UICollectionViewFlowLayout, UICollectionViewCompositionalLayout相关的知识


## Day5 课表仿写

注意事项：
UIScrollView使用autoLayout进行布局时，最后要将contentView的trailing与最后一个子视图的trailing联系起来，这样才能自动计算contentSize的大小而实现滑动


## Day6 图文混排

