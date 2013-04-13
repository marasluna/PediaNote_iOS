//
//  SelectClinic.h
//  TestProject
//
//  Created by Team Ganda on 3/25/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectClinicDelegate.h"

#import "CoreDateHelper.h"
@interface SelectClinic : UIViewController  <UIPickerViewDelegate, UIPickerViewDataSource>

@property (strong, nonatomic) IBOutlet UIPickerView *picker;


@property (retain, nonatomic) id <SelectClinicDelegate> delegate;

@property (strong, nonatomic) NSMutableArray *selClinic;
@property (strong, nonatomic) Clinic *clinic;
@end
