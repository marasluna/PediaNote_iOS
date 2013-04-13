//
//  AppDelegate.m
//  TestProject
//
//  Created by Team Ganda on 2/26/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "Doctor.h"
#import "ViewController.h"
#import "Patient.h"
#import "Consultation.h"
#import "History.h"
#import "CoreDateHelper.h"
#import "Report.h"
#import "Doctor.h"
#import "ViewController.h"
#import "Patient.h"
#import "CoreDateHelper.h"
#import "AppointmentsTVC.h"
#import "AppointmentsDetail.h"
#import "AccountSettingsTVC.h"
#import "DoctorProfile.h"
#import "LogOutViewController.h"
#import "PatientTVC.h"
#import "PatientProfile.h"

@implementation AppDelegate

@synthesize tabBarController = _tabBarController;
@synthesize window = _window;
@synthesize managedObjectContext = __managedObjectContext;
@synthesize managedObjectModel = __managedObjectModel;
@synthesize persistentStoreCoordinator = __persistentStoreCoordinator;
@synthesize fetchedResultsController = __fetchedResultsController;
@synthesize actionSheet;


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {

    if(buttonIndex==1){
    NSMutableArray *arr = [CoreDataHelper getObjectsForEntity:@"Doctor" withSortKey:nil andSortAscending:YES andContext:self.managedObjectContext];
    Doctor *doctor = [arr objectAtIndex:0];
    doctor.isLoggedIn = [NSNumber numberWithBool:NO];
    
    NSError *error;
    if (![self.managedObjectContext save:&error])
        NSLog(@"Failed to add default user with error: %@", [error domain]);
    
    [self userLogsOut]; 
    }else{
        self.tabBarController.selectedIndex = 0;
    }
    
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    
    if (tabBarController.selectedIndex == 3)
    {
        
          
        
        self.actionSheet = [[UIActionSheet alloc] initWithTitle:@"Are you sure you want to log out?" delegate: self cancelButtonTitle:@"Cancel" destructiveButtonTitle: @"Cancel"
                                                       otherButtonTitles: @"YES", nil];
        self.actionSheet.delegate = self;
        

           [actionSheet showInView:self.window];
     
        

        
    }
    
    
}


- (void) userLogsOut{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:[NSBundle mainBundle]];
    [self.window setRootViewController:[mainStoryboard instantiateViewControllerWithIdentifier:@"logIn"]];
    ViewController *rootView = (ViewController *)self.window.rootViewController;
    rootView.managedObjectContext = self.managedObjectContext;
    rootView.appDelegate = self;
    
    [self.window setRootViewController:rootView];
    [self.window makeKeyAndVisible];
    
}

- (void) prepareViewControllers{
    // Get reference to the destination view controller
    self.tabBarController = (UITabBarController *)self.window.rootViewController;
    
    
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

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    if ([prefs boolForKey:@"hasRunBefore"] != YES)
    {
        [prefs setBool:YES forKey:@"hasRunBefore"];
        [prefs synchronize];
        Doctor *user = (Doctor *)[NSEntityDescription insertNewObjectForEntityForName:@"Doctor" inManagedObjectContext:self.managedObjectContext];
        user.username = @"doctor";
        user.password = @"password";
        user.isLoggedIn = [NSNumber numberWithBool:NO];

        
        // Commit to core data
        NSError *error;
        if (![self.managedObjectContext save:&error])
            NSLog(@"Failed to add default user with error: %@", [error domain]);
        
    }

    
    UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window = window;
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:[NSBundle mainBundle]];
    

    NSMutableArray *arr = [CoreDataHelper getObjectsForEntity:@"Doctor" withSortKey:nil andSortAscending:YES andContext:self.managedObjectContext];
    if([arr count]==1){
            NSLog(@"HERE");
        Doctor *doc = [arr objectAtIndex:0];
        
        
        if([[NSNumber numberWithBool:NO] isEqualToNumber: doc.isLoggedIn]){
            [window setRootViewController:[mainStoryboard instantiateViewControllerWithIdentifier:@"logIn"]];
            ViewController *rootView = (ViewController *)self.window.rootViewController;
            rootView.managedObjectContext = self.managedObjectContext;
            rootView.appDelegate = self;
        }
        else{
            [window setRootViewController:[mainStoryboard instantiateViewControllerWithIdentifier:@"tabBarController"]];
            [self prepareViewControllers];
        }
        
    }
    
    
    self.tabBarController.delegate = self;
    [window makeKeyAndVisible];

       return YES;
    
}

		
- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}


- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil)
    {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error])
        {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *)managedObjectContext
{
    if (__managedObjectContext != nil)
    {
        return __managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil)
    {
        __managedObjectContext = [[NSManagedObjectContext alloc] init];
        [__managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return __managedObjectContext;
}

/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
- (NSManagedObjectModel *)managedObjectModel
{
    if (__managedObjectModel != nil)
    {
        return __managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
    __managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return __managedObjectModel;
}

/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (__persistentStoreCoordinator != nil)
    {
        return __persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"StaffManager.sqlite"];
    
    NSError *error = nil;
    __persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    
    
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, 
                             [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
    if (![__persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error])
    {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter: 
         [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return __persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

/**
 Returns the URL to the application's Documents directory.
 */
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
