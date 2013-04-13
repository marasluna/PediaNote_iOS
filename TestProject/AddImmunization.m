//
//  AddImmunization.m
//  TestProject
//
//  Created by BerDy on 1/20/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "AddImmunization.h"
#import "Immunization.h"
#import "CoreDateHelper.h"
@implementation AddImmunization

@synthesize patient;
@synthesize delegate;
@synthesize managedObjectContext;
@synthesize immunization;
@synthesize typeLabel;
@synthesize doseLabel;
@synthesize selectVaccine;
@synthesize selectDose;
@synthesize typeRow;
@synthesize doseRow;

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
    [self setTypeLabel:nil];
    [self setDoseLabel:nil];
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

-(IBAction)saveImmunization:(id)sender
{
    NSLog(@"save immunization");
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"patientt.firstName == %@", self.patient.firstName];
    NSMutableArray *arr = [CoreDataHelper searchObjectsForEntity:@"Immunization" withPredicate:pred andSortKey:nil andSortAscending:NO andContext:self.managedObjectContext];
    
    if([arr count]>0){
        self.immunization = [arr objectAtIndex:0];
    
    //(Immunization *) [NSEntityDescription insertNewObjectForEntityForName:@"Immunization" inManagedObjectContext:self.managedObjectContext];
    
    
    NSLog(@"typeRow: %d", self.typeRow);
    NSLog(@"doseRow: %d", self.doseRow);
    
    if (self.typeRow == 0)
    {
        if (self.doseRow == 0) immunization.bcg1 = [NSDate date];
        else if (self.doseRow == 1) immunization.bcg2 = [NSDate date];
        else if (self.doseRow == 2) immunization.bcg3 = [NSDate date];
        else if (self.doseRow == 3) immunization.bcg4 = [NSDate date];
        else if (self.doseRow == 4) immunization.bcg5 = [NSDate date];
        else if (self.doseRow == 5) immunization.bcg6 = [NSDate date];
    }
    
    else if (self.typeRow == 1)
    {
        if (self.doseRow == 0) immunization.hepa1 = [NSDate date];
        else if (self.doseRow == 1) immunization.hepa2 = [NSDate date];
        else if (self.doseRow == 2) immunization.hepa3 = [NSDate date];
        else if (self.doseRow == 3) immunization.hepa4 = [NSDate date];
        else if (self.doseRow == 4) immunization.hepa5 = [NSDate date];
        else if (self.doseRow == 5) immunization.hepa6 = [NSDate date];
    }
    
    else if (self.typeRow == 2)
    {
        if (self.doseRow == 0) immunization.d1 = [NSDate date];
        else if (self.doseRow == 1) immunization.d2 = [NSDate date];
        else if (self.doseRow == 2) immunization.d3 = [NSDate date];
        else if (self.doseRow == 3) immunization.d4 = [NSDate date];
        else if (self.doseRow == 4) immunization.d5 = [NSDate date];
        else if (self.doseRow == 5) immunization.d6 = [NSDate date];
    }
    
    else if (self.typeRow == 3)
    {
        if (self.doseRow == 0) immunization.o1 = [NSDate date];
        else if (self.doseRow == 1) immunization.o2 = [NSDate date];
        else if (self.doseRow == 2) immunization.o3 = [NSDate date];
        else if (self.doseRow == 3) immunization.o4 = [NSDate date];
        else if (self.doseRow == 4) immunization.o5 = [NSDate date];
        else if (self.doseRow == 5) immunization.o6 = [NSDate date];
    }
    
    else if (self.typeRow == 4)
    {
        if (self.doseRow == 0) immunization.measles1 = [NSDate date];
        else if (self.doseRow == 1) immunization.measles2 = [NSDate date];
        else if (self.doseRow == 2) immunization.measles3 = [NSDate date];
        else if (self.doseRow == 3) immunization.measles4 = [NSDate date];
        else if (self.doseRow == 4) immunization.measles5 = [NSDate date];
        else if (self.doseRow == 5) immunization.measles6 = [NSDate date];
    }
    
    else if (self.typeRow == 5)
    {
        if (self.doseRow == 0) immunization.influenzaB1 = [NSDate date];
        else if (self.doseRow == 1) immunization.influenzaB2 = [NSDate date];
        else if (self.doseRow == 2) immunization.influenzaB3 = [NSDate date];
        else if (self.doseRow == 3) immunization.influenzaB4 = [NSDate date];
        else if (self.doseRow == 4) immunization.influenzaB5 = [NSDate date];
        else if (self.doseRow == 5) immunization.influenzaB6 = [NSDate date];
    }
    
    else if (self.typeRow == 6)
    {
        if (self.doseRow == 0) immunization.rota1 = [NSDate date];
        else if (self.doseRow == 1) immunization.rota2 = [NSDate date];
        else if (self.doseRow == 2) immunization.rota3 = [NSDate date];
        else if (self.doseRow == 3) immunization.rota4 = [NSDate date];
        else if (self.doseRow == 4) immunization.rota5 = [NSDate date];
        else if (self.doseRow == 5) immunization.rota6 = [NSDate date];
    }
    
    else if (self.typeRow == 7)
    {
        if (self.doseRow == 0) immunization.influenza1 = [NSDate date];
        else if (self.doseRow == 1) immunization.influenza2 = [NSDate date];
        else if (self.doseRow == 2) immunization.influenza3 = [NSDate date];
        else if (self.doseRow == 3) immunization.influenza4 = [NSDate date];
        else if (self.doseRow == 4) immunization.influenza5 = [NSDate date];
        else if (self.doseRow == 5) immunization.influenza6 = [NSDate date];
    }
    
    else if (self.typeRow == 8)
    {
        if (self.doseRow == 0) immunization.mmr1 = [NSDate date];
        else if (self.doseRow == 1) immunization.mmr2 = [NSDate date];
        else if (self.doseRow == 2) immunization.mmr3 = [NSDate date];
        else if (self.doseRow == 3) immunization.mmr4 = [NSDate date];
        else if (self.doseRow == 4) immunization.mmr5 = [NSDate date];
        else if (self.doseRow == 5) immunization.mmr6 = [NSDate date];
    }
    
    else if (self.typeRow == 9)
    {
        if (self.doseRow == 0) immunization.typhoid1 = [NSDate date];
        else if (self.doseRow == 1) immunization.typhoid2 = [NSDate date];
        else if (self.doseRow == 2) immunization.typhoid3 = [NSDate date];
        else if (self.doseRow == 3) immunization.typhoid4 = [NSDate date];
        else if (self.doseRow == 4) immunization.typhoid5 = [NSDate date];
        else if (self.doseRow == 5) immunization.typhoid6 = [NSDate date];
    }
  
    self.patient.immunizations = immunization;
    
    NSError *error;
    if (![self.managedObjectContext save:&error])
        NSLog(@"Failed to add default user with error: %@", [error domain]);
    
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"MMMM dd, YYYY"];
    
    NSLog(@"immune hepa 6 %@",[NSString stringWithFormat:@"2 %@", [dateformatter stringFromDate:immunization.hepa6]]);
    NSLog(@"immune d 6 %@",[NSString stringWithFormat:@"2 %@", [dateformatter stringFromDate:immunization.d6]]);
    
    NSLog(@"add immune patient: %@", self.patient.firstName);
    [self.delegate saveImmunizationTable];
    }

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"prepare add");
    if ([[segue identifier] isEqualToString:@"SelectVaccineSegue"])
    {
        self.selectVaccine = [segue destinationViewController];
        self.selectVaccine.delegate = self;
        self.selectVaccine.managedObjectContext = self.managedObjectContext;
    }
    if ([[segue identifier] isEqualToString:@"SelectDoseSegue"])
    {
        self.selectDose = [segue destinationViewController];
        self.selectDose.delegate = self;
        self.selectDose.managedObjectContext = self.managedObjectContext;
    }
}

- (IBAction)cancel:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)getVaccine:(NSInteger)row
{
    NSLog(@"get vaccine add");
    self.typeRow = row;
    if (row == 0) {
        self.typeLabel.text = @"BCG";
    }
    else if (row == 1) {
        self.typeLabel.text = @"Hepatitis A";
    }
    else if (row == 2) {
        self.typeLabel.text = @"DTwP/DTaP";
    }
    else if (row == 3) {
        self.typeLabel.text = @"OPV/TVP";
    }
    else if (row == 4) {
        self.typeLabel.text = @"Measles";
    }
    else if (row == 5) {
        self.typeLabel.text = @"H. Influenza type B";
    }
    else if (row == 6) {
        self.typeLabel.text = @"Rotavirus";
    }
    else if (row == 7) {
        self.typeLabel.text = @"Influenza";
    }
    else if (row == 8) {
        self.typeLabel.text = @"MMR";
    }
    else self.typeLabel.text = @"Typhoid";
}

- (void)getDose:(NSInteger)row
{
    NSLog(@"get vaccine add");
    self.doseRow = row;
    if (row == 0) {
        self.doseLabel.text = @"1st";
    }
    else if (row == 1) {
        self.doseLabel.text = @"2nd";
    }
    else if (row == 2) {
        self.doseLabel.text = @"3rd";
    }
    else if (row == 3) {
        self.doseLabel.text = @"Booster1";
    }
    else if (row == 4) {
        self.doseLabel.text = @"Booster2";
    }
    else if (row == 5) {
        self.doseLabel.text = @"Booster3";
    }
}



@end
