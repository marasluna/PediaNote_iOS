//
//  AddAppointmentDelegate.h
//  TestProject
//
//  Created by Team Ganda on 3/1/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Appointment.h"
@protocol AddAppointmentDelegate <NSObject>

- (void) saveAppointment:(NSDate *) date;

@end
