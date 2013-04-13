//
//  AppointmentsTVC.m
//  TestProject
//
//  Created by Team Ganda on 2/28/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "AppointmentsTVC.h"
#import "CoreDateHelper.h"
#import "Patient.h"
#import "AppointmentsTableCell.h"
#import "Parent.h"
@implementation AppointmentsTVC

@synthesize delegate = _delegate;
@synthesize date = _date;
@synthesize day = _day;
@synthesize monthYear = _monthYear;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize appointmentsArray = _appointmentsArray;
@synthesize popover = _popover;
@synthesize addAppointmentTVC = _addAppointmentTVC;
@synthesize editPopover = _editPopover;
@synthesize editAppointmentTVC = _editAppointmentTVC;
@synthesize myCalendar = _myCalendar;
@synthesize selectedDate = _selectedDate;


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


-(void) setArray{
    
    
    
    
    
    NSPredicate *pred = [self predicateToRetrieveEventsForDate:self.selectedDate];
    
    self.appointmentsArray = [CoreDataHelper searchObjectsForEntity:@"Appointment" withPredicate:pred andSortKey:@"startTime" andSortAscending:YES andContext:self.managedObjectContext];
    
    
    
    
    NSLog(@"%d APP COUNT: ", [self.appointmentsArray count]);
    NSLog(@"END");
    
}

- (void)initializeCalendarwithDate: (NSDate *) date{
    
    self.myCalendar = [[Calendar alloc]init ];
    self.myCalendar = [self.myCalendar initWithDate: date];
    
    self.monthYear.text = [self.myCalendar getMonthYearString];
    self.date.text = [self.myCalendar getDate];
    self.day.text = [self.myCalendar getDay];
    
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
    
    self.selectedDate = [NSDate date];
    [self setArray];
    //if(self.appointmentsArray !=nil)
    //   NSLog(@"COUNT: %d", [self.appointmentsArray count]);
    
    [self initializeCalendarwithDate:[NSDate date]];
    [self.delegate refreshCalendar:[NSDate date]];
    [super viewDidLoad];
    
    
    //
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [self setDate:nil];
    [self setDay:nil];
    [self setMonthYear:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    if(self.appointmentsArray==nil)
        return 0;
    else
        return [self.appointmentsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    AppointmentsTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[AppointmentsTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    


    NSDateFormatter *formatter2 = [[NSDateFormatter alloc]init];
    [formatter2 setDateFormat:@"hh:mma"];
    
    // Configure the cell...
    Appointment *appointment = [self.appointmentsArray objectAtIndex:indexPath.row];
    cell.nameLabel.text = [NSString stringWithFormat:@"%@ %@", appointment.patient.firstName, appointment.patient.lastName];
 
    NSSet *pset = appointment.patient.parents;
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"type == 'guardian'"];
    
    NSSet *filteredSet = [pset filteredSetUsingPredicate:pred];
    Parent *parent;
    
    if([filteredSet count]==1){
        parent = [filteredSet anyObject];
        cell.mobileLabel.text = parent.cellphone;
    }
    else cell.mobileLabel.text = @"mobile";
    
    
    

    
    cell.scheduleLabel.text = [NSString stringWithFormat:@"%@", [formatter2 stringFromDate:appointment.startTime]];
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    UINavigationController *navigation = [mainStoryboard instantiateViewControllerWithIdentifier:@"displayAppointmentNav"];
    self.editAppointmentTVC = [navigation.viewControllers objectAtIndex:0];
    self.editAppointmentTVC.delegate = self;
    self.editAppointmentTVC.managedObjectContext = self.managedObjectContext;
    self.editAppointmentTVC.appointment = [self.appointmentsArray objectAtIndex:indexPath.row];
    self.editPopover = [[UIPopoverController alloc]initWithContentViewController:navigation];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    CGRect rect=CGRectMake(cell.bounds.origin.x+250, cell.bounds.origin.y+10, 50, 30);
    [self.editPopover presentPopoverFromRect:rect inView:cell permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
    
}


#pragma mark - Add Appointment Protocol

-(void) saveAppointment:(NSDate *) date{
    
    [self.popover dismissPopoverAnimated:YES];
    self.popover = nil;
    [self setArray];
    
    [self.tableView reloadData];
    [self.delegate refreshCalendar:date];
    //reload calendar
}

- (IBAction)plus:(id)sender {
    if(self.popover == nil){
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        
        UINavigationController *navigation = [mainStoryboard instantiateViewControllerWithIdentifier:@"PopoverNavigation"];
        
        self.addAppointmentTVC = [navigation.viewControllers objectAtIndex:0];
        self.addAppointmentTVC.delegate = self;
        self.addAppointmentTVC.managedObjectContext = self.managedObjectContext;
        
        self.popover = [[UIPopoverController alloc]initWithContentViewController:navigation];
    }
    self.addAppointmentTVC.shouldAdd = YES;
    [self.popover presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES]; 
    
    
}

-(void) didSelectDelete:(NSDate *) date{
    [self.editPopover dismissPopoverAnimated:YES];
    [self setArray];
    [self.tableView reloadData];
    [self.delegate refreshCalendar:date];
    
}

-(void) didTapDay:(NSDate *)date{
    
    self.selectedDate = date;
    [self initializeCalendarwithDate:date];
    [self setArray];
    [self.tableView reloadData];
    //fetch objects and reload table
}

@end
