//
//  ReportCBCCell.m
//  TestProject
//
//  Created by BerDy on 1/16/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "ReportCBCCell.h"

@implementation ReportCBCCell

@synthesize resultField;
@synthesize referenceField;
@synthesize examField;

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
