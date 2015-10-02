//
//  TipSegmentedControl.m
//  tipcalculator
//
//  Created by Francisco Rojas Gallegos on 9/29/15.
//  Copyright (c) 2015 Rita Miller desgins. All rights reserved.
//

#import "TipSegmentedControl.h"

@implementation TipSegmentedControl
{
    UserPreferences *preferences;
}

- (void) load: (UserPreferences*) userPreferences {
    preferences = userPreferences;
    self.selectedSegmentIndex = [preferences getTipIndex];
}

- (void) willAppear {
    [self setTitle:[NSString stringWithFormat:@"%ld%@", [preferences getLowTip], @"%"] forSegmentAtIndex: 0];
    [self setTitle:[NSString stringWithFormat:@"%ld%@", [preferences getMediumTip], @"%"] forSegmentAtIndex: 1];
    [self setTitle:[NSString stringWithFormat:@"%ld%@", [preferences getHighTip], @"%"] forSegmentAtIndex: 2];
}
- (float) getTipPercentage {
    NSArray *tipValues = @[@([preferences getLowTip]), @([preferences getMediumTip]), @([preferences getHighTip])];
    [preferences setTipIndex: self.selectedSegmentIndex];
    return [tipValues[self.selectedSegmentIndex] floatValue]/100;
}

@end
