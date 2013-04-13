//
//  AccountSettingsTVC.h
//  TestProject
//
//  Created by Team Ganda on 3/13/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountSettingsTVC : UITableViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
