//
//  SelectBirthday.h
//  TestProject
//
//  Created by BerDy on 1/18/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectBirthdayDelegate.h"

@interface SelectBirthday : UIViewController

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (retain, nonatomic) id <SelectBirthdayDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIDatePicker *birthdatePicker;

- (IBAction)pickerChanged:(id)sender;
@end
