//
//  SelectedConsultationCell.m
//  TestProject
//
//  Created by BerDy on 1/15/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "SelectedConsultationCell.h"

@implementation SelectedConsultationCell

@synthesize weightField;
@synthesize heightField;
@synthesize dateField;
@synthesize subjectiveField;
@synthesize objectiveField;
@synthesize assessmentField;
@synthesize planField;

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
