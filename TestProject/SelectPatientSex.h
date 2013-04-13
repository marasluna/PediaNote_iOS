//
//  SelectPatientSex.h
//  TestProject
//
//  Created by BerDy on 1/19/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectPatientSexDelegate.h"

@interface SelectPatientSex : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (retain, nonatomic) id <SelectPatientSexDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIPickerView *picker;


@end
