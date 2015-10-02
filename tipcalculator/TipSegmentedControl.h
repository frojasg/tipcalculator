//
//  TipSegmentedControl.h
//  tipcalculator
//
//  Created by Francisco Rojas Gallegos on 9/29/15.
//  Copyright (c) 2015 Rita Miller desgins. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserPreferences.h"

@interface TipSegmentedControl : UISegmentedControl
- (void) load: (UserPreferences*) preferences;
- (void) willAppear;
- (float) getTipPercentage;
@end
