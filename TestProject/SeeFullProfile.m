//
//  SeeFullProfile.m
//  TestProject
//
//  Created by BerDy on 1/13/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "SeeFullProfile.h"
#import "Patient.h"
#import "Parent.h"
#import "CoreDateHelper.h"

@implementation SeeFullProfile

@synthesize delegate;
@synthesize rightButton;
@synthesize birthdateCell;
@synthesize givenNameInput;
@synthesize lastNameInput;
@synthesize middleNameInput;
@synthesize motherInput;
@synthesize motherLastInput;
@synthesize fatherInput;
@synthesize fatherLastInput;
@synthesize guardianInput;
@synthesize contactInput;
@synthesize emailInput;
@synthesize addressInput;
@synthesize termInput;
@synthesize deliveryInput;
@synthesize birthHeightInput;
@synthesize birthWeightInput;
@synthesize headCircumferenceInput;
@synthesize chestCircumferenceInput;
@synthesize abdominalCircumferenceInput;
@synthesize bloodTypeInput;
@synthesize clinicTextField;
@synthesize clinicCell;
@synthesize managedObjectContext;
@synthesize patient;
@synthesize bdayInput;
@synthesize guardianLastInput;
@synthesize bday;
@synthesize selectDatePopover;
@synthesize selectBirthday;
@synthesize sexLabel;
@synthesize sexCell;
@synthesize parentFather;
@synthesize parentMother;
@synthesize parentGuardian;
@synthesize selectPatientSex;
@synthesize selectSexPopover;
@synthesize didClick;
@synthesize selClinic;
@synthesize patientClinic;



- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
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
    
    self.didClick = FALSE;
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"MMMM dd, YYYY"];
    
    NSPredicate *pred1 = [NSPredicate predicateWithFormat: @"(patientt.firstName CONTAINS[cd] %@) AND (type LIKE[cd] %@)", patient.firstName, @"guardian"];
    NSMutableArray *parentMatched1 = [CoreDataHelper searchObjectsForEntity:@"Parent" withPredicate:pred1 andSortKey:@"firstName" andSortAscending:YES andContext:self.managedObjectContext];
    self.parentGuardian = [parentMatched1 objectAtIndex:0];

    NSPredicate *pred2 = [NSPredicate predicateWithFormat: @"(patientt.firstName CONTAINS[cd] %@) AND (type LIKE[cd] %@)", patient.firstName, @"mother"];
    NSMutableArray *parentMatched2 = [CoreDataHelper searchObjectsForEntity:@"Parent" withPredicate:pred2 andSortKey:@"firstName" andSortAscending:YES andContext:self.managedObjectContext];
    self.parentMother = [parentMatched2 objectAtIndex:0];
    
    NSPredicate *pred3 = [NSPredicate predicateWithFormat: @"(patientt.firstName CONTAINS[cd] %@) AND (type LIKE[cd] %@)", patient.firstName, @"father"];
    NSMutableArray *parentMatched3 = [CoreDataHelper searchObjectsForEntity:@"Parent" withPredicate:pred3 andSortKey:@"firstName" andSortAscending:YES andContext:self.managedObjectContext];
    self.parentFather = [parentMatched3 objectAtIndex:0];
    
    self.clinicTextField.text = self.patient.clinic.name;
    
    
    self.givenNameInput.text = self.patient.firstName;
    self.lastNameInput.text = self.patient.lastName;
    self.middleNameInput.text = self.patient.middleName;
    self.bdayInput.text = [dateformatter stringFromDate:self.patient.birthdate];
    self.sexLabel.text = self.patient.gender;
    self.motherInput.text = self.parentMother.firstName;
    self.motherLastInput.text = self.parentMother.lastName;
    self.fatherInput.text = self.parentFather.firstName;
    self.fatherLastInput.text = self.parentFather.lastName;
    self.guardianInput.text = self.parentGuardian.firstName;
    self.guardianLastInput.text = self.parentGuardian.lastName;
    self.contactInput.text = self.parentGuardian.cellphone;
    self.emailInput.text = self.parentGuardian.email;
    self.addressInput.text = self.patient.address;
    
    self.termInput.text = self.patient.term;
    self.deliveryInput.text = self.patient.delivery;
    self.birthHeightInput.text = self.patient.birthHeight;
    self.birthWeightInput.text = self.patient.birthWeight;
    self.headCircumferenceInput.text = self.patient.headCircum;
    self.chestCircumferenceInput.text = self.patient.chestCircum;
    self.abdominalCircumferenceInput.text = self.patient.abdominalCircum;
    self.bloodTypeInput.text = self.patient.bloodtype;
    //self..text = self.patient.;
    
    NSLog(@"show %@", self.patient.firstName);

    self.rightButton.style = UIBarButtonItemStyleBordered;
    self.rightButton.title = @"Edit";
    self.givenNameInput.userInteractionEnabled = NO;
    self.lastNameInput.userInteractionEnabled = NO;
    self.middleNameInput.userInteractionEnabled = NO;
    self.bdayInput.userInteractionEnabled = NO;
    self.sexLabel.userInteractionEnabled = NO;
    self.motherInput.userInteractionEnabled = NO;
    self.motherLastInput.userInteractionEnabled = NO;
    self.fatherInput.userInteractionEnabled = NO;
    self.fatherLastInput.userInteractionEnabled = NO;
    self.guardianInput.userInteractionEnabled = NO;
    self.guardianLastInput.userInteractionEnabled = NO;
    self.contactInput.userInteractionEnabled = NO;
    self.emailInput.userInteractionEnabled = NO;
    self.addressInput.userInteractionEnabled = NO;
    self.termInput.userInteractionEnabled = NO;
    self.deliveryInput.userInteractionEnabled = NO;
    self.birthHeightInput.userInteractionEnabled = NO;
    self.birthWeightInput.userInteractionEnabled = NO;
    self.headCircumferenceInput.userInteractionEnabled = NO;
    self.chestCircumferenceInput.userInteractionEnabled = NO;
    self.abdominalCircumferenceInput.userInteractionEnabled = NO;
    self.bloodTypeInput.userInteractionEnabled = NO;
    [birthdateCell setUserInteractionEnabled:FALSE];
    [sexCell setUserInteractionEnabled:FALSE];
    [self.clinicCell setUserInteractionEnabled:FALSE];

    [super viewDidLoad];
}


- (void)viewDidUnload
{
    [self setGivenNameInput:nil];
    [self setLastNameInput:nil];
    [self setMiddleNameInput:nil];
    [self setMotherInput:nil];
    [self setMotherLastInput:nil];
    [self setFatherInput:nil];
    [self setFatherLastInput:nil];
    [self setGuardianInput:nil];
    [self setContactInput:nil];
    [self setEmailInput:nil];
    [self setAddressInput:nil];
    [self setTermInput:nil];
    [self setDeliveryInput:nil];
    [self setBirthHeightInput:nil];
    [self setBirthWeightInput:nil];
    [self setHeadCircumferenceInput:nil];
    [self setChestCircumferenceInput:nil];
    [self setAbdominalCircumferenceInput:nil];
    [self setBloodTypeInput:nil];
    [self setRightButton:nil];
    
    [self setBdayInput:nil];
    [self setBirthdateCell:nil];
    [self setSexLabel:nil];
    [self setSexCell:nil];
    [self setGuardianLastInput:nil];
    [self setClinicTextField:nil];
    [self setClinicCell:nil];
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
	return YES;
}

- (IBAction)cancel:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)edit:(id)sender
{
    
    if (self.didClick == FALSE) {
    
        self.givenNameInput.userInteractionEnabled = YES;
        self.lastNameInput.userInteractionEnabled = YES;
        self.middleNameInput.userInteractionEnabled = YES;
        self.bdayInput.userInteractionEnabled = YES;
        self.sexLabel.userInteractionEnabled = YES;
        self.motherInput.userInteractionEnabled = YES;
        self.motherLastInput.userInteractionEnabled = YES;
        self.fatherInput.userInteractionEnabled = YES;
        self.fatherLastInput.userInteractionEnabled = YES;
        self.guardianInput.userInteractionEnabled = YES;
        self.guardianLastInput.userInteractionEnabled = YES;
        self.contactInput.userInteractionEnabled = YES;
        self.emailInput.userInteractionEnabled = YES;
        self.addressInput.userInteractionEnabled = YES;
        self.termInput.userInteractionEnabled = YES;
        self.deliveryInput.userInteractionEnabled = YES;
        self.birthHeightInput.userInteractionEnabled = YES;
        self.birthWeightInput.userInteractionEnabled = YES;
        self.headCircumferenceInput.userInteractionEnabled = YES;
        self.chestCircumferenceInput.userInteractionEnabled = YES;
        self.abdominalCircumferenceInput.userInteractionEnabled = YES;
        self.bloodTypeInput.userInteractionEnabled = YES;
        
        [birthdateCell setUserInteractionEnabled:TRUE];
        [sexCell setUserInteractionEnabled:TRUE];
        [self.clinicCell setUserInteractionEnabled:TRUE];
        self.rightButton.style = UIBarButtonItemStyleDone;
        self.rightButton.title = @"Save";
        self.didClick = TRUE;    
    }
    
    else {
        
        patient.firstName = self.givenNameInput.text;
        patient.lastName = self.lastNameInput.text;
        patient.middleName = self.middleNameInput.text;
        patient.birthdate = self.bday;
        patient.gender = self.sexLabel.text;
        patient.address = self.addressInput.text;
        parentMother.type = @"mother";
        parentMother.firstName = self.motherInput.text;
        parentMother.lastName = self.motherLastInput.text;
        parentFather.type = @"father";
        parentFather.firstName = self.fatherInput.text;
        parentFather.lastName = self.fatherLastInput.text;
        parentGuardian.type = @"guardian";
        parentGuardian.firstName = self.guardianInput.text;
        parentGuardian.lastName = self.guardianLastInput.text;
        parentGuardian.cellphone = self.contactInput.text;
        parentGuardian.email = self.emailInput.text;
        
        patient.term = self.termInput.text;
        patient.birthHeight = self.birthHeightInput.text;
        patient.birthWeight = self.birthWeightInput.text;
        patient.delivery = self.deliveryInput.text;
        patient.headCircum = self.headCircumferenceInput.text;
        patient.chestCircum =self.chestCircumferenceInput.text;
        patient.abdominalCircum =self.abdominalCircumferenceInput.text;
        patient.bloodtype = self.bloodTypeInput.text;
        patient.clinic = self.patientClinic;
        [self.patientClinic addPatientListObject:patient];
        NSLog(@"save");
        NSLog(@"paaaatient! %@", patient.firstName);
        NSError *error;
        if (![self.managedObjectContext save:&error])
            NSLog(@"Failed to add default user with e");

        self.didClick = FALSE;
        [self dismissModalViewControllerAnimated:YES];
    }

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"prepare add");
    if ([[segue identifier] isEqualToString:@"SelectDateSegue"])
    {
        UINavigationController *addDateNav = [segue destinationViewController];
        self.selectBirthday = [[addDateNav viewControllers] objectAtIndex:0];
        self.selectDatePopover = [[UIPopoverController alloc]initWithContentViewController:addDateNav];
        self.selectBirthday.delegate = self;
        self.selectBirthday.managedObjectContext = self.managedObjectContext;
    }
    
    if ([[segue identifier] isEqualToString:@"SelectSexSegue"])
    {
        UINavigationController *addSexNav = [segue destinationViewController];
        self.selectPatientSex = [[addSexNav viewControllers] objectAtIndex:0];
        self.selectSexPopover = [[UIPopoverController alloc]initWithContentViewController:addSexNav];
        self.selectPatientSex.delegate = self;
        self.selectPatientSex.managedObjectContext = self.managedObjectContext;
    }
    
    if([[segue identifier] isEqualToString:@"clinicSegue"]){
        
        NSLog(@"Clinic segue: %@", self.managedObjectContext);
        UINavigationController *clinicNav = [segue destinationViewController];
        self.selClinic = [[clinicNav viewControllers] objectAtIndex:0];
        
        NSMutableArray *arr  = [CoreDataHelper getObjectsForEntity:@"Clinic" withSortKey:@"name" andSortAscending:YES andContext:self.managedObjectContext];
        
        self.selClinic.selClinic = arr;
        self.selClinic.delegate = self;
        
        
    }

    
    
}


- (void) didSelectClinic:(Clinic *) pClinic{
    self.clinicTextField.text = pClinic.name;
    NSLog(@"CLINC NAME: %@", pClinic.name);
    self.patientClinic = pClinic;
    
    
    
}

- (void)getBirthdate:(NSDate *) date
{
    NSLog(@"getbday");
    self.bday = date;
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"MMMM dd, YYYY"];
    //self.bday = [NSString stringWithFormat:@"%@", [dateformatter stringFromDate:birthdate]];
    bdayInput.text = [NSString stringWithFormat:@"%@", [dateformatter stringFromDate:self.bday]];
    //NSLog(@"date: %@",[NSString stringWithFormat:@"%@", [dateformatter stringFromDate:self.bday]]);
}


- (void)getSex:(NSInteger)row
{
    NSLog(@"get sex see %d", row);
    if (row == 0) {
        self.sexLabel.text = @"Female";
    }
    else self.sexLabel.text = @"Male";
}

@end
