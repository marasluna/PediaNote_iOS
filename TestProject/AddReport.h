//
//  AddReport.h
//  TestProject
//
//  Created by BerDy on 1/15/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddReportDelegate.h"
#import "Patient.h"

@interface AddReport : UITableViewController

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (retain, nonatomic) id <AddReportDelegate> delegate;
@property (strong, nonatomic) Patient *patient;

@property (weak, nonatomic) IBOutlet UITableViewCell *cbcCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *fecalysisCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *urinalysisCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *Xray;
@property (weak, nonatomic) IBOutlet UITableViewCell *othersCell;

- (IBAction)cancel:(id)sender;
@end
