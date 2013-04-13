//
//  CustomPagerViewController.m
//  TestProject
//
//  Created by BerDy on 1/21/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "CustomPagerViewController.h"
@implementation CustomPagerViewController


@synthesize consultationDates;
@synthesize birthDate;
@synthesize patientGender;
@synthesize weightValues;
@synthesize heightValues;

- (NSInteger)daysBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime
{
    NSDate *fromDate;
    NSDate *toDate;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar rangeOfUnit:NSDayCalendarUnit startDate:&fromDate
                 interval:NULL forDate:fromDateTime];
    [calendar rangeOfUnit:NSDayCalendarUnit startDate:&toDate
                 interval:NULL forDate:toDateTime];
    
    NSDateComponents *difference = [calendar components:NSDayCalendarUnit
                                               fromDate:fromDate toDate:toDate options:0];
    
    return [difference day];
}



- (Age *)age:(NSDate *)dateOfBirth fromDate:(NSDate *) date {
    
    NSInteger years;
    NSInteger months;
    NSInteger days;
    Age *age = [[Age alloc]init];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSDateComponents *dateComponentsNow = [calendar components:unitFlags fromDate:date];
    NSDateComponents *dateComponentsBirth = [calendar components:unitFlags fromDate:dateOfBirth];
    
    if (([dateComponentsNow month] < [dateComponentsBirth month]) ||
        (([dateComponentsNow month] == [dateComponentsBirth month]) && ([dateComponentsNow day] < [dateComponentsBirth day]))) {
        years = [dateComponentsNow year] - [dateComponentsBirth year] - 1;
    } else {
        years = [dateComponentsNow year] - [dateComponentsBirth year];
    }
    
    NSLog(@"years:%d", years);
    
    if ([dateComponentsNow year] == [dateComponentsBirth year]) {
        months = [dateComponentsNow month] - [dateComponentsBirth month];
    } else if ([dateComponentsNow year] > [dateComponentsBirth year] && [dateComponentsNow month] > [dateComponentsBirth month]) {
        months = [dateComponentsNow month] - [dateComponentsBirth month];
    } else if ([dateComponentsNow year] > [dateComponentsBirth year] && [dateComponentsNow month] < [dateComponentsBirth month]) {
        months = [dateComponentsNow month] - [dateComponentsBirth month] + 12;
    } else if ([dateComponentsNow year] > [dateComponentsBirth year] && [dateComponentsNow month] == [dateComponentsBirth month] && [dateComponentsNow day]<[dateComponentsBirth day]) {
        months = 0;
    } else {
        months = [dateComponentsNow month] - [dateComponentsBirth month];
    }
    
    NSLog(@"months:%d", months);
    
    if ([dateComponentsNow year] == [dateComponentsBirth year] && [dateComponentsNow month] == [dateComponentsBirth month]) {
        days = [dateComponentsNow day] - [dateComponentsBirth day];
    }else{
        days = 0;
    }
    
    
    
    if(years == 0 && months <6){
        
        days = [self daysBetweenDate:dateOfBirth andDate:date];
        
    }
    NSLog(@"days: %d", days);
    age.year = years;
    age.month = months;
    age.day = days;
    
    return age;
    
}


- (void)viewDidLoad
{
	// Do any additional setup after loading the view, typically from a nib.
    [super viewDidLoad];
    
    HeightViewController *height = [self.storyboard instantiateViewControllerWithIdentifier:@"height"];
    
    
    height.consultationDates = self.consultationDates;
    height.birthDate = self.birthDate;
    height.patientChart = @"height";
    height.patientGender = self.patientGender;
    height.plotValues = self.heightValues;
    
    [self addChildViewController:height];
    
    Age *age = [self age:self.birthDate fromDate:[self.consultationDates lastObject]];
    if(age.year <10 || (age.year ==10 && age.month ==0)){
        WeightViewController *weight = [self.storyboard instantiateViewControllerWithIdentifier:@"weight"];
        weight.consultationDates = self.consultationDates;
        weight.birthDate = self.birthDate;
        weight.patientChart = @"weight";
        weight.patientGender = self.patientGender;
        weight.plotValues = self.weightValues;
        NSLog(@"PAGE CONTROLLER: ");
        NSLog(@"height: %@",self.heightValues);
        NSLog(@"weight: %@",self.weightValues);    
        
        
        
        [self addChildViewController:weight];
    }//else{
    //  [self.pageControl setNumberOfPages:1];
    //}
}




- (IBAction)closeWindow:(id)sender {
    
    [self.parentViewController dismissModalViewControllerAnimated:YES];
}

@end
