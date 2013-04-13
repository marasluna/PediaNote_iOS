//
//  AddRequest.h
//  TestProject
//
//  Created by Team Ganda on 4/4/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "Patient.h"
#import "AddRequestDelegate.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface AddRequest : UITableViewController <MFMailComposeViewControllerDelegate>

@property (strong, nonatomic) id <AddRequestDelegate> delegate;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITextField *recipientInput;
@property (weak, nonatomic) IBOutlet UITextField *typeInput;
@property (weak, nonatomic) IBOutlet UITextField *notesInput;
@property (strong, nonatomic) Patient *patient;
- (IBAction)composeMail:(id)sender;
@end
