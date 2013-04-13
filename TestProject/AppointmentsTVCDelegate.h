//
//  AppointmentsTVCDelegate.h
//  TestProject
//
//  Created by Team Ganda on 2/28/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AppointmentsTVCDelegate <NSObject>

- (void) refreshCalendar: (NSDate *) date;
@end
