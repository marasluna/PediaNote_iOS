//
//  ReportUrinalysis.h
//  TestProject
//
//  Created by BerDy on 1/19/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReportUrinalysisDelegate.h"
#import "Patient.h"
#import "Report.h"

@interface ReportUrinalysis : UITableViewController

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (retain, nonatomic) id <ReportUrinalysisDelegate> delegate;
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
@property (weak, nonatomic) IBOutlet UITextField *dataField10;
@property (weak, nonatomic) IBOutlet UITextField *dataField11;
@property (weak, nonatomic) IBOutlet UITextField *dataField12;

- (IBAction)cancel:(id)sender;
- (IBAction)save:(id)sender;
@end
