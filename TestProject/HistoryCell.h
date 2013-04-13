//
//  HistoryCell.h
//  TestProject
//
//  Created by BerDy on 1/12/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistoryCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *historyDateField;
@property (strong, nonatomic) IBOutlet UILabel *historyIllnessField;
@property (strong, nonatomic) IBOutlet UILabel *historyNotesField;

@end
