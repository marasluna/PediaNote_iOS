//
//  AppointmentsDetailDelegate.h
//  TestProject
//
//  Created by Team Ganda on 2/28/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AppointmentsDetailDelegate <NSObject>

-(void) didTapDay: (NSDate *) date;

@end
