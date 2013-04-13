//
//  ImmunizationCell.m
//  TestProject
//
//  Created by BerDy on 1/20/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "ImmunizationCell.h"


@implementation ImmunizationCell

@synthesize nameLabel;
@synthesize a1;
@synthesize a2;
@synthesize a3;
@synthesize a4;
@synthesize a5;
@synthesize a6;

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
