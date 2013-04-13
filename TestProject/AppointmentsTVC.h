//
//  AppointmentsTVC.h
//  TestProject
//
//  Created by Team Ganda on 2/28/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppointmentsDetailDelegate.h"
#import "AppointmentsTVCDelegate.h"
#import "AddAppointmentTVC.h"
#import "AddAppointmentDelegate.h"
#import "EditAppointment.h"
#import "DisplayAppointmentDelegate.h"
#import "Calendar.h"

@interface AppointmentsTVC : UITableViewController <AppointmentsDetailDelegate, AddAppointmentDelegate, DisplayAppointmentDelegate>

@property (strong, nonatomic) IBOutlet UILabel *date;
@property (strong, nonatomic) IBOutlet UILabel *day;
@property (strong, nonatomic) IBOutlet UILabel *monthYear;
@property (strong, nonatomic) Calendar *myCalendar;


@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) id <AppointmentsTVCDelegate> delegate;
@property (strong, nonatomic) NSMutableArray *appointmentsArray;
@property (strong, nonatomic) UIPopoverController *popover;
@property (strong, nonatomic) AddAppointmentTVC *addAppointmentTVC;

@property (strong, nonatomic) NSDate *selectedDate;
@property (strong, nonatomic) UIPopoverController *editPopover;
@property (strong, nonatomic) EditAppointment *editAppointmentTVC;

- (IBAction)plus:(id)sender;

@end
