//
//  SelectedConsultationCell.h
//  TestProject
//
//  Created by BerDy on 1/15/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectedConsultationCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *dateField;
@property (strong, nonatomic) IBOutlet UILabel *heightField;
@property (strong, nonatomic) IBOutlet UILabel *weightField;
@property (strong, nonatomic) IBOutlet UILabel *subjectiveField;
@property (strong, nonatomic) IBOutlet UILabel *objectiveField;
@property (strong, nonatomic) IBOutlet UILabel *assessmentField;
@property (strong, nonatomic) IBOutlet UILabel *planField;

@end
