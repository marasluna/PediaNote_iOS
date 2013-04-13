//
//  AddAppointmentTVC.h
//  TestProject
//
//  Created by Team Ganda on 3/1/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddAppointmentDelegate.h"
#import "Appointment.h"
#import "SearchPatientTVC.h"
#import "BackDelegate.h"
@interface AddAppointmentTVC : UITableViewController <AddPatientDelegate, BackDelegate>

@property (nonatomic, retain) id <AddAppointmentDelegate> delegate;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) Appointment * appointment;
@property (strong, nonatomic) IBOutlet UITableViewCell *patientCell;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *startTimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *endTimeLabel;
@property (strong, nonatomic) IBOutlet UITextView *notesLabel;
@property (nonatomic, assign) BOOL didSave;
@property (nonatomic, assign) BOOL editing;
@property (nonatomic, assign) BOOL shouldAdd;
- (IBAction)saveButton:(id)sender;

@end
