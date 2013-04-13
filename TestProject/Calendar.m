//
//  Calendar.m
//  Appointments
//
//  Created by Team Ganda on 1/28/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "Calendar.h"

@implementation Calendar

@synthesize date;
- (id) initWithDate: (NSDate *) thedate{

    //if(self = [super init]){
        self.date = thedate;
        //NSLog(@"DATE: %@", date);
        numOfWeeks = [self setNumberOfWeeks];
    
    //}
    
       
    return self;

}

- (int) getNumOfWeeks{

    return numOfWeeks;
}
- (int) setNumberOfWeeks{
   // - (NSArray *)weeksOfMonth:(int)month inYear:(int)year
    //{
   
    NSDateComponents *components = [[NSDateComponents alloc] init];

    NSCalendar * calendar = [NSCalendar currentCalendar];
        
        

        [components setMonth:[self getMonth]];
        [components setYear:[self getYear]];
        
        NSRange range = [calendar rangeOfUnit:NSDayCalendarUnit
                                       inUnit:NSMonthCalendarUnit
                                      forDate:[calendar dateFromComponents:components]];
        
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSMutableSet *weeks = [[NSMutableSet alloc] init ];
        
        for(int i = 0; i < range.length; i++)
        {      
            NSString *temp = [NSString stringWithFormat:@"%4d-%2d-%2d",[components year],[components month],range.location+i];
            NSDate *date1 = [dateFormatter dateFromString:temp ];
            int week = [[calendar components: NSWeekOfYearCalendarUnit fromDate:date1] weekOfYear];
            [weeks addObject:[NSNumber numberWithInt:week]];
        }
        
        NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"" ascending:YES];
        NSArray *descriptors = [[NSArray alloc] initWithObjects:descriptor, nil];
        return [[weeks sortedArrayUsingDescriptors:descriptors] count];
    


}



- (int) getMonth{
    NSDateComponents* comps = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] components:( NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSTimeZoneCalendarUnit) fromDate:self.date];

    return [comps month];
}

- (int) getYear{
    NSDateComponents* comps = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] components:( NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSTimeZoneCalendarUnit) fromDate:self.date];

    return [comps year];
}


- (int) getMonthRange: (int) year1 withYear2: (int) year2 withMonth1: (int)month1 andMonth2: (int) month2{

   // NSLog(@"YEAR1: %d YEAR2: %d", year1, year2);
    NSString *dateString = [NSString stringWithFormat:@"%d-%.2d-%.2d",year1,month1,01];
    // Convert string to date object
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSDate *date1 = [dateFormat dateFromString:dateString]; 
   //NSLog(@"MONTH: %@", dateString);
    
    
    dateString = [NSString stringWithFormat:@"%d-%.2d-%.2d",year2,month2,01];
    // Convert string to date object

 
    NSDate *date2 = [dateFormat dateFromString:dateString]; 
     //NSLog(@"MONTH: %@", dateString);
    NSTimeInterval secondsBetween = [date2 timeIntervalSinceDate:date1];
    
       
    //NSLog(@"There are %d days in between the two dates.",(int) secondsBetween / 86400);

    return secondsBetween / 86400;
}



- (NSArray *) getDatesOfMonth{

    NSMutableArray * dates = [[NSMutableArray alloc] initWithCapacity:42];
    int count;
   int range;
    int i;
    NSDateFormatter *f=[[NSDateFormatter alloc]init];
    [f setDateFormat:@"yyyy-MM-dd"];
    //set date components
    NSDateComponents* comps = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] components:( NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSTimeZoneCalendarUnit) fromDate:self.date];
    

    //PREPARATION
    //start date of the month
    NSString *dateString = [NSString stringWithFormat:@"%d-%.2d-%.2d",[comps year],[comps month],01];
    // Convert string to date object
    //NSLog(@"String: %@", dateString);
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSDate *startdate = [dateFormat dateFromString:dateString]; 
    //get month name
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEEE"];
    int weekday = [self getWeekdayOrdinal:[dateFormatter stringFromDate: startdate]];
    
    
    //MONTH BEFORE
    //get range of month before
    int monthbefore;
    int yearbefore;
    
    if([comps month]+11==12){
        range   = [self getMonthRange:([comps year]-1) withYear2:([comps year]) withMonth1:([comps month]+11) andMonth2:([comps month])];
        monthbefore = [comps month] +11;
        yearbefore = [comps year] -1;
    }else{
        range   = [self getMonthRange:[comps year] withYear2:([comps year]) withMonth1:([comps month]-1) andMonth2:([comps month])];
        monthbefore = [comps month]-1;
        yearbefore = [comps year];
    }
    for(i=0; i<weekday; i++){
        dateString = [NSString stringWithFormat:@"%d-%.2d-%.2d",yearbefore,monthbefore,range-weekday+1+i];
        [dates addObject: [f dateFromString: dateString]];
    }

    
    
    ////MONTH CURRENT
    //get range
    
    if([comps month]==12){
        range   = [self getMonthRange:[comps year] withYear2:([comps year] +1) withMonth1:([comps month]) andMonth2:([comps month]-11)];
    }
    else{
        range   = [self getMonthRange:[comps year] withYear2:([comps year]) withMonth1:([comps month]) andMonth2:([comps month]+1)];
    }


    for(i=weekday; i<range+weekday ; i++){
        dateString = [NSString stringWithFormat:@"%d-%.2d-%.2d",[comps year],[comps month],i-weekday+1];
        count = i-weekday +1;
        [dates addObject: [f dateFromString: dateString]];
    }
    

    int monthafter;
    int yearafter;
    if([comps month]==12){
        monthafter = 1;
        yearafter = [comps year]+1;
    }
    else{
        yearafter = [comps year];
        monthafter = [comps month]+1;
    }   
    
    
       
    for(i=range+weekday; i<numOfWeeks*7; i++){
        dateString = [NSString stringWithFormat:@"%d-%.2d-%.2d",yearafter,monthafter,i-weekday-range+1];
        [dates addObject: [f dateFromString: dateString]];
    
    }
 
    return dates;

}

- (int) getWeekdayOrdinal: (NSString *) weekday{

    if([weekday isEqualToString:@"Sunday"]){
        return 0;
    }
    else if([weekday isEqualToString:@"Monday"]){
        return 1;
    }
    else if([weekday isEqualToString:@"Tuesday"]){
        return 2;
    }
    else if([weekday isEqualToString:@"Wednesday"]){
        return 3;
    }
    else if([weekday isEqualToString:@"Thursday"]){
        return 4;
    }
    else if([weekday isEqualToString:@"Friday"]){
        return 5;
    }
    else{
        return 6;
    }
  
}


- (NSString *) getDate{

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd"];
    
    return [dateFormatter stringFromDate:self.date];

}

-(NSString *) getDay{

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEEE"];
    
    return [dateFormatter stringFromDate:self.date];
}


- (NSString *) getMonthYearString{
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMMM yyyy"];
 
    //NSLog(@"%@", [dateFormatter stringFromDate:date]);

    
    /*
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSDayCalendarUnit fromDate:date];
    
    int month = [dateComponents month];
    int year = [dateComponents year];
    //int dateNum = [dateComponents date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSLog(@"month: %d year: %d", month, year);
    [dateFormatter setDateFormat:@"MM"];
    NSDate* myDate = [dateFormatter dateFromString:[NSString stringWithFormat:@" %@", month]];    
    [dateFormatter setDateFormat:@"MMMM"];
    NSString * monthString = [dateFormatter stringFromDate:myDate];  
    NSString * yearString = [NSString stringWithFormat:@" %@", year];
    
    monthString = [monthString stringByAppendingString:yearString];
    
    NSLog(@"%@", monthString);*/
    return [dateFormatter stringFromDate:self.date];
    
}

@end
