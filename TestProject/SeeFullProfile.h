//
//  SeeFullProfile.h
//  TestProject
//
//  Created by BerDy on 1/13/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SeeFullProfileDelegate.h"
#import "Patient.h"
#import "SelectBirthday.h"
#import "Parent.h"
#import "SelectPatientSexDelegate.h"
#import "SelectPatientSex.h"
#import "SelectClinic.h"
#import "SelectClinicDelegate.h"


@interface SeeFullProfile : UITableViewController <SelectBirthdayDelegate, SelectPatientSexDelegate, SelectClinicDelegate>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (retain, nonatomic) id <SeeFullProfileDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *rightButton;

@property (weak, nonatomic) IBOutlet UITableViewCell *birthdateCell;
@property (strong, nonatomic) SelectPatientSex *selectPatientSex;
@property (strong, nonatomic) Patient *patient;
@property (strong, nonatomic) Parent *parentGuardian;
@property (strong, nonatomic) Parent *parentMother;
@property (strong, nonatomic) Parent *parentFather;
@property (strong, nonatomic) UIPopoverController *selectSexPopover;
@property (strong, nonatomic) UIPopoverController *selectDatePopover;
@property (strong, nonatomic) SelectBirthday *selectBirthday;
@property (weak, nonatomic) IBOutlet UILabel *sexLabel;
@property (weak, nonatomic) IBOutlet UITableViewCell *sexCell;
@property (strong, nonatomic) NSDate *bday;
@property (weak, nonatomic) IBOutlet UILabel *bdayInput;

@property (weak, nonatomic) IBOutlet UITextField *guardianLastInput;
@property (assign, nonatomic) BOOL didClick;
@property (weak, nonatomic) IBOutlet UITextField *givenNameInput;
@property (weak, nonatomic) IBOutlet UITextField *lastNameInput;
@property (weak, nonatomic) IBOutlet UITextField *middleNameInput;
@property (weak, nonatomic) IBOutlet UITextField *motherInput;
@property (weak, nonatomic) IBOutlet UITextField *motherLastInput;
@property (weak, nonatomic) IBOutlet UITextField *fatherInput;
@property (weak, nonatomic) IBOutlet UITextField *fatherLastInput;
@property (weak, nonatomic) IBOutlet UITextField *guardianInput;
@property (weak, nonatomic) IBOutlet UITextField *contactInput;
@property (weak, nonatomic) IBOutlet UITextField *emailInput;
@property (weak, nonatomic) IBOutlet UITextField *addressInput;

@property (weak, nonatomic) IBOutlet UITextField *termInput;
@property (weak, nonatomic) IBOutlet UITextField *deliveryInput;
@property (weak, nonatomic) IBOutlet UITextField *birthHeightInput;
@property (weak, nonatomic) IBOutlet UITextField *birthWeightInput;
@property (weak, nonatomic) IBOutlet UITextField *headCircumferenceInput;
@property (weak, nonatomic) IBOutlet UITextField *chestCircumferenceInput;
@property (weak, nonatomic) IBOutlet UITextField *abdominalCircumferenceInput;
@property (weak, nonatomic) IBOutlet UITextField *bloodTypeInput;
@property (weak, nonatomic) IBOutlet UILabel *clinicTextField;
@property (weak, nonatomic) IBOutlet UITableViewCell *clinicCell;
@property (strong, nonatomic) Clinic *patientClinic;

@property(weak, nonatomic) SelectClinic *selClinic;
- (IBAction)cancel:(id)sender;
- (IBAction)edit:(id)sender;
- (void)showProfile: (Patient *)patient;
- (IBAction)didEdit:(id)sender;
@end
