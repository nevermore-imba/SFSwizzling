//
//  main.m
//  SFSwizzling
//
//  Created by Axe on 2017/1/22.
//  Copyright © 2017年 Nevermore. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SFPerson.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        SFPerson *person = [[SFPerson alloc] init];
        [person setName:nil];
        NSLog(@"%@", person);
        [SFPerson playGame];
    }
    return 0;
}
