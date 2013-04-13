//
//  ViewController.m
//  TestProject
//
//  Created by Team Ganda on 2/26/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"


@implementation ViewController
@synthesize username = _username;
@synthesize password = _password;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize tabBarController;
@synthesize appDelegate = _appDelegate;
@synthesize imageView;
@synthesize logInButton;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

	// Do any additional setup after loading the view, typically from a nib.
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];

    
}

- (void)viewDidUnload
{

    [self setUsername:nil];
    [self setPassword:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    
    self.username.keyboardType = UIKeyboardTypeEmailAddress;
    self.username.returnKeyType = UIReturnKeyNext;
    
    self.password.keyboardType = UIKeyboardTypeDefault;
    self.password.returnKeyType = UIReturnKeyDone;
    self.password.secureTextEntry = YES;
    
    [self.username setDelegate:self];
    [self.password setDelegate:self];
    [super viewWillAppear:animated];
}


- (void)textFieldDidBeginEditing:(UITextField *)textField {	
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationBeginsFromCurrentState:YES];
    self.username.frame = CGRectMake(self.username.frame.origin.x, (self.username.frame.origin.y - 155.0), self.self.username.frame.size.width, self.username.frame.size.height);
    
    self.password.frame = CGRectMake(self.password.frame.origin.x, (self.password.frame.origin.y - 155.0), self.password.frame.size.width, self.password.frame.size.height);
    self.imageView.frame =CGRectMake(self.imageView.frame.origin.x, self.imageView.frame.origin.y - 120.00, self.imageView.frame.size.width, self.imageView.frame.size.height);
    self.logInButton.frame =CGRectMake(self.logInButton.frame.origin.x, self.logInButton.frame.origin.y - 155.00, self.logInButton.frame.size.width, self.logInButton.frame.size.height);    
    [UIView commitAnimations];
    
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationBeginsFromCurrentState:YES];
    self.username.frame = CGRectMake(self.username.frame.origin.x, (self.username.frame.origin.y + 155.0), self.username.frame.size.width, self.username.frame.size.height);
    
    self.password.frame = CGRectMake(self.password.frame.origin.x, (self.password.frame.origin.y + 155.0), self.password.frame.size.width, self.password.frame.size.height);
    self.imageView.frame =CGRectMake(self.imageView.frame.origin.x, self.imageView.frame.origin.y + 120.00, self.imageView.frame.size.width, self.imageView.frame.size.height);
    self.logInButton.frame =CGRectMake(self.logInButton.frame.origin.x, self.logInButton.frame.origin.y + 155.00, self.logInButton.frame.size.width, self.logInButton.frame.size.height);    
    
    [UIView commitAnimations];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if (textField == self.username){
        [self.username resignFirstResponder];
        [self.password becomeFirstResponder];
    }
    else if(textField == self.password){
        [self.password resignFirstResponder];
        [self login];
    }
    
    
    return YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight || interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}

- (IBAction)login {
    
    //  Set up a predicate (or search criteria) for checking the username and password
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"(username == %@ && password == %@)", self.username.text, self.password.text];
    NSMutableArray *arr = [CoreDataHelper searchObjectsForEntity:@"Doctor" withPredicate:pred andSortKey:nil andSortAscending:YES andContext:self.managedObjectContext];
    if ([arr count] > 0){
        //  We found a matching login user!  Force the segue transition to the next view
        Doctor *doc = [arr objectAtIndex:0];
        doc.isLoggedIn = [NSNumber numberWithBool:YES];
        
        // Commit to core data
        NSError *error;
        if (![self.managedObjectContext save:&error])
            NSLog(@"Failed to add default user with error: %@", [error domain]);
        
        [self performSegueWithIdentifier:@"goToTabBar" sender:self];
        
    }else
        //  We didn't find any matching login users. Wipe the password field to re-enter
        [self.password setText:@""];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"goToTabBar"])
    {

        // Get reference to the destination view controller
        self.tabBarController = [segue destinationViewController];
        self.tabBarController.delegate = self.appDelegate;
        
        /* 
         *Set up SPLIT VIEW for Appointments
         */
        UISplitViewController *appointmentSVC = [[self.tabBarController viewControllers] objectAtIndex:0];
        
        // Set up Split View MASTER view for Appointments                
        UINavigationController *appointmentNav = [appointmentSVC.viewControllers objectAtIndex:0];
        appointmentSVC.delegate = (id)appointmentNav.topViewController;
        AppointmentsTVC *appointmentsTVC = [[appointmentNav viewControllers] objectAtIndex:0]; 
        appointmentsTVC.managedObjectContext = self.managedObjectContext; 
        
        // Set up Split View DETAIL view for Appointments
        AppointmentsDetail *appointmentsDetail = [appointmentSVC.viewControllers objectAtIndex:1];
        appointmentsDetail.managedObjectContext = self.managedObjectContext;
        
        // Set up MASTER and DETAIL delegation so we can send messages between views
        appointmentsTVC.delegate = appointmentsDetail;
        appointmentsDetail.delegate = appointmentsTVC;

        
        
        /* 
         *Set up SPLIT VIEW for Patients
         */
    
        // Set up SPLIT VIEW for Patient
        UISplitViewController *patientSVC = [[self.tabBarController viewControllers] objectAtIndex:1];
        NSLog(@"patientsplit");
        
        // Set up Split View MASTER view for Patient              
        UINavigationController *patientNav = [patientSVC.viewControllers objectAtIndex:0];
        patientSVC.delegate = (id)patientNav.topViewController;
        PatientTVC *patientTVC = [[patientNav viewControllers] objectAtIndex:0]; 
        patientTVC.managedObjectContext = self.managedObjectContext; 
        NSLog(@"patientdetail");
        
        UINavigationController *patientDetailNav = [patientSVC.viewControllers objectAtIndex:1];
        patientSVC.delegate = (id)patientDetailNav.topViewController;
        PatientProfile *patientProfile = [[patientDetailNav viewControllers] objectAtIndex:0]; 
        patientProfile.managedObjectContext = self.managedObjectContext; 
        NSLog(@"patientdetail..");

        // Set up MASTER and DETAIL delegation so we can send messages between views
        patientTVC.delegate = patientProfile;
        //patientProfile.delegate = patientTVC;
        
        
        /* 
         *Set up SPLIT VIEW for Account Settings
         */
        UISplitViewController *accountSettingsSVC = [[self.tabBarController viewControllers] objectAtIndex:2];
        
        
        // Set up Split View MASTER view for Account Settings            
        UINavigationController *accountSettingsNav = [accountSettingsSVC.viewControllers objectAtIndex:0];
        accountSettingsSVC.delegate = (id)accountSettingsNav.topViewController;
        AccountSettingsTVC *accountSettingsTVC = [[accountSettingsNav viewControllers] objectAtIndex:0]; 
        accountSettingsTVC.managedObjectContext = self.managedObjectContext; 
        
        // Set up Split View DETAIL view for Account Settings
        UINavigationController *detailNav = [accountSettingsSVC.viewControllers objectAtIndex:1];
        DoctorProfile *doctorProfile = (id)detailNav.topViewController;
        doctorProfile.managedObjectContext = self.managedObjectContext;
        
        /* 
         *Set up SPLIT VIEW for Log Out
         */
        LogOutViewController *logOut = [[self.tabBarController viewControllers] objectAtIndex:3];
        logOut.managedObjectContext = self.managedObjectContext;



    }
}

-(void)dismissKeyboard {
    [self.username resignFirstResponder];
    [self.password resignFirstResponder];
}


@end
