//
//  Clinics.h
//  TestProject
//
//  Created by Team Ganda on 3/13/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDateHelper.h"
#import "ClinicTableCell.h"
#import "ClinicDelegate.h"
#import "AddClinic.h"
#import "EditClinicTable.h"
#import "Clinic.h"
@interface Clinics : UITableViewController <UISplitViewControllerDelegate, ClinicDelegate>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSMutableArray *clinicArray;
@property (retain, nonatomic) UIPopoverController *popover;
@property (strong, nonatomic) Clinic *clinic;

@end
