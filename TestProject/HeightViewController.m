//
//  HeightViewController.m
//  TestProject
//
//  Created by BerDy on 1/21/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "HeightViewController.h"
@implementation HeightViewController


@synthesize imageName;
@synthesize imageView;
@synthesize consultationDates;
@synthesize birthDate;
@synthesize patientChart;
@synthesize patientGender;
@synthesize startAge;
@synthesize endAge;
@synthesize ageArray;
@synthesize plot;
@synthesize plotValues;

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


- (void)setImage:(Age *) age withChart:(NSString *) chart andGender:(NSString *) gender{
    
    //NSString *imageName = @"";
    
    self.imageName = @"";
    if([chart isEqualToString:@"height"]){
        self.imageName = [ self.imageName stringByAppendingString:@"H"];
        
    }else if([chart isEqualToString:@"weight"]){
        self.imageName = [ self.imageName stringByAppendingString:@"W"];    
    }
    
    if([gender isEqualToString:@"Male"]){
        self.imageName = [ self.imageName stringByAppendingString:@"B"];
        
    }else if([gender isEqualToString:@"Female"]){
        self.imageName = [ self.imageName stringByAppendingString:@"G"];
        
    }
    
    
    if(age.year  == 0 && age.month < 6){ //less than 6 months
        self.imageName = [ self.imageName stringByAppendingString:@"06M"];
        self.startAge = 0;
        self.endAge = 6;
        
    }else if(age.year < 2){ //less 2years
        self.imageName = [ self.imageName stringByAppendingString:@"02Y"];
        self.startAge = 0;
        self.endAge = 2;
    }else if((age.year >= 2 && age.year < 5) || (age.year ==5 && age.month ==0)){ //2-5
        self.imageName = [ self.imageName stringByAppendingString:@"25Y"];
        self.startAge = 2;
        self.endAge = 5;
    }else if(age.year >= 5 && age.year <10 && [chart isEqualToString:@"weight"]){
        self.imageName = [ self.imageName stringByAppendingString:@"510Y"];
        self.startAge = 5;
        self.endAge = 10;
    }else if(age.year >= 5 && age.year <19){
        self.startAge = 5;
        self.endAge = 19;
        self.imageName = [ self.imageName stringByAppendingString:@"519Y"];
    }
    
    self.imageName = [ self.imageName stringByAppendingString:@".jpg"];
    
    
}



- (void) setImage{
    
    UIImage *bgImage = [UIImage imageNamed:self.imageName];//imageWithContentsOfFile:self.imageName];
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 768, 724)];
    [self.imageView setImage:bgImage];
    self.imageView.contentMode = UIViewContentModeCenter;
    [self.view addSubview:self.imageView];
    
    
    
}

-(BOOL) checkIfPart:(Age *)age{
    
    if(self.startAge == 0 && self.endAge ==6){
        if((age.year == 0 && age.month <6) || (age.month ==6 && age.day <=183 )){
            return YES;
        }else{
            return NO;
        }
        
    }else{
        if((age.year >=self.startAge && age.year < self.endAge) || (age.year == self.endAge && age.month == 0)){
            return YES;
        }else{
            return NO;
        }
        
        
    }
    
    
}

- (NSMutableArray *) setAgeBracket{
    
    NSMutableArray * ageArr = [[NSMutableArray alloc]init ];
    NSMutableArray *plotVal = [[NSMutableArray alloc]init ];//[self.plotValues mutableCopy];
    Age *curAge = [[Age alloc]init];
    
    int i;
    
    for (i = 0; i<[self.consultationDates count];  i++){
        curAge = [self age:self.birthDate fromDate:[self.consultationDates objectAtIndex:i]];
        if([self checkIfPart:curAge]){
            [ageArr addObject:curAge];
            [plotVal addObject:[self.plotValues objectAtIndex:i]];
        }
    }
    self.plotValues = plotVal;
    
    
    return ageArr;
}

- (void) configurePlot{
    
    CGRect rect;
    
    if(self.startAge == 0 && self.endAge ==6 && [self.patientChart isEqualToString:@"weight"]){
        rect = CGRectMake(71, 182, 633, 391);
        self.plot = [[Plot alloc]initWithFrame:rect ];
        self.plot.unitPixels = 24;
        
        self.plot.min = 1.7;
        if([self.patientGender isEqualToString:@"male"]){
            self.plot.max = 11.3;
            self.plot.yPixels = 41;
        }
        else{
            self.plot.max = 11.00;
            self.plot.yPixels = 43;
        }
        self.plot.xmin = 0;
    }
    
    else if(self.startAge == 0 && self.endAge ==6 && [self.patientChart isEqualToString:@"height"]){
        rect = CGRectMake(71, 182, 633, 391);
        self.plot = [[Plot alloc]initWithFrame:rect];
        self.plot.unitPixels = 23;
        self.plot.yPixels = 12;
        self.plot.max = 75.00;
        self.plot.min = 43.00;
        self.plot.xmin = 0;
    }
    else if(self.startAge == 0 && self.endAge == 2 && [self.patientChart isEqualToString:@"weight"]){
        rect = CGRectMake(71, 182, 633, 391);
        self.plot = [[Plot alloc]initWithFrame:rect];
        self.plot.unitPixels = 306;
        self.plot.yPixels = 25;
        self.plot.min = 1.4;
        self.plot.max = 17.8;
        self.plot.xmin = 0;
    }
    else if(self.startAge == 0 && self.endAge == 2 && [self.patientChart isEqualToString:@"height"]){
        rect = CGRectMake(71, 182, 633, 391);
        self.plot = [[Plot alloc]initWithFrame:rect];
        self.plot.unitPixels = 304;
        self.plot.yPixels = 7;
        self.plot.min = 42.0;
        self.plot.max = 99.00;
        self.plot.xmin = 0;
    }
    else if(self.startAge == 2 && self.endAge == 5 && [self.patientChart isEqualToString:@"weight"]){
        rect = CGRectMake(71, 182, 633, 391);
        self.plot = [[Plot alloc]initWithFrame:rect];
        
        if([self.patientGender isEqualToString:@"male"]){
            self.plot.min = 8.00;
            self.plot.max = 28.00;
            self.plot.unitPixels = 204;
            self.plot.yPixels = 20;
        }else{
            self.plot.min = 7.00;
            self.plot.max = 30.00;
            self.plot.unitPixels = 204;
            self.plot.yPixels = 17;
        }
        self.plot.xmin = 2;
    }
    else if(self.startAge == 2 && self.endAge == 5 && [self.patientChart isEqualToString:@"height"]){
        rect = CGRectMake(71, 182, 633, 391);
        self.plot = [[Plot alloc]initWithFrame:rect];
        self.plot.unitPixels = 204;
        self.plot.yPixels = 8;
        self.plot.min = 76.00;
        self.plot.max = 125.00;
        self.plot.xmin = 2;
    }
    else if(self.startAge == 5 && self.endAge == 10 && [self.patientChart isEqualToString:@"weight"]){
        rect = CGRectMake(74, 175, 632, 399);
        self.plot = [[Plot alloc]initWithFrame:rect];
        
        if([self.patientGender isEqualToString:@"male"]){
            self.plot.min = 12.00;
            self.plot.max = 58.00;
            self.plot.unitPixels = 119;
            self.plot.yPixels = 8.7;
        }else{
            self.plot.min = 10.00;
            self.plot.max = 60.00;
            self.plot.unitPixels = 119;
            self.plot.yPixels = 8;
        }
        self.plot.xmin = 5;
    }
    else if(self.startAge == 5 && self.endAge == 19 && [self.patientChart isEqualToString:@"height"]){
        rect = CGRectMake(74, 175, 632, 400);
        self.plot = [[Plot alloc]initWithFrame:rect];
        self.plot.unitPixels = 43;
        
        if([self.patientGender isEqualToString:@"male"]){
            self.plot.min = 90.00;
            self.plot.max = 200.00;
            self.plot.yPixels = 3.65;
        }else{
            self.plot.min = 90.00;
            self.plot.max = 185.00;
            self.plot.yPixels = 4.2;
        }
        self.plot.xmin = 5;
        
    }
    
    self.plot.plotValues = self.plotValues;
    self.plot.ageArray = self.ageArray;
    
    //self.plot = [[Plot alloc]initWithFrame:rect];
    
    [self.view addSubview:self.plot];
    
}



-(NSMutableArray *) computeAge{
    
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    double patientAge = 0.0;
    for (Age *age in self.ageArray){   
        if(self.startAge == 0 && self.endAge == 6){
            
            patientAge = age.day  / 7.00;
            
        }else{
            patientAge = age.year + (age.month/12.00);
            
        }
        
        [arr addObject:[NSString stringWithFormat:@"%.2f", patientAge]];
    }
    
    
    return arr;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    Age *arr = [self age:self.birthDate fromDate:[self.consultationDates lastObject]];
    [self setImage:arr withChart:self.patientChart andGender:self.patientGender];
    NSLog(@"IMG: %@", self.imageName);
    [self setImage];
    for(Age *a in self.ageArray){
        NSLog(@"Age Array: %d %d", a.year, a.month);
    }
    self.ageArray = [self setAgeBracket];
    for(Age *a in self.ageArray){
        NSLog(@"Age Array: %d %d", a.year, a.month);
    }
    self.ageArray = [self computeAge];
    NSLog(@"Age Array: %@", self.ageArray);
    NSLog(@"Plot Values: %@", self.plotValues);
    
    [self configurePlot];
    
    
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}


- (void)viewDidUnload
{
    [self setImageView:nil];
    [super viewDidUnload];
    
}

- (void)viewWillAppear:(BOOL)animated
{   
    
    
    
    
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}





@end
