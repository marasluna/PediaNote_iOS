//
//  SelectHistoryType.h
//  TestProject
//
//  Created by BerDy on 1/20/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectHistoryTypeDelegate.h"
#import "Patient.h"
#import "AddHistoryDelegate.h"
#import "AddImmunizationDelegate.h"

@interface SelectHistoryType : UITableViewController

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (retain, nonatomic) id <AddHistoryDelegate> delegate1;
@property (retain, nonatomic) id <AddHistoryDelegate> delegate2;
@property (retain, nonatomic) id <AddHistoryDelegate> delegate3;
@property (retain, nonatomic) id <AddImmunizationDelegate> delegate4;
@property (strong, nonatomic) NSString *historyType;

@property (strong, nonatomic) Patient *patient;

@end
