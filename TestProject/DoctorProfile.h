//
//  DoctorProfile.h
//  TestProject
//
//  Created by Team Ganda on 3/13/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDateHelper.h"
#import "Doctor.h"
@interface DoctorProfile : UITableViewController

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) IBOutlet UITextField *name;
@property (strong, nonatomic) IBOutlet UITextField *email;
@property (strong, nonatomic) IBOutlet UITextField *username;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) NSMutableArray *doctorArray;
@property (strong, nonatomic) IBOutlet UITextField *confirmPassword;
@property (strong, nonatomic) Doctor *doctor;
- (IBAction)saveButton:(id)sender;
@property (strong, nonatomic) IBOutlet UITableViewCell *password2Cell;

@property (strong, nonatomic) IBOutlet UITableViewCell *password1Cell;

@end
