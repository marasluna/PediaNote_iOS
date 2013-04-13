//
//  AddClinic.h
//  TestProject
//
//  Created by Team Ganda on 3/14/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClinicDelegate.h"
#import "Clinic.h"
@interface AddClinic : UITableViewController //<UIPopoverControllerDelegate>

@property (strong, nonatomic) IBOutlet UITextField *name;
@property (strong, nonatomic) IBOutlet UITextField *location;
@property (strong, nonatomic) IBOutlet UITextField *schedule;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) id <ClinicDelegate> delegate;

@property (strong, nonatomic) Clinic *clinic;
- (IBAction)saveButon:(id)sender;

@end
