//
//  AppointmentsTableCell.h
//  TestProject
//
//  Created by Team Ganda on 3/10/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppointmentsTableCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *scheduleLabel;
@property (strong, nonatomic) IBOutlet UILabel * nameLabel;
@property (strong, nonatomic) IBOutlet UILabel * mobileLabel;

@end
