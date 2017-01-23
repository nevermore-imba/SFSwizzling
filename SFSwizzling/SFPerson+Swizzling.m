//
//  SFPerson+Swizzling.m
//  SFSwizzling
//
//  Created by Axe on 2017/1/23.
//  Copyright © 2017年 Nevermore. All rights reserved.
//

#import "SFPerson+Swizzling.h"
#import "NSObject+SFSwizzling.h"

@implementation SFPerson (Swizzling)

+ (void)load {

    __block NSError *classError;
    __block NSError *instanceError;

    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        
        [SFPerson sf_swizzleInstanceMethodWithOriginalSelector:@selector(setName:) withSwizzledSelector:@selector(replace_setName:) error:&instanceError];

        [SFPerson sf_swizzleClassMethodWithOriginalSelector:@selector(playGame) withSwizzledSelector:@selector(replace_playGame) error:&classError];

        if (classError) {
            NSLog(@"*** class error: %@", classError);
        }

        if (instanceError) {
            NSLog(@"*** instance error: %@", instanceError);
        }
    });
}

- (void)replace_setName:(NSString *)name {
    if (nil == name) {
        NSLog(@"*** Waring: name = %@ \n", name);
    } else {
        [self replace_setName:name];
    }
}

+ (void)replace_playGame {
    NSLog(@"Playing the DotA \n");
}
@end
