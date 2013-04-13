//
//  Appointment.h
//  TestProject
//
//  Created by BerDy on 1/22/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Patient;

@interface Appointment : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSDate * endTime;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSDate * startTime;
@property (nonatomic, retain) Patient *patient;

@end
