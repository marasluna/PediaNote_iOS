//
//  CustomPagerViewController.h
//  TestProject
//
//  Created by BerDy on 1/21/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PagerViewController.h"
#import "Plot.h"
#import "Age.h"
#import "HeightViewController.h"
#import "WeightViewController.h"
@interface CustomPagerViewController : PagerViewController

@property (strong, nonatomic) NSMutableArray *consultationDates;
@property (strong, nonatomic) NSDate *birthDate;
@property (strong, nonatomic) NSString *patientGender;
@property (strong, nonatomic) NSMutableArray *heightValues;
@property (strong, nonatomic) NSMutableArray *weightValues;

- (IBAction)closeWindow:(id)sender;
@end
