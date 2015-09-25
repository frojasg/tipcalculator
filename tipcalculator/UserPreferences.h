//
//  UserPreferences.h
//  tipcalculator
//
//  Created by Francisco Rojas Gallegos on 9/21/15.
//  Copyright (c) 2015 Rita Miller desgins. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserPreferences : NSObject

-(NSInteger) getLowTip;
-(NSInteger) getMediumTip;
-(NSInteger) getHighTip;
-(void) setLowTip: (NSInteger) lowTip;
-(void) setMediumTip: (NSInteger) mediumTip;
-(void) setHighTip: (NSInteger) highTip;
-(void) commit;

@end
