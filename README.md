# SFSwizzling

利用Objective-C的运行时特性，交换两个方法的实现。此类就是对runtime swizzling的封装，为NSObject提供了一个类别，其中外部提供了两个接口：

1. + sf_swizzleClassMethodWithOriginalSelector: withSwizzledSelector: error:
2. + sf_swizzleInstanceMethodWithOriginalSelector: withSwizzledSelector: error:

接口1，是针对类方法的交换；接口2，是针对实例方法的交换。
