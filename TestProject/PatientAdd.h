//
//  PatientAdd.h
//  TestProject
//
//  Created by BerDy on 1/11/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PatientTVCDelegate.h"
#import "PatientAddDelegate.h"
#import "SelectBirthday.h"
#import "SelectBirthdayDelegate.h"
#import "SelectPatientSex.h"
#import "SelectPatientSexDelegate.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "SelectClinic.h"
#import "SelectClinicDelegate.h"
@interface PatientAdd : UITableViewController <UIImagePickerControllerDelegate, SelectBirthdayDelegate, SelectPatientSexDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIPopoverControllerDelegate, SelectClinicDelegate>
{

    UIPopoverController *popoverController;

    BOOL newMedia;
}

@property (nonatomic, retain) UIPopoverController *popoverController;
@property (strong, nonatomic) NSData *imageData;


@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (retain, nonatomic) id <PatientAddDelegate> delegate;

@property (strong, nonatomic) SelectBirthday *selectBirthday;
@property (strong, nonatomic) SelectPatientSex *selectPatientSex;
@property (strong, nonatomic) UIImagePickerController *imagePicker;
@property (weak, nonatomic) IBOutlet UIButton *ChooseFromFileButton;
@property (weak, nonatomic) IBOutlet UITableViewCell *selectDate;
@property (strong, nonatomic) UIPopoverController *selectDatePopover;
@property (strong, nonatomic) NSDate *bday;
@property (strong, nonatomic) UIPopoverController *selectSexPopover;
@property (weak, nonatomic) IBOutlet UITableViewCell *selectSex;
@property (weak, nonatomic) IBOutlet UILabel *sexLabel;
@property (weak, nonatomic) IBOutlet UITextField *givenNameInput;
@property (weak, nonatomic) IBOutlet UITextField *fatherInput;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UITextField *lastNameInput;
@property (weak, nonatomic) IBOutlet UITextField *middleNameInput;
@property (weak, nonatomic) IBOutlet UITextField *bdayInput;
@property (weak, nonatomic) IBOutlet UITextField *motherInput;
@property (weak, nonatomic) IBOutlet UITextField *motherLastNameInput;
@property (weak, nonatomic) IBOutlet UITextField *fatherLastNameInput;
@property (weak, nonatomic) IBOutlet UITextField *guardianInput;
@property (weak, nonatomic) IBOutlet UITextField *guardianLastNameInput;
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

@property (weak, nonatomic) IBOutlet UITextField *heightInput;
@property (weak, nonatomic) IBOutlet UITextField *weightInput;
@property (weak, nonatomic) IBOutlet UITextField *subjectiveInput;
@property (weak, nonatomic) IBOutlet UITextField *objectiveInput;
@property (weak, nonatomic) IBOutlet UITextField *assessmentInput;
@property (weak, nonatomic) IBOutlet UITextField *planInput;

@property (weak, nonatomic) IBOutlet UITextField *allergiesInput;
@property (weak, nonatomic) IBOutlet UITextField *familyHistoryInput;
@property (weak, nonatomic) IBOutlet UITextField *pastIllnessInput;

@property (strong, nonatomic) IBOutlet UILabel *clinic;
@property (strong, nonatomic) SelectClinic *selClinic;
@property (strong, nonatomic) Clinic *patientClinic;

- (IBAction)cancel:(id)sender;
- (IBAction)save:(id)sender;
- (IBAction)selectImage:(id) sender;

 @end
