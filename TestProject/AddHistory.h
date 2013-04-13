//
//  AddHistory.h
//  TestProject
//
//  Created by BerDy on 1/13/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddHistoryDelegate.h"
#import "History.h"
#import "Patient.h"
#import "SelectHistoryTypeDelegate.h"

@interface AddHistory : UITableViewController 

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (retain, nonatomic) id <AddHistoryDelegate> delegate;
@property (strong, nonatomic) History *history;
@property (strong, nonatomic) Patient *patient;
@property (weak, nonatomic) IBOutlet UITextField *illnessInput;
@property (weak, nonatomic) IBOutlet UITextView *notesInput;
@property (strong, nonatomic) NSString *historyType;

- (IBAction)cancel:(id)sender;
- (IBAction)saveHistory:(id)sender;
@end
