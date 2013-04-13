//
//  SelectSchedule.h
//  TestProject
//
//  Created by Team Ganda on 3/4/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Appointment.h"
#import "BackDelegate.h"
@interface SelectSchedule : UITableViewController 

@property NSInteger activeCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *dateCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *startTimeCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *endTimeCell;
@property (strong, nonatomic) UIDatePicker *datePicker;
@property (strong, nonatomic) Appointment * appointment;
@property (nonatomic, assign) BOOL cameFromAdd;
@property (nonatomic, assign) id <BackDelegate> delegate;
- (IBAction)backButton:(id)sender;

@end
