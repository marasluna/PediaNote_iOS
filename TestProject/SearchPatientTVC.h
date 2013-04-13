//
//  SearchPatientTVC.h
//  TestProject
//
//  Created by Team Ganda on 3/8/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDateHelper.h"
#import "Appointment.h"
#import "Patient.h"
#import "EditPatientDelegate.h"
#import "AddPatientDelegate.h"

@interface SearchPatientTVC : UITableViewController <UISearchDisplayDelegate, UISearchBarDelegate>

@property (strong, nonatomic) Appointment *appointment;
@property (strong, nonatomic) NSMutableArray *patientArray;
@property (strong, nonatomic) NSArray *searchResults;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, assign) NSInteger cameFromAdd;
@property (strong, nonatomic) Patient *patient;

@property (strong, nonatomic) id <EditPatientDelegate> editDelegate;
@property (strong, nonatomic) id <AddPatientDelegate> addDelegate;

@end
