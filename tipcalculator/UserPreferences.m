//
//  UserPreferences.m
//  tipcalculator
//
//  Created by Francisco Rojas Gallegos on 9/21/15.
//  Copyright (c) 2015 Rita Miller desgins. All rights reserved.
//

#import "UserPreferences.h"

@implementation UserPreferences
{
    float min;
    
}

- (id) init {
    self = [super init];
    if (self)
    {
        NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    }
    return self;
}

- (NSInteger) getLowTip {
    NSInteger val = 10;
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    val = [standardUserDefaults integerForKey:@"lowTipValue"];
    return val;
}

- (NSInteger) getMediumTip {
    NSInteger val = 15;
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    val = [standardUserDefaults integerForKey:@"mediumTipValue"];
    return val;
}

- (NSInteger) getHighTip {
    NSInteger val = 20;
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    val = [standardUserDefaults integerForKey:@"highTipValue"];
    return val;
}


@end
