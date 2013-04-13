//
//  HeightViewController.h
//  TestProject
//
//  Created by BerDy on 1/21/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Plot.h"
#import "Age.h"

@interface HeightViewController : UIViewController

@property (strong, nonatomic) NSMutableArray *consultationDates;
@property (strong, nonatomic) NSDate *birthDate;
@property (strong, nonatomic) NSString * imageName;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) NSString *patientChart;
@property (strong, nonatomic) NSString *patientGender;
@property (assign, nonatomic) NSInteger startAge;
@property (assign, nonatomic) NSInteger endAge;
@property (strong, nonatomic) NSMutableArray *ageArray;

@property (strong, nonatomic) Plot *plot;
@property (strong, nonatomic) NSMutableArray *plotValues;



@end
