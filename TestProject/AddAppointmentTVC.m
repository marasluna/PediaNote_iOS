//
//  AddAppointmentTVC.m
//  TestProject
//
//  Created by Team Ganda on 3/1/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "AddAppointmentTVC.h"
#import "CoreDateHelper.h"
#import "SelectSchedule.h"
#import "Patient.h"

@implementation AddAppointmentTVC
@synthesize delegate = _delegate;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize appointment = _appointment;
@synthesize patientCell = _patientCell;
@synthesize dateLabel = _dateLabel;
@synthesize startTimeLabel = _startTimeLabel;
@synthesize endTimeLabel = _endTimeLabel;
@synthesize notesLabel = _notesLabel;
@synthesize didSave = _didSave;
@synthesize editing = _editing;
@synthesize shouldAdd = _shouldAdd;

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
    
    
    [self setPatientCell:nil];
    [self setDateLabel:nil];
    [self setStartTimeLabel:nil];
    [self setEndTimeLabel:nil];
    [self setNotesLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    if(self.shouldAdd == YES){
        NSLog(@"Adding an APPOINTMENT");
        //ADD APPOINTMENT
        self.appointment = (Appointment *)[NSEntityDescription insertNewObjectForEntityForName:@"Appointment" inManagedObjectContext:self.managedObjectContext];
        
        // Commit to core data
        NSError *error;
        if (![self.managedObjectContext save:&error])
            NSLog(@"Failed to add default user with error: %@", [error domain]);
        
        self.editing = NO;
        self.didSave = NO;
        self.shouldAdd = NO;
    }
    
    
    
    
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    [f setDateFormat:@"MMMM dd, YYYY"];
    self.dateLabel.text = [f stringFromDate:self.appointment.date];
    [f setDateFormat:@"hh:mm a"];
    self.startTimeLabel.text = [f stringFromDate:self.appointment.startTime];
    self.endTimeLabel.text = [f stringFromDate:self.appointment.endTime];
    self.notesLabel.text = self.appointment.notes;
    
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    NSLog(self.didSave ? @"DIDSAVE ADD: Yes" : @"DIDSAVE ADD: No");
    NSLog(self.editing ? @"EDITING: Yes" : @"EDITING: No");
    if(self.didSave==NO && self.editing==NO){
        [CoreDataHelper deleteAllObjectsForEntity:@"Appointment" withPredicate:[NSPredicate predicateWithFormat:@"self == %@", self.appointment] andContext:self.managedObjectContext];
        NSLog(@"Patient DELETED!");
        // Commit to core data
        NSError *error;
        if (![self.managedObjectContext save:&error])
            NSLog(@"Failed to add default user with error: %@", [error domain]);
    }
    
    
    
    
    
    
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
/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }   
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }   
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    if(indexPath.section == 0){
        self.editing = YES;
        [self performSegueWithIdentifier:@"goToPatient" sender: self];
        
    }
    else if(indexPath.section == 1){
        self.editing = YES;
        [self performSegueWithIdentifier:@"DateSegue" sender:self];
        
    }
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"DateSegue"])
    {
        
        SelectSchedule *vc = [segue destinationViewController];
        vc.appointment = self.appointment;
        vc.cameFromAdd = YES;
        vc.delegate = self;
    }
    else if([[segue identifier] isEqualToString:@"goToPatient"]){
        SearchPatientTVC *vc = [segue destinationViewController];
        vc.appointment = self.appointment;
        vc.managedObjectContext = self.managedObjectContext;
        vc.cameFromAdd = 1;
        vc.addDelegate = self;
        NSLog (@"ADD DELEGATE: %@", self);
    }
    
}

- (IBAction)saveButton:(id)sender {
    
    NSLog(@"PATIENT SAVED");
    
    self.appointment.notes = self.notesLabel.text;
    
    NSLog(@"%@", self.appointment);
    self.didSave = YES;
    
    // Commit to core data
    NSError *error;
    if (![self.managedObjectContext save:&error])
        NSLog(@"Failed to add default user with error: %@", [error domain]);
    
    [self.delegate saveAppointment:self.appointment.date];
    
}

- (void) patientSelected {
    
    NSMutableArray * patientarr = [CoreDataHelper searchObjectsForEntity:@"Patient" withPredicate:[NSPredicate 
        predicateWithFormat:@"SELF == %@",self.appointment.patient] andSortKey:nil andSortAscending:YES andContext:self.managedObjectContext];
    if( [patientarr count]!=0){ 
        Patient *patient = [patientarr objectAtIndex:0];
        self.patientCell.textLabel.text = [NSString stringWithFormat:@"%@ %@", patient.firstName, patient.lastName];
    }
    self.editing = NO;
    NSLog(self.editing ? @"EDITING: Yes" : @"EDITING: No");
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) backButtonPressed{
    
    
    self.editing = NO;
}



@end
