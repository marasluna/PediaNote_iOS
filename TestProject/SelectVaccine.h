//
//  SelectVaccine.h
//  TestProject
//
//  Created by BerDy on 1/21/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectVaccineDelegate.h"

@interface SelectVaccine : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (retain, nonatomic) id <SelectVaccineDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIPickerView *picker;

@end
