//
//  Calendar.h
//  Appointments
//
//  Created by Team Ganda on 1/28/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Calendar : NSObject
{
    //NSDate *date;
    int numOfWeeks;
}

@property (strong, nonatomic) NSDate *date;
//@property (nonatomic, assign) NSInteger * numOfWeeks;
- (id) initWithDate:(NSDate *) date;
- (int) getNumOfWeeks;
- (NSArray *) getDatesOfMonth;

- (NSString *) getMonthYearString;
- (NSString *) getDate;
- (NSString *) getDay;
- (int) getWeekdayOrdinal: (NSString *) weekday;
- (int) getMonthRange: (int) year1 withYear2: (int) year2 withMonth1: (int)month1 andMonth2: (int) month2;
- (int) getMonth;
- (int) getYear;
- (int) setNumberOfWeeks;
@end