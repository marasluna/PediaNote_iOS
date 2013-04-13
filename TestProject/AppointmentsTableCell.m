//
//  AppointmentsTableCell.m
//  TestProject
//
//  Created by Team Ganda on 3/10/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "AppointmentsTableCell.h"

@implementation AppointmentsTableCell
@synthesize scheduleLabel;
@synthesize nameLabel;
@synthesize mobileLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
