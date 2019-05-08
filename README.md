# TestLayer
> ####前言
> 开发中经常需要遇到对某个view的一个角或几个角进行圆角处理，而且由于使用Autolayout约束时frame可能会动态变化，每次都要单独写很多代码，现在写个分类简化这种操作

[GitHub 代码](https://github.com/lonely4flow/TestLayer)

参考：
* [iOS NS_OPTIONS 位移枚举](https://www.jianshu.com/p/9810944d6d47)
* [NS_OPTIONS的用法](https://www.jianshu.com/p/d68944338faf)
*  [ObjC中_cmd的用法](https://www.jianshu.com/p/fdb1bc445266)
* [View的任意圆角和边框](https://www.jianshu.com/p/2b202f15ad02)
* [iOS视图切割圆角](https://www.jianshu.com/p/61136f3717a2)
* [iOS高性能切圆角工具-适用Autolayout，frame布局](https://blog.csdn.net/weixin_34351321/article/details/86871131)
* [iOS 给layer同时添加mask和shadow](https://www.jianshu.com/p/0754833349a1)
*[UIBezierPath详解](https://www.jianshu.com/p/4e8fdfb9e33f)


----
知识点：
1、在`-(void)layoutSubviews{xxx}`里获取bounds适配frame和autolayout变化的情况，同时缓存bounds减少重复操作
2、runtime方式在分类中实现`getter ` 、`setter`
3、使用`UIBezierPath `、`CAShapeLayer`设置UIView的layer.mask进行切角
4、

![Simulator Screen Shot - iPhone Xʀ - 2019-04-19 at 16.24.57.png](https://upload-images.jianshu.io/upload_images/1605558-35ffc220f564e166.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

 ![Simulator Screen Shot - iPhone Xʀ - 2019-04-19 at 18.58.22.png](https://upload-images.jianshu.io/upload_images/1605558-f5f7616c63cd44df.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
