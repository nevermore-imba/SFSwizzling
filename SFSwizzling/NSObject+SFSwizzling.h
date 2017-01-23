//
//  NSObject+SFSwizzling.h
//  SFSwizzling
//
//  Created by Axe on 2017/1/22.
//  Copyright © 2017年 Nevermore. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (SFSwizzling)

+ (void)sf_swizzleClassMethodWithOriginalSelector:(SEL)originalSelector withSwizzledSelector:(SEL)swizzledSelector error:(NSError * _Nullable __autoreleasing *)error;

+ (void)sf_swizzleInstanceMethodWithOriginalSelector:(SEL)originalSelector withSwizzledSelector:(SEL)swizzledSelector error:(NSError * _Nullable __autoreleasing *)error;
@end

NS_ASSUME_NONNULL_END
