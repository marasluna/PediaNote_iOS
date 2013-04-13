//
//  CalendarDay.h
//  TestProject
//
//  Created by Team Ganda on 3/10/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppointmentsDetailDelegate.h"
#import <QuartzCore/QuartzCore.h>

@interface CalendarDay : UIView

@property (nonatomic, retain) NSDate *date;
@property (nonatomic, strong) NSMutableArray *appointmentsArr;
@property (nonatomic, strong) IBOutlet UILabel *dateLabel;

@property (nonatomic, strong) id <AppointmentsDetailDelegate> delegate;
@property (nonatomic, strong) IBOutlet UIScrollView *scroller;

@property (nonatomic, strong) NSMutableArray *textViewArray;
- (void) changeContentSize: (int) number;
- (void) initializeTextViewWithString:(NSString *) str andNumber: (int) count;

-(void) removeSubviews;

@end
