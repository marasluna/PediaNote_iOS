//
//  AddImmunization.h
//  TestProject
//
//  Created by BerDy on 1/20/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Patient.h"
#import "SelectHistoryTypeDelegate.h"
#import "AddImmunizationDelegate.h"
#import "Immunization.h"
#import "SelectVaccineDelegate.h"
#import "SelectVaccine.h"
#import "SelectDose.h"
#import "Immunization.h"
@interface AddImmunization : UITableViewController <SelectVaccineDelegate>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (retain, nonatomic) id <AddImmunizationDelegate> delegate;
@property (strong, nonatomic) Patient *patient;
@property (strong, nonatomic) Immunization *immunization;
@property (strong, nonatomic) SelectVaccine *selectVaccine;
@property (strong, nonatomic) SelectDose *selectDose;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *doseLabel;
@property (assign, nonatomic) NSInteger doseRow;
@property (assign, nonatomic) NSInteger typeRow;

- (IBAction)cancel:(id)sender;
- (IBAction)saveImmunization:(id)sender;

@end
