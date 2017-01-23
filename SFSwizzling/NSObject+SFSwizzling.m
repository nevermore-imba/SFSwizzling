//
//  NSObject+SFSwizzling.m
//  SFSwizzling
//
//  Created by Axe on 2017/1/22.
//  Copyright © 2017年 Nevermore. All rights reserved.
//

#import "NSObject+SFSwizzling.h"
#import <objc/runtime.h>

#define SFExceptionError(error, format, ...) \
    if ((error)) { \
        NSString *errorDescription = [NSString stringWithFormat:format, ##__VA_ARGS__]; \
        *error = [NSError errorWithDomain:NSCocoaErrorDomain code:-1 userInfo:@{NSLocalizedDescriptionKey:errorDescription}]; \
    }

@interface NSObject (_SFSwizzling)
+ (void)swizzlingMethodWithOriginalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector isClassMethod:(BOOL)isClassMethod;
@end

@implementation NSObject (_SFSwizzling)

+ (void)swizzlingMethodWithOriginalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector isClassMethod:(BOOL)isClassMethod {
    
    Class cls = NULL;

    if (isClassMethod) {
        cls = object_getClass(self);
    } else {
        cls = self;
    }

    Method originalMethod = isClassMethod ? class_getClassMethod(cls, originalSelector) : class_getInstanceMethod(cls, originalSelector);
    Method swizzledMethod = isClassMethod ? class_getClassMethod(cls, swizzledSelector) : class_getInstanceMethod(cls, swizzledSelector);

    /**
        1. 先尝试给原方法SEL添加IMP，为了避免原SEL没有实现IMP的情况
        2. 如果返回YES，添加成功，说明原SEL没有实现IMP，将原SEL的IMP替换到交换SEL的IMP
        3. 否则，添加失败，说明源SEL已经有IMP，直接将两个SEL的IMP交换即可。
     */
    BOOL addMethod = class_addMethod(cls, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));

    if (addMethod) {
        class_replaceMethod(cls, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}
@end

@implementation NSObject (SFSwizzling)

+ (void)sf_swizzleInstanceMethodWithOriginalSelector:(SEL)originalSelector withSwizzledSelector:(SEL)swizzledSelector error:(NSError *__autoreleasing  _Nullable *)error {

    Method originalMethod = class_getInstanceMethod(self, originalSelector);

    if (!originalMethod) {
        SFExceptionError(error, @"original method %@ not found for class %@ \n", NSStringFromSelector(originalSelector), [self class]);
        return;
    }

    Method swizzledMethod = class_getInstanceMethod(self, swizzledSelector);

    if (!swizzledMethod) {
        SFExceptionError(error, @"swizzled method %@ not found for class %@ \n", NSStringFromSelector(swizzledSelector), [self class]);
        return;
    }
    [self swizzlingMethodWithOriginalSelector:originalSelector swizzledSelector:swizzledSelector isClassMethod:NO];
}

+ (void)sf_swizzleClassMethodWithOriginalSelector:(SEL)originalSelector withSwizzledSelector:(SEL)swizzledSelector error:(NSError *__autoreleasing  _Nullable *)error {

    Method originalMethod = class_getClassMethod(self, originalSelector);

    if (!originalMethod) {
        SFExceptionError(error, @"original method %@ not found for class %@ \n", NSStringFromSelector(originalSelector), [self class]);
        return;
    }

    Method swizzledMethod = class_getClassMethod(self, swizzledSelector);

    if (!swizzledMethod) {
        SFExceptionError(error, @"swizzled method %@ not found for class %@ \n", NSStringFromSelector(swizzledSelector), [self class]);
        return;
    }

    [self swizzlingMethodWithOriginalSelector:originalSelector swizzledSelector:swizzledSelector isClassMethod:YES];
}

@end
