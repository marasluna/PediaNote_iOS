//
//  Clinics.m
//  TestProject
//
//  Created by Team Ganda on 3/13/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "Clinics.h"


@implementation Clinics
@synthesize managedObjectContext;
@synthesize clinicArray;
@synthesize popover;
@synthesize clinic;

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    

    self.clinicArray = [CoreDataHelper getObjectsForEntity:@"Clinic" withSortKey:@"name" andSortAscending:YES andContext:self.managedObjectContext];
    
    
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
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    
    return [self.clinicArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        static NSString *CellIdentifier = @"Cell";
        ClinicTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[ClinicTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
    
        Clinic *clin = [self.clinicArray objectAtIndex:indexPath.row];
        cell.name.text = clin.name;
        cell.location.text = clin.location;
        cell.schedule.text = clin.schedule;
        return cell;
       
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section

{ 
    return @"Name                                   Location                            Hours";
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.clinic = [self.clinicArray objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"editClinic" sender:self];
   // [self presentModalViewController:myNewVC animated:YES];    
}

- (void)prepareForSegue:(UIStoryboardPopoverSegue *)segue sender:(id)sender
{
   if ([[segue identifier] isEqualToString:@"addClinic"])
    {
        UINavigationController *nav = [segue destinationViewController];
        
        // Get reference to the destination view controller
        AddClinic *vc = (id)nav.topViewController;
        //self.popover = [[UIPopoverController alloc]initWithContentViewController:nav];
        vc.managedObjectContext = self.managedObjectContext;
        vc.delegate = self;
        
        self.popover = [(UIStoryboardPopoverSegue *)segue popoverController];
        
    }
    
    else if ([[segue identifier] isEqualToString:@"editClinic"])
    {
        UINavigationController *nav = [segue destinationViewController];
        
        // Get reference to the destination view controller
        EditClinicTable *vc = (id)nav.topViewController;
        //self.popover = [[UIPopoverController alloc]initWithContentViewController:nav];
        vc.managedObjectContext = self.managedObjectContext;
        vc.delegate = self;
        vc.clinic = self.clinic;
        //self.popover = [(UIStoryboardPopoverSegue *)segue popoverController];
        
    }
    
    
}


- (void) didClickSave{
   if(self.popover!=nil){
        [self.popover dismissPopoverAnimated:YES];
   }
    
    self.clinicArray = [CoreDataHelper getObjectsForEntity:@"Clinic" withSortKey:@"name" andSortAscending:YES andContext:self.managedObjectContext];
    
    [self.tableView reloadData];
    
}

- (void) editSsave{

    
    self.clinicArray = [CoreDataHelper getObjectsForEntity:@"Clinic" withSortKey:@"name" andSortAscending:YES andContext:self.managedObjectContext];
    
    [self.tableView reloadData];
    
}


@end
