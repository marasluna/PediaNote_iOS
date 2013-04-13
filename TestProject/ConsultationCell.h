//
//  ConsultationCell.h
//  TestProject
//
//  Created by BerDy on 1/11/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConsultationCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *dateField;
@property (strong, nonatomic) IBOutlet UILabel *heightField;
@property (strong, nonatomic) IBOutlet UILabel *weightField;
@property (strong, nonatomic) IBOutlet UILabel *subjectiveField;

@end
