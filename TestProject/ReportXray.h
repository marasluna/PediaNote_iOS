//
//  ReportXray.h
//  TestProject
//
//  Created by BerDy on 1/19/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReportXrayDelegate.h"
#import "Patient.h"
#import "Report.h"

@interface ReportXray : UITableViewController

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (retain, nonatomic) id <ReportXrayDelegate> delegate;
@property (strong, nonatomic) Patient *patient;
@property (strong, nonatomic) Report *report;

@property (weak, nonatomic) IBOutlet UITextField *notesInput;
@property (weak, nonatomic) IBOutlet UITextField *dataField1;
@property (weak, nonatomic) IBOutlet UITextField *dataField2;

- (IBAction)cancel:(id)sender;
- (IBAction)save:(id)sender;
@end
