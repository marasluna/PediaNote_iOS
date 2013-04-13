//
//  EditAppointment.h
//  TestProject
//
//  Created by Team Ganda on 3/5/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Appointment.h"
#import "DisplayAppointmentDelegate.h"
#import "SearchPatientTVC.h"
#import "EditPatientDelegate.h"

@interface EditAppointment : UITableViewController <EditPatientDelegate>

@property (strong, nonatomic) IBOutlet UITableViewCell *patientCell;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *startTimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *endTimeLabel;
@property (strong, nonatomic) IBOutlet UITextView *notesLabel;
@property (strong, nonatomic) NSManagedObjectContext * managedObjectContext;
@property (strong, nonatomic) Appointment *appointment;


@property (nonatomic, strong) NSDate *currentDate;
@property (nonatomic, strong) NSDate *currentStartTime;
@property (nonatomic, strong) NSDate *currentEndTime;
@property (nonatomic, strong) NSString *currentNotes;
@property (nonatomic, strong) Patient * currentPatient;
@property (nonatomic, assign) BOOL didSave;
@property (nonatomic, assign) BOOL didDelete;

@property (nonatomic, retain) id <DisplayAppointmentDelegate> delegate;

- (IBAction)saveButton:(id)sender;
- (IBAction)deleteButton:(id)sender;

@end
