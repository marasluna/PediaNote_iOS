//
//  PatientTVC.m
//  TestProject
//
//  Created by BerDy on 1/11/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "PatientTVC.h"
#import "CoreDateHelper.h"
#import "Patient.h"
#import "Parent.h"
#import "PatientAdd.h"
#import "PatientKey.h"
@implementation PatientTVC

@synthesize managedObjectContext;
@synthesize delegate;
@synthesize patientDataList;
@synthesize recentPatient;
@synthesize parentMatched;
@synthesize searchBar;
@synthesize searchResults;
@synthesize alphabetArray;
@synthesize patientHeader;

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



- (void) assignHeaderArray{
    
    //  if (tableView == self.searchDisplayController.searchResultsTableView) {
    //return [self.searchResults count];
    //  }
    // else{
    // Return the number of rows in the section.
    //return [self.patientDataList count];
    
    int i =0;
    self.patientHeader = [[NSMutableArray alloc]init];
    //PatientKey * pkey;
    PatientKey *currentKey;
    for( Patient *p in self.patientDataList){
        
        
        if([self.patientHeader count]==0){
            currentKey = [[PatientKey alloc]init];
            currentKey.header = [NSString stringWithFormat:@"%c",[p.firstName characterAtIndex:0]];
            currentKey.startCell = i;
            currentKey.numberOfRows = 0;
            [self.patientHeader addObject:currentKey];
            
            
        }else if(![ currentKey.header isEqualToString:[NSString stringWithFormat:@"%c",[p.firstName characterAtIndex:0]]]){
            currentKey = [[PatientKey alloc]init];
            currentKey.header = [NSString stringWithFormat:@"%c",[p.firstName characterAtIndex:0]];
            //i++;
            currentKey.startCell = i;
            currentKey.numberOfRows = 0;
            //[self.patientHeader addObject:[NSString stringWithFormat:@"%c",[p.lastName characterAtIndex:0]]];
            
            
            //PatientKey *key1 = [self.patientHeader lastObject];
            //key1.numberOfRows = key.startCell - key1.startCell;
            [self.patientHeader addObject:currentKey];
            
            
        }
        //pkey = currentKey;
        i++;        
        currentKey.numberOfRows +=1;
    }
    

}



- (void)viewDidLoad
{
    
    [super viewDidLoad];
    NSLog(@"enter patienttvc");
    self.patientDataList = [CoreDataHelper getObjectsForEntity:@"Patient" withSortKey:@"firstName" andSortAscending:YES andContext:managedObjectContext];
    NSLog(@"enter patienttvc");
    self.searchResults = [[NSMutableArray alloc] initWithCapacity:[self.patientDataList count]];
    
    
    self.alphabetArray = [[NSMutableArray alloc] init];
    [self.alphabetArray addObject:@"A"];
    [self.alphabetArray addObject:@"B"];
    [self.alphabetArray addObject:@"C"];
    [self.alphabetArray addObject:@"D"];
    [self.alphabetArray addObject:@"E"];
    [self.alphabetArray addObject:@"F"];
    [self.alphabetArray addObject:@"G"];
    [self.alphabetArray addObject:@"H"];
    [self.alphabetArray addObject:@"I"];
    [self.alphabetArray addObject:@"J"];
    [self.alphabetArray addObject:@"K"];
    [self.alphabetArray addObject:@"L"];
    [self.alphabetArray addObject:@"M"];
    [self.alphabetArray addObject:@"N"];
    [self.alphabetArray addObject:@"O"];
    [self.alphabetArray addObject:@"P"];
    [self.alphabetArray addObject:@"Q"];
    [self.alphabetArray addObject:@"R"];
    [self.alphabetArray addObject:@"S"];
    [self.alphabetArray addObject:@"T"];
    [self.alphabetArray addObject:@"U"];
    [self.alphabetArray addObject:@"V"];
    [self.alphabetArray addObject:@"W"];
    [self.alphabetArray addObject:@"Y"];
    [self.alphabetArray addObject:@"X"];
    [self.alphabetArray addObject:@"Z"];
    
    
    
    [self assignHeaderArray];

}

- (void)viewDidUnload
{
    [self setSearchBar:nil];
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

#pragma mark - Table view data source

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    
    return self.alphabetArray;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    int i=0;
    
    for(PatientKey *key in self.patientHeader){
        
        if([key.header isEqualToString:title]){
            return i;
        }
        i++;
    }
    return 0;//[indices indexOfObject:title];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return 1;
    }
    else
        // Return the number of rows in the section.
        return [self.patientHeader count];
    
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return @"Search Results";
    }
    else{
        PatientKey *key = [self.patientHeader objectAtIndex:section];
        return key.header;
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [self.searchResults count];
    }
    else{
        // Return the number of rows in the section.
        PatientKey *key = [self.patientHeader objectAtIndex:section];
        return key.numberOfRows;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Patient *patient;
    
    NSLog(@"haha");
    static NSString *CellIdentifier = @"Patient Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        patient = [self.searchResults objectAtIndex:indexPath.row];
    } else {
        PatientKey * key = [self.patientHeader objectAtIndex:indexPath.section];
        //NSLog(@"KEY, %d %d %d", key.startCell, indexPath.row, key.startCell + indexPath.row);
        patient = [self.patientDataList objectAtIndex:key.startCell + indexPath.row ];
    }
    
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", patient.firstName, patient.lastName];
    
    
    NSSet *pset = patient.parents;
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"type == 'guardian'"];
    
    NSSet *filteredSet = [pset filteredSetUsingPredicate:pred];
    Parent *parent;
    
    if([filteredSet count]==1){
        parent = [filteredSet anyObject];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ %@ - %@", parent.firstName, parent.lastName, parent.cellphone];
    }
    // else cell.detailTextLabel.text = [NSString stringWithFormat:@"", parent.firstName, parent.lastName, parent.cellphone];
    
    
    //NSPredicate *pred = [NSPredicate predicateWithFormat: @"(patientt.firstName CONTAINS[cd] %@) AND (type LIKE[cd] %@)", patient.firstName, @"guardian"];
    //self.parentMatched = [CoreDataHelper searchObjectsForEntity:@"Parent" withPredicate:pred andSortKey:@"firstName" andSortAscending:YES andContext:self.managedObjectContext];
    //Parent *parent = [self.parentMatched objectAtIndex:0];    
    
    //cell.detailTextLabel.text = [NSString stringWithFormat:@"", parent.firstName, parent.lastName, parent.cellphone];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"Patient: %@",[self.patientDataList objectAtIndex:indexPath.row]);
    //NSLog(@"delegate %@", self.delegate);
    
    PatientKey * key = [self.patientHeader objectAtIndex:indexPath.section];
    [self.delegate seePatientDetail:[self.patientDataList objectAtIndex:key.startCell + indexPath.row ]];
    //NSLog(@"get did select");
    
    
}

-(IBAction)add:(id)sender
{
    NSLog(@"add");
    [self performSegueWithIdentifier:@"AddPatientSegue" sender:self];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"prepare");
    
    if ([[segue identifier] isEqualToString:@"AddPatientSegue"])
    {
        UINavigationController *patientAddNav = [segue destinationViewController];
        PatientAdd *patientAdd = [[patientAddNav viewControllers] objectAtIndex:0];
        patientAdd.managedObjectContext = self.managedObjectContext;
        patientAdd.delegate = self;
    }
}
-(void)savePatient:(Patient *)patient
{
    NSLog(@"save patient");
    self.patientDataList = [CoreDataHelper getObjectsForEntity:@"Patient" withSortKey:@"firstName" andSortAscending:YES andContext:self.managedObjectContext];
    //NSLog(@"COUNT: %d", patientDataList.count);
    [self assignHeaderArray];
    [self.tableView reloadData];
    //NSLog(@"after reload");
}

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate 
                                    predicateWithFormat:@"(firstName beginswith[cd] %@) OR (lastName beginswith[cd] %@) OR (clinic.name beginswith[cd] %@)",
                                    searchText, searchText, searchText];
    
    self.searchResults = [self.patientDataList filteredArrayUsingPredicate:resultPredicate];
    
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
