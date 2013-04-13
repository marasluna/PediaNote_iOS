//
//  ViewController.h
//  TestProject
//
//  Created by Team Ganda on 2/26/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "CoreDateHelper.h"
#import "AppointmentsTVC.h"
#import "AppointmentsDetail.h"
#import "PatientTVC.h"
#import "PatientProfile.h"
#import "AccountSettingsTVC.h"
#import "DoctorProfile.h"
#import "LogOutViewController.h"
#import "AppDelegate.h"
@interface ViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) IBOutlet UITextField *username;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) AppDelegate *appDelegate;
@property (strong, nonatomic) UITabBarController *tabBarController;
- (IBAction)login;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIButton *logInButton;


@end
