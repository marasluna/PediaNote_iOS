//
//  ShowUrinalysis.h
//  TestProject
//
//  Created by Team Ganda on 4/3/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Report.h"

@interface ShowUrinalysis : UITableViewController

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) Report *report;
@property (weak, nonatomic) IBOutlet UITextField *notesInput;
@property (weak, nonatomic) IBOutlet UITextField *r1;
@property (weak, nonatomic) IBOutlet UITextField *r2;
@property (weak, nonatomic) IBOutlet UITextField *r3;
@property (weak, nonatomic) IBOutlet UITextField *r4;
@property (weak, nonatomic) IBOutlet UITextField *r5;
@property (weak, nonatomic) IBOutlet UITextField *r6;
@property (weak, nonatomic) IBOutlet UITextField *r7;
@property (weak, nonatomic) IBOutlet UITextField *r8;
@property (weak, nonatomic) IBOutlet UITextField *r9;
@property (weak, nonatomic) IBOutlet UITextField *r10;
@property (weak, nonatomic) IBOutlet UITextField *r11;
@property (weak, nonatomic) IBOutlet UITextField *r12;

@end
