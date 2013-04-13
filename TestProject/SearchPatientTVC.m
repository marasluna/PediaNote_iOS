//
//  SearchPatientTVC.m
//  TestProject
//
//  Created by Team Ganda on 3/8/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "SearchPatientTVC.h"


@implementation SearchPatientTVC
@synthesize managedObjectContext;
@synthesize appointment;
@synthesize patientArray;
@synthesize searchResults;
@synthesize cameFromAdd;
@synthesize addDelegate;
@synthesize editDelegate;
@synthesize patient;

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{


    self.patientArray = [CoreDataHelper getObjectsForEntity:@"Patient" withSortKey:@"lastName" andSortAscending: YES andContext:self.managedObjectContext];
   
    if(self.patientArray !=nil)
        NSLog(@"COUNT: %d", [self.patientArray count]);
    
    self.searchResults = [[NSMutableArray alloc] initWithCapacity:[self.patientArray count]];
    [super viewDidLoad];


}

- (void)viewDidUnload{

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
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [self.searchResults count];
        
    } else {
        if(self.patientArray ==nil)
            return 0;
        else 
            return [self.patientArray count];
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    Patient *pat;
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        pat = [self.searchResults objectAtIndex:indexPath.row];
    } else {
        pat = [self.patientArray objectAtIndex:indexPath.row];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", pat.firstName, pat.lastName];

    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSLog(@"FROM PATIENT ARRAY: %@", [self.patientArray objectAtIndex:indexPath.row]);
    NSLog(@"PATIENT: %@", self.appointment.patient);
    

    if(self.cameFromAdd == 0){
     //   NSLog(@"came from delegate");
        //self.appointment.patient = nil;
        NSLog(@"edit patient: %@", self.appointment.patient);
        self.appointment.patient = [self.patientArray objectAtIndex:indexPath.row];
        [self.editDelegate patientSelected];
        
    }else{
        //self.appointment.patient = nil;
        NSLog(@"self.appointment: %@", self.appointment);
        self.patient = [self.patientArray objectAtIndex:indexPath.row];
        self.appointment.patient = self.patient;
        
        //NSLog(@"add patient: %@", self.appointment.patient);
        //self.appointment.patient = 
        

        NSLog(@"Came from Add");
       
        [self.addDelegate patientSelected];
    }
    
}

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate 
                                    predicateWithFormat:@"(firstName beginswith[cd] %@) OR (lastName beginswith[cd] %@)",
                                    searchText, searchText];
    
    self.searchResults = [self.patientArray filteredArrayUsingPredicate:resultPredicate];
   
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller 
shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString 
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    
    return YES;
}


@end
