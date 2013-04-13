//
//  PatientAdd.m
//  TestProject
//
//  Created by BerDy on 1/11/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "PatientAdd.h"
#import "CoreDateHelper.h"
#import "Patient.h"
#import "Parent.h"
#import "Consultation.h"
#import "History.h"
#import "HistoryCell.h"
#import "PatientProfile.h"
#import "OpenPhotoLibrary.h"
#import "Immunization.h"
@implementation PatientAdd


@synthesize imageData;
@synthesize popoverController;

@synthesize managedObjectContext;
@synthesize delegate;
@synthesize lastNameInput;
@synthesize middleNameInput;
@synthesize bdayInput;
@synthesize motherInput;
@synthesize motherLastNameInput;
@synthesize fatherLastNameInput;
@synthesize guardianInput;
@synthesize guardianLastNameInput;
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
@synthesize heightInput;
@synthesize weightInput;
@synthesize subjectiveInput;
@synthesize objectiveInput;
@synthesize assessmentInput;
@synthesize planInput;
@synthesize allergiesInput;
@synthesize familyHistoryInput;
@synthesize pastIllnessInput;
@synthesize clinic;
@synthesize imagePicker;
@synthesize ChooseFromFileButton;
@synthesize selectDate;
@synthesize selectBirthday;
@synthesize selectDatePopover;
@synthesize bday;
@synthesize selectSex;
@synthesize sexLabel;
@synthesize givenNameInput;
@synthesize fatherInput;
@synthesize dateLabel;
@synthesize selectPatientSex;
@synthesize selectSexPopover;
@synthesize patientClinic;

@synthesize selClinic;

- (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize withImage: (UIImage *) sourceImage
{
    
    UIImage *newImage = nil;    
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (CGSizeEqualToSize(imageSize, targetSize) == NO) 
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor) 
        {
            scaleFactor = widthFactor; // scale to fit height
        }
        else
        {
            scaleFactor = heightFactor; // scale to fit width
        }
        
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5; 
        }
        else
        {
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
        }
    }   
    
    UIGraphicsBeginImageContext(targetSize); // this will crop
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    if(newImage == nil)
    {
        NSLog(@"could not scale image");
    }
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    
    return newImage;
}



-(void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self.popoverController dismissPopoverAnimated:true];
    
    
    NSString *mediaType = [info
                           objectForKey:UIImagePickerControllerMediaType];
    //[self dismissModalViewControllerAnimated:YES];
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        UIImage *image = [info
                          objectForKey:UIImagePickerControllerOriginalImage];
        
        
        
        image = [self imageByScalingAndCroppingForSize:CGSizeMake(100, 100) withImage:image];
        self.imageData = UIImageJPEGRepresentation(image, 0.0);
       /* Image * imgObject = [NSEntityDescription insertNewObjectForEntityForName:@"Image" inManagedObjectContext:self.managedObjectContext];
        imgObject.image = imageData;
        
        [self.managedObjectContext save:nil];
        NSLog(@"IMAGE %d ", [CoreDataHelper countForEntity:@"Image" andContext:self.managedObjectContext]);
        
        
        NSMutableArray *arr = [CoreDataHelper getObjectsForEntity:@"Image" withSortKey:nil andSortAscending:NO andContext:self.managedObjectContext];
        
        Image *img = [arr objectAtIndex:0];
        UIImage *mage = [UIImage imageWithData:img.image];
        //[[newCustomer yourImageView] setImage:image];
        
        
        imageView.image = mage;
        //imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.image = [self imageByScalingAndCroppingForSize:CGSizeMake(100, 100) withImage:imageView.image];
        */
        
        if (newMedia)
            UIImageWriteToSavedPhotosAlbum(image,
                                           self,  
                                           @selector(image:finishedSavingWithError:contextInfo:),
                                           nil);
    }
    else if ([mediaType isEqualToString:(NSString *)kUTTypeMovie])
    {
        // Code here to support video if enabled
    }
}
-(void)image:(UIImage *)image
finishedSavingWithError:(NSError *)error
 contextInfo:(void *)contextInfo
{
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Save failed"
                              message: @"Failed to save image"\
                              delegate: nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
        
    }
}


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
    [super viewDidLoad];
    //dateLabel.text = @"January 1, 2000";
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [self setLastNameInput:nil];
    [self setMiddleNameInput:nil];
    [self setBdayInput:nil];
    [self setMotherInput:nil];
    [self setGuardianInput:nil];
    [self setContactInput:nil];
    [self setAddressInput:nil];
    [self setHeightInput:nil];
    [self setWeightInput:nil];
    [self setSubjectiveInput:nil];
    [self setObjectiveInput:nil];
    [self setAssessmentInput:nil];
    [self setPlanInput:nil];
    [self setAllergiesInput:nil];
    [self setFamilyHistoryInput:nil];
    [self setPastIllnessInput:nil];
    [self setMotherLastNameInput:nil];
    [self setFatherLastNameInput:nil];
    [self setEmailInput:nil];
    [self setTermInput:nil];
    [self setDeliveryInput:nil];
    [self setBirthHeightInput:nil];
    [self setBirthWeightInput:nil];
    [self setHeadCircumferenceInput:nil];
    [self setChestCircumferenceInput:nil];
    [self setAbdominalCircumferenceInput:nil];
    [self setBloodTypeInput:nil];
    [self setChooseFromFileButton:nil];
    [self setSelectDate:nil];
    [self setDateLabel:nil];
    [self setFatherInput:nil];
    [self setGivenNameInput:nil];
    [self setSexLabel:nil];
    [self setSelectSex:nil];
    [self setGuardianLastNameInput:nil];
    [self setClinic:nil];
    [super viewDidUnload];
    
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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}



-(IBAction)save:(id)sender
{
    NSLog(@"saveeeeee %@", self.managedObjectContext);
    Patient *patient = (Patient *)[NSEntityDescription insertNewObjectForEntityForName:@"Patient" inManagedObjectContext:self.managedObjectContext];
    Parent *parent1 = (Parent *)[NSEntityDescription insertNewObjectForEntityForName:@"Parent" inManagedObjectContext:self.managedObjectContext];
    Parent *parent2 = (Parent *)[NSEntityDescription insertNewObjectForEntityForName:@"Parent" inManagedObjectContext:self.managedObjectContext];
    Parent *parent3 = (Parent *)[NSEntityDescription insertNewObjectForEntityForName:@"Parent" inManagedObjectContext:self.managedObjectContext];
    Consultation *consult = (Consultation *)[NSEntityDescription insertNewObjectForEntityForName:@"Consultation" inManagedObjectContext:self.managedObjectContext];
    History *history = (History *)[NSEntityDescription insertNewObjectForEntityForName:@"History" inManagedObjectContext:self.managedObjectContext];
   
    patient.firstName = self.givenNameInput.text;
    patient.lastName = self.lastNameInput.text;
    patient.middleName = self.middleNameInput.text;
    patient.birthdate = self.bday;
    patient.gender = self.sexLabel.text;
    patient.address = self.addressInput.text;
    patient.image = self.imageData;
    
    parent1.type = @"mother";
    parent1.firstName = self.motherInput.text;
    parent1.lastName = self.motherLastNameInput.text;
    parent2.type = @"father";
    parent2.firstName = self.fatherInput.text;
    //NSLog(@"father: %@", self.fatherInput.text);
    parent2.lastName = self.fatherLastNameInput.text;
    parent3.type = @"guardian";
    parent3.firstName = self.guardianInput.text;
    parent3.lastName = self.guardianLastNameInput.text;
    parent3.cellphone = self.contactInput.text;
    parent3.email = self.emailInput.text;
        
    patient.term = self.termInput.text;
    patient.birthHeight = self.birthHeightInput.text;
    patient.birthWeight = self.birthWeightInput.text;
    patient.delivery = self.deliveryInput.text;
    patient.headCircum = self.headCircumferenceInput.text;
    patient.chestCircum =self.chestCircumferenceInput.text;
    patient.abdominalCircum =self.abdominalCircumferenceInput.text;
    patient.bloodtype = self.bloodTypeInput.text;
    consult.date = [NSDate date];
    consult.height = self.heightInput.text;
    consult.weight = self.weightInput.text;
    consult.subjective = self.subjectiveInput.text;
    consult.objective = self.objectiveInput.text;
    consult.assessment = self.assessmentInput.text;
    consult.plan = self.planInput.text;
    history.date = [NSDate date];
    history.type = self.pastIllnessInput.text;
    history.type = self.allergiesInput.text;
    history.type = self.familyHistoryInput.text;
    
    [patient addParentsObject:parent1];
    [patient addParentsObject:parent2];
    [patient addParentsObject:parent3];
    [parent1 addPatienttObject:patient];
    [parent2 addPatienttObject:patient];
    [parent3 addPatienttObject:patient];
    [patient addConsultationsObject:consult];
    [patient addHistorysObject:history];
    
    [self.patientClinic addPatientListObject:patient];
    [patient setClinic:self.patientClinic];
    
    Immunization *immunization = [NSEntityDescription insertNewObjectForEntityForName:@"Immunization" inManagedObjectContext:self.managedObjectContext];
    
    immunization.patientt = patient;
    patient.immunizations = immunization;
    
    
    
    NSLog(@"save");
    NSLog(@"paaaatient! %@", patient.firstName);
    NSError *error;
    
    
    

    if (![self.managedObjectContext save:&error])
        NSLog(@"Failed to add default user with error: %@", [error domain]);
        
    NSPredicate *pred = [NSPredicate predicateWithFormat: @"(patientt.firstName CONTAINS[cd] %@) AND (type LIKE[cd] %@)", patient.firstName, @"guardian"];
    NSMutableArray *parentMatched; 
    parentMatched = [CoreDataHelper searchObjectsForEntity:@"Parent" withPredicate:pred andSortKey:@"firstName" andSortAscending:YES andContext:self.managedObjectContext];
    Parent *currentParent = [parentMatched objectAtIndex:0];
    NSLog(@"cur %@", currentParent);
    NSLog(@"contact: %@ %@", currentParent.firstName, currentParent.cellphone);
    NSLog(@"delegate %@", self.delegate);
    [self dismissModalViewControllerAnimated:YES];
    [self.delegate savePatient:patient];
    
}

- (IBAction)cancel:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

-(IBAction)selectImage:(UIButton *)sender
{
    NSLog(@"Select image");
    
    if ([self.popoverController isPopoverVisible]) {
        [self.popoverController dismissPopoverAnimated:YES];
    } else {
        if ([UIImagePickerController isSourceTypeAvailable:
             UIImagePickerControllerSourceTypeSavedPhotosAlbum])
        {
            
            
            
            UIImagePickerController *imagePicker2 =
            [[UIImagePickerController alloc] init];
            imagePicker2.delegate = self;
            //imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            
            imagePicker2.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            imagePicker2.mediaTypes = [NSArray arrayWithObjects:
                                      (NSString *) kUTTypeImage,
                                      nil];
            imagePicker2.allowsEditing = NO;
            
            self.popoverController = [[UIPopoverController alloc]
                                      initWithContentViewController:imagePicker2];
            
            popoverController.delegate = self;

            
            
            [self.popoverController presentPopoverFromRect:sender.bounds
                                                    inView:sender
                                  permittedArrowDirections:UIPopoverArrowDirectionUp
                                                  animated:YES];
            
            newMedia = NO;
            
        }
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

    self.clinic.text = pClinic.name;
    self.patientClinic = pClinic;
   
    

}
- (void)getBirthdate:(NSDate *) date
{
    NSLog(@"getbday");
    self.bday = date;
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"MMMM dd, YYYY"];
    //self.bday = [NSString stringWithFormat:@"%@", [dateformatter stringFromDate:birthdate]];
    self.dateLabel.text = [NSString stringWithFormat:@"%@", [dateformatter stringFromDate:self.bday]];
    NSLog(@"date: %@",[NSString stringWithFormat:@"%@", [dateformatter stringFromDate:self.bday]]);
}

- (void)getSex:(NSInteger)row
{
    NSLog(@"get sex add");
    if (row == 0) {
        self.sexLabel.text = @"Female";
    }
    else self.sexLabel.text = @"Male";
}

@end
