//
//  ReportCell.h
//  TestProject
//
//  Created by BerDy on 1/15/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReportCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *reportDateField;
@property (strong, nonatomic) IBOutlet UILabel *reportTypeField;
@property (strong, nonatomic) IBOutlet UILabel *reportNotesField;

@end
