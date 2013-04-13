//
//  AddConsultation.h
//  TestProject
//
//  Created by BerDy on 1/13/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddConsultationDelegate.h"
#import "Consultation.h"
#import "Patient.h"

@interface AddConsultation : UITableViewController

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (retain, nonatomic) id <AddConsultationDelegate> delegate;
@property (strong, nonatomic) Consultation *consultation;
@property (strong, nonatomic) Patient *patient;
@property (weak, nonatomic) IBOutlet UITextField *heightInput;
@property (weak, nonatomic) IBOutlet UITextField *weightInput;

@property (weak, nonatomic) IBOutlet UITextField *subjectiveInput;
@property (weak, nonatomic) IBOutlet UITextField *objectiveInput;
@property (weak, nonatomic) IBOutlet UITextField *assessmentInput;
@property (weak, nonatomic) IBOutlet UITextField *planInput;

- (IBAction)cancel:(id)sender;
- (IBAction)saveConsultation:(id)sender;
@end
