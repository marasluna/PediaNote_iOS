//
//  EditClinicTable.h
//  TestProject
//
//  Created by Team Ganda on 3/15/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Clinic.h"
#import "ClinicDelegate.h"
@interface EditClinicTable : UITableViewController

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
- (IBAction)saveButton:(id)sender;
- (IBAction)cancelButton:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *name;
@property (strong, nonatomic) IBOutlet UITextField *location;
@property (strong, nonatomic) IBOutlet UITextField *schedule;
@property (strong, nonatomic) Clinic *clinic;
@property (strong, nonatomic) id <ClinicDelegate> delegate;
@end
