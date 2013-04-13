//
//  ReportOthers.h
//  TestProject
//
//  Created by BerDy on 1/19/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReportOthersDelegate.h"
#import "Patient.h"
#import "Report.h"

@interface ReportOthers : UITableViewController

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (retain, nonatomic) id <ReportOthersDelegate> delegate;
@property (strong, nonatomic) Patient *patient;
@property (strong, nonatomic) Report *report;

@property (weak, nonatomic) IBOutlet UITextField *notesInput;
@property (weak, nonatomic) IBOutlet UITextField *dataField1;

- (IBAction)cancel:(id)sender;
- (IBAction)save:(id)sender;
@end
