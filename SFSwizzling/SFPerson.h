//
//  SFPerson.h
//  SFSwizzling
//
//  Created by Axe on 2017/1/23.
//  Copyright © 2017年 Nevermore. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SFPerson : NSObject

- (instancetype)init;
- (instancetype)initWithName:(nullable NSString *)name;

@property (nullable, readonly, nonatomic, copy) NSString *name;

- (void)setName:(nullable NSString *)name;

+ (void)playGame;

@end

NS_ASSUME_NONNULL_END
