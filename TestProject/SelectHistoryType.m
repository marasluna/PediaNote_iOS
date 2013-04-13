//
//  SelectHistoryType.m
//  TestProject
//
//  Created by BerDy on 1/20/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "SelectHistoryType.h"
#import "AddHistory.h"
#import "AddImmunization.h"

@implementation SelectHistoryType

@synthesize delegate1;
@synthesize delegate2;
@synthesize delegate3;
@synthesize delegate4;
@synthesize patient;
@synthesize managedObjectContext;
@synthesize historyType;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
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
	return YES;
}

- (IBAction)cancel:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"prepare report");
    if ([[segue identifier] isEqualToString:@"AllergySegue"])
    {
        NSLog(@"pass1");
        AddHistory *addHistory = [segue destinationViewController];
        addHistory.managedObjectContext = self.managedObjectContext;
        NSLog(@"manage select 1 %@", self.managedObjectContext);
        addHistory.delegate = self.delegate1;
        addHistory.patient = self.patient;
        addHistory.historyType = @"Allergy";
    }
    
    if ([[segue identifier] isEqualToString:@"PastSegue"])
    {
        NSLog(@"pass2");
        AddHistory *addHistory = [segue destinationViewController];
        addHistory.managedObjectContext = self.managedObjectContext;
        NSLog(@"manage select 2 %@", self.managedObjectContext);
        addHistory.delegate = self.delegate2;
        addHistory.patient = self.patient;
        addHistory.historyType = @"Past Illness";
    }
    
    if ([[segue identifier] isEqualToString:@"FamilySegue"])
    {
        NSLog(@"pass");
        NSLog(@"manage select 3 %@", self.managedObjectContext);
        AddHistory *addHistory = [segue destinationViewController];
        addHistory.managedObjectContext = self.managedObjectContext;
        addHistory.delegate = self.delegate3;
        addHistory.patient = self.patient;
        addHistory.historyType = @"Family History";
    }
    
    if ([[segue identifier] isEqualToString:@"ImmunizationSegue"])
    {
        AddImmunization *addImmunization = [segue destinationViewController];
        addImmunization.managedObjectContext = self.managedObjectContext;
        addImmunization.delegate = self.delegate4;
        addImmunization.patient = self.patient;
        NSLog(@"add immune select history patient %@", self.patient.firstName);
    }
    
}

@end
