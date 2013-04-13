//
//  Plot.h
//  TestProject
//
//  Created by BerDy on 1/21/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface Plot : UIView

@property (strong, nonatomic) NSMutableArray *ageArray;
@property (strong, nonatomic) NSMutableArray *yArray;
@property (assign, nonatomic) float unitPixels;
@property (assign, nonatomic) float yPixels;
@property (assign, nonatomic) float min;
@property (assign, nonatomic) float max;
@property (assign, nonatomic) float xmin;
@property (strong, nonatomic) NSMutableArray * plotValues;

@end
