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
    NSUserDefaults *defaults;
}

- (id) init {
    self = [super init];
    if (self)
    {
        defaults = [NSUserDefaults standardUserDefaults];
    }
    return self;
}

- (NSInteger) getLowTip {
    NSInteger val;
    val = [defaults integerForKey:@"lowTipValue"];
    return val == 0 ? 10 : val;
}

- (NSInteger) getMediumTip {
    NSInteger val;
    val = [defaults integerForKey:@"mediumTipValue"];
    return val == 0 ? 15 : val;
}

- (NSInteger) getHighTip {
    NSInteger val;
    val = [defaults integerForKey:@"highTipValue"];
    return val == 0 ? 15 : val;
}

- (NSInteger) getTipIndex {
    NSInteger val;
    val = [defaults integerForKey:@"tipIndex"];
    return val;
}

- (NSNumber*) getBillAmount {
    float val;
    val = [defaults floatForKey:@"billAmount"];
    NSDate * expiresAt = [defaults objectForKey:@"billingExpiresAt"];
    if ([expiresAt timeIntervalSinceNow] < 0) {
        val = 0;
    }
    return @(val);
}

-(void) setLowTip: (NSInteger) lowTip {
    [defaults setInteger: lowTip forKey: @"lowTipValue"];
}
-(void) setMediumTip: (NSInteger) mediumTip {
    [defaults setInteger: mediumTip forKey: @"mediumTipValue"];
}
-(void) setHighTip: (NSInteger) highTip {
    [defaults setInteger: highTip forKey: @"highTipValue"];
}
-(void) setTipIndex: (NSInteger) index {
    [defaults setInteger: index forKey: @"tipIndex"];
}
-(void) setBillAmount:(NSNumber *) amount {
    NSDate *currentDate = [NSDate date];
    NSDate *expiresAt = [currentDate dateByAddingTimeInterval:(60*1)];
    [defaults setObject:expiresAt forKey: @"billingExpiresAt"];
    [defaults setFloat:[amount floatValue] forKey:@"billAmount"];
}

-(void) commit {
    [defaults synchronize];
}


@end
