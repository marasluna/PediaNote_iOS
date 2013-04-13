//
//  AppointmentsDetail.h
//  TestProject
//
//  Created by Team Ganda on 2/28/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppointmentsDetailDelegate.h"
#import "Calendar.h"
#import "CalendarDay.h"
#import "AppointmentsTVCDelegate.h"


@interface AppointmentsDetail : UIViewController <UISplitViewControllerDelegate, AppointmentsTVCDelegate>

@property (nonatomic, retain) id <AppointmentsDetailDelegate> delegate;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) IBOutlet UINavigationItem *navItem;
@property (strong, nonatomic) IBOutlet UISegmentedControl *seg;

//@property (strong, nonatomic) NSMutableArray *dateLabel;
@property (strong, nonatomic) NSMutableArray *daySubview;

@property (strong, nonatomic) Calendar *myCalendar;
@property (nonatomic, assign) NSInteger month;
@property (nonatomic, assign) NSInteger year;

- (IBAction)segmentedControl:(id)sender;

@end
