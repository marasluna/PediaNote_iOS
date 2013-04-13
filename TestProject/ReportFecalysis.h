//
//  ReportFecalysis.h
//  TestProject
//
//  Created by BerDy on 1/19/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReportFecalysisDelegate.h"
#import "Patient.h"
#import "Report.h"

@interface ReportFecalysis : UITableViewController

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (retain, nonatomic) id <ReportFecalysisDelegate> delegate;
@property (strong, nonatomic) Patient *patient;
@property (strong, nonatomic) Report *report;

@property (weak, nonatomic) IBOutlet UITextField *notesInput;
@property (weak, nonatomic) IBOutlet UITextField *dataField1;
@property (weak, nonatomic) IBOutlet UITextField *dataField2;
@property (weak, nonatomic) IBOutlet UITextField *dataField3;
@property (weak, nonatomic) IBOutlet UITextField *dataField4;
@property (weak, nonatomic) IBOutlet UITextField *dataField5;
@property (weak, nonatomic) IBOutlet UITextField *dataField6;
@property (weak, nonatomic) IBOutlet UITextField *dataField7;
@property (weak, nonatomic) IBOutlet UITextField *dataField8;
@property (weak, nonatomic) IBOutlet UITextField *dataField9;

- (IBAction)cancel:(id)sender;
- (IBAction)save:(id)sender;
@end
