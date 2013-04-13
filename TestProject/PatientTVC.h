//
//  PatientTVC.h
//  TestProject
//
//  Created by BerDy on 1/11/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PatientTVCDelegate.h"
#import "PatientProfileDelegate.h"
#import "PatientAddDelegate.h"
#import "Patient.h"

@interface PatientTVC : UITableViewController <PatientAddDelegate,UISearchDisplayDelegate, UISearchBarDelegate>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (retain, nonatomic) id <PatientTVCDelegate> delegate;

@property (strong, nonatomic) NSArray *searchResults;
@property (strong, nonatomic) NSMutableArray *patientDataList;
@property (strong, nonatomic) Patient *recentPatient;
@property (strong, nonatomic) NSMutableArray *parentMatched;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (strong, nonatomic) NSMutableArray * alphabetArray;
@property (strong, nonatomic) NSMutableArray *patientHeader;

- (IBAction)add:(id)sender;

@end
