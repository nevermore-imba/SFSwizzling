//
//  SFPerson.m
//  SFSwizzling
//
//  Created by Axe on 2017/1/23.
//  Copyright © 2017年 Nevermore. All rights reserved.
//

#import "SFPerson.h"

@implementation SFPerson

- (instancetype)init {
    return [self initWithName:nil];
}

- (instancetype)initWithName:(NSString *)name {
    self = [super init];
    if (self) {
        _name = name;
    }
    return self;
}

#pragma mark -

- (void)setName:(NSString *)name {
    _name = name;
}


+ (void)playGame {
    NSLog(@"Playing the LOL");
}

#pragma mark -

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@: %p, %@>", self.class, self, @{@"name" : _name ?: [NSNull null]}];
}
@end
