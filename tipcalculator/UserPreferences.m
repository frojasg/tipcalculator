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
    NSUserDefaults *standardUserDefaults;
}

- (id) init {
    self = [super init];
    if (self)
    {
        standardUserDefaults = [NSUserDefaults standardUserDefaults];
    }
    return self;
}

- (NSInteger) getLowTip {
    NSInteger val;
    val = [standardUserDefaults integerForKey:@"lowTipValue"];
    return val == 0 ? 10 : val;
}

- (NSInteger) getMediumTip {
    NSInteger val;
    val = [standardUserDefaults integerForKey:@"mediumTipValue"];
    return val == 0 ? 15 : val;
}

- (NSInteger) getHighTip {
    NSInteger val;
    val = [standardUserDefaults integerForKey:@"highTipValue"];
    return val == 0 ? 15 : val;
}

-(void) setLowTip: (NSInteger) lowTip {
    [standardUserDefaults setInteger: lowTip forKey: @"lowTipValue"];
}
-(void) setMediumTip: (NSInteger) mediumTip {
    [standardUserDefaults setInteger: mediumTip forKey: @"mediumTipValue"];
}
-(void) setHighTip: (NSInteger) highTip {
    [standardUserDefaults setInteger: highTip forKey: @"highTipValue"];
}

-(void) commit {
    [standardUserDefaults synchronize];
}


@end
