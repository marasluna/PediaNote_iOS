//
//  AppointmentsDetail.m
//  TestProject
//
//  Created by Team Ganda on 2/28/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "AppointmentsDetail.h"
#import "CoreDateHelper.h"
#import "Appointment.h"
#import "Patient.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation AppointmentsDetail

@synthesize delegate = delegate;
@synthesize navItem;
@synthesize daySubview = _daySubview;
@synthesize seg;
@synthesize myCalendar = _myCalendar;
@synthesize month;
@synthesize year;
@synthesize managedObjectContext;

- (void) navigationTitle{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 30)];
    label.textAlignment = UITextAlignmentCenter;
    [label setFont:[UIFont boldSystemFontOfSize:16.0]];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setTextColor:[UIColor whiteColor]];
    [label setText:[self.myCalendar getMonthYearString]];
    [self.navigationController.navigationBar.topItem setTitleView:label];
    self.navItem.title = [self.myCalendar getMonthYearString];
    
}

- (void) initializaCalendarWithDate: (NSDate *) date{
    self.myCalendar = [[Calendar alloc] init];
    self.myCalendar = [self.myCalendar initWithDate:date];
    [self navigationTitle];
    self.month = [self.myCalendar getMonth];
    self.year = [self.myCalendar getYear];
}

- (void) addSubviews: (int) count{
    NSArray *arr = [self.myCalendar getDatesOfMonth];
    CGFloat height = 560.00;
    CGRect rect;
    self.daySubview = [[NSMutableArray alloc]init ];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd"];
    
    
    int i,j, counter=0;
    
    for(j=0;j<count;j++){
        for(i= 0; i < 7; i++){ 
            rect = CGRectMake((100*(i)),((height/count)-1)*(j) +84,101,height/count);
            CalendarDay *square = [[CalendarDay alloc]initWithFrame:rect];
            square.delegate = self.delegate;
            [self.view addSubview:square];
            square.dateLabel.text = [dateFormat stringFromDate:[arr objectAtIndex:counter]];
            square.date = [arr objectAtIndex:counter];
            counter ++;
            [self.daySubview addObject:square];
            
        }
    }
    
}


- (void) removeSubViews:(NSMutableArray *) view{
    
    int i;
    for(i=0; i<view.count ; i++){
        [[view objectAtIndex:i] removeFromSuperview];
        
    }
    
}




- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


- (void)viewDidLoad
{
    
    [self initializaCalendarWithDate:[NSDate date]];
    [self addSubviews:[self.myCalendar getNumOfWeeks]];    
    
    self.seg.selectedSegmentIndex = self.month;
    [self.seg setTitle:[NSString stringWithFormat: @"%d",self.year-1] forSegmentAtIndex:0];
    [self.seg setTitle:[NSString stringWithFormat: @"%d",self.year+1] forSegmentAtIndex:13];
    
    
    [super viewDidLoad];
}


- (void)viewDidUnload
{
    [self setNavItem:nil];
    [self setSeg:nil];
    [self setNavItem:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation== UIInterfaceOrientationLandscapeRight);
}


- (NSPredicate *) predicateToRetrieveEventsForDate:(NSDate *)aDate {
    
    // start by retrieving day, weekday, month and year components for the given day
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *todayComponents = [gregorian components:(NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit) fromDate:aDate];
    NSInteger theDay = [todayComponents day];
    NSInteger theMonth = [todayComponents month];
    NSInteger theYear = [todayComponents year];
    
    // now build a NSDate object for the input date using these components
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:theDay]; 
    [components setMonth:theMonth]; 
    [components setYear:theYear];
    NSDate *thisDate = [gregorian dateFromComponents:components];
    //[components release];
    
    // build a NSDate object for aDate next day
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setDay:1];
    NSDate *nextDate = [gregorian dateByAddingComponents:offsetComponents toDate:thisDate options:0];
    //[offsetComponents release];
    
    //[gregorian release];
    
    
    // build the predicate 
    NSPredicate *predicate = [NSPredicate predicateWithFormat: @"date < %@ && date >= %@", nextDate, thisDate];
    
    return predicate;
    
}


- (void) refreshCalendar: (NSDate *) date{
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:date];
    
    
    
    NSDateFormatter *f4 = [[NSDateFormatter alloc]init];
    [f4 setDateFormat:@"hh:mm"];
    NSDateFormatter *f5 = [[NSDateFormatter alloc]init];
    [f5 setDateFormat:@"hh:mm a"];
    
    NSArray *arr = [[NSArray alloc] init ];
    NSPredicate *pred;
    
    int i=0;
    
    
    if([components month]== self.month){
        NSLog(@"Refresh");
        
        for(CalendarDay *subview in self.daySubview){
            [subview removeSubviews];
            pred = [self predicateToRetrieveEventsForDate:subview.date];
            arr = [CoreDataHelper searchObjectsForEntity:@"Appointment" withPredicate:pred andSortKey:@"startTime" andSortAscending:YES andContext:self.managedObjectContext];
            NSString *string = [[NSString alloc]init];
            
            if([arr count] !=0){
                i=0;
                for(Appointment *app in arr){
                    
                    string = [NSString stringWithFormat:@" %@-%@\n %@ %@\n", [f4 stringFromDate:app.startTime], [f5 stringFromDate:app.endTime], app.patient.firstName, app.patient.lastName];
                    [subview initializeTextViewWithString:string andNumber:i];
                    i++;
                }
                
                [subview changeContentSize:i];
                
            }
            
            //subview.textView.text = string;
            
        }
        
        
        
    }
    
}


- (void) prepareDataInViewController: (NSString *) dateString{
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    [self initializaCalendarWithDate:[dateFormatter dateFromString:dateString]];
    
    [self removeSubViews:self.daySubview];
    [self addSubviews:[self.myCalendar getNumOfWeeks]];    
    
    [self refreshCalendar:[dateFormatter dateFromString:dateString]];
}


- (IBAction)segmentedControl:(id)sender {
    self.seg = sender;
    NSString *dateString;
    
    switch (self.seg.selectedSegmentIndex) {
        case 0:
            
            dateString = [NSString stringWithFormat:@"%d-12-01", self.year-1];
            [self prepareDataInViewController:dateString];
            self.seg.selectedSegmentIndex = 12;
            [self.seg setTitle:[NSString stringWithFormat: @"%d",self.year-1] forSegmentAtIndex:0];
            [self.seg setTitle:[NSString stringWithFormat: @"%d",self.year+1] forSegmentAtIndex:13];
            break;
        case 1:
            dateString = [NSString stringWithFormat:@"%.4d-01-01", self.year];
            [self prepareDataInViewController:dateString];
            break;
        case 2:
            dateString = [NSString stringWithFormat:@"%d-02-01", self.year];
            [self prepareDataInViewController:dateString];
            break;
        case 3:
            dateString = [NSString stringWithFormat:@"%d-03-01", self.year];
            [self prepareDataInViewController:dateString];
            break;
        case 4:
            dateString = [NSString stringWithFormat:@"%d-04-01", self.year];
            [self prepareDataInViewController:dateString];
            break;
        case 5:
            dateString = [NSString stringWithFormat:@"%d-05-01", self.year];
            [self prepareDataInViewController:dateString];
            break;
        case 6:
            dateString = [NSString stringWithFormat:@"%d-06-01", self.year];
            [self prepareDataInViewController:dateString];
            break;
        case 7:
            dateString = [NSString stringWithFormat:@"%d-07-01", self.year];
            [self prepareDataInViewController:dateString];
            break;
        case 8:
            dateString = [NSString stringWithFormat:@"%d-08-01", self.year];
            [self prepareDataInViewController:dateString];
            break;
        case 9:
            dateString = [NSString stringWithFormat:@"%d-09-01", self.year];
            [self prepareDataInViewController:dateString];
            break;
        case 10:
            dateString = [NSString stringWithFormat:@"%d-10-01", self.year];
            [self prepareDataInViewController:dateString];
            break;
        case 11:
            dateString = [NSString stringWithFormat:@"%d-11-01", self.year];
            [self prepareDataInViewController:dateString];
            break;
        case 12:
            dateString = [NSString stringWithFormat:@"%d-12-01", self.year];
            [self prepareDataInViewController:dateString];
            break;
        case 13:
            dateString = [NSString stringWithFormat:@"%d-01-01", self.year+1];
            [self prepareDataInViewController:dateString];
            self.seg.selectedSegmentIndex = 1;
            [self.seg setTitle:[NSString stringWithFormat: @"%d",self.year+1] forSegmentAtIndex:13];
            [self.seg setTitle:[NSString stringWithFormat: @"%d",self.year-1] forSegmentAtIndex:0];
            break;
        default:
            break;
    }
    
}
@end
