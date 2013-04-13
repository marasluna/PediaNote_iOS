//
//  EditAppointment.m
//  TestProject
//
//  Created by Team Ganda on 3/5/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "EditAppointment.h"
#import "SelectSchedule.h"
#import "CoreDateHelper.h"

@implementation EditAppointment
@synthesize patientCell;
@synthesize dateLabel;
@synthesize startTimeLabel;
@synthesize endTimeLabel;
@synthesize notesLabel;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize appointment = _appointment;
@synthesize delegate = _delegate;
@synthesize currentDate = _currentDate;
@synthesize currentNotes = _currentNotes;
@synthesize currentEndTime = _currentEndTime;
@synthesize currentStartTime = _currentStartTime;
@synthesize currentPatient = _currentPatient;
@synthesize didSave;
@synthesize didDelete;

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle




- (void)viewDidLoad
{
    
    self.didDelete = NO;
    self.didSave = NO;
    self.currentPatient = self.appointment.patient;
    self.currentDate = self.appointment.date;
    self.currentStartTime = self.appointment.startTime;
    self.currentEndTime = self.appointment.endTime;
    self.currentNotes = self.appointment.notes;
    
    [super viewDidLoad];
    
}

- (void)viewDidUnload
{
    
    [self setPatientCell:nil];
    [self setDateLabel:nil];
    [self setStartTimeLabel:nil];
    [self setEndTimeLabel:nil];
    [self setNotesLabel:nil];
    
    [super viewDidUnload];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    NSMutableArray * patientarr = [CoreDataHelper searchObjectsForEntity:@"Patient" withPredicate:[NSPredicate 
                                                                                                   predicateWithFormat:@"SELF == %@",self.appointment.patient] andSortKey:nil andSortAscending:YES andContext:self.managedObjectContext];
    if([patientarr count] !=0){
        Patient *patient = [patientarr objectAtIndex:0];
        self.patientCell.textLabel.text = [NSString stringWithFormat:@"%@ %@", patient.firstName, patient.lastName];
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
    
    if(self.didSave==NO && self.didDelete==NO){
        self.appointment.patient = self.currentPatient;
        self.appointment.date = self.currentDate;
        self.appointment.startTime = self.currentStartTime;
        self.appointment.endTime = self.currentEndTime;
        self.appointment.notes = self.currentNotes;
        
        
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
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation== UIInterfaceOrientationLandscapeRight);
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
    if(indexPath.section == 0){
        [self performSegueWithIdentifier:@"goToPatient1" sender: self];
    }
    else if(indexPath.section == 1){
        self.appointment.notes = self.notesLabel.text;
        [self performSegueWithIdentifier:@"selectSchedule" sender:self];
    }
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"selectSchedule"])
    {
        SelectSchedule *vc = [segue destinationViewController];
        vc.appointment = self.appointment;
        vc.cameFromAdd = NO;
        
    }
    else if([[segue identifier] isEqualToString:@"goToPatient1"]){
        NSLog(@"Perform");
        SearchPatientTVC *c = [segue destinationViewController];
        c.appointment = self.appointment;
        c.managedObjectContext = self.managedObjectContext;
        c.cameFromAdd = 0;
        c.editDelegate = self;
    }
}


- (IBAction)saveButton:(id)sender {
    
    
    
    self.didSave = YES;
    self.appointment.notes = self.notesLabel.text;
    
    
    
    NSError *error;
    if (![self.managedObjectContext save:&error])
        NSLog(@"Failed to add default user with error: %@", [error domain]);
    NSLog(@"SAVING");
    
    [self.delegate didSelectDelete:self.appointment.date];
    
}

- (IBAction)deleteButton:(id)sender {
    NSDate *date = self.appointment.date;
    [CoreDataHelper deleteAllObjectsForEntity:@"Appointment" withPredicate:[NSPredicate predicateWithFormat:@"self == %@", self.appointment] andContext:self.managedObjectContext];
    self.didDelete = YES;
    // Commit to core data
    NSError *error;
    if (![self.managedObjectContext save:&error])
        NSLog(@"Failed to add default user with error: %@", [error domain]);
    
    [self.delegate didSelectDelete:date];
}

-(void) patientSelected{
    
    
    
    
    NSMutableArray * patientarr = [CoreDataHelper searchObjectsForEntity:@"Patient" withPredicate:[NSPredicate 
        predicateWithFormat:@"SELF == %@",self.appointment.patient] andSortKey:nil andSortAscending:YES andContext:self.managedObjectContext];
    
    Patient *patient = [patientarr objectAtIndex:0];
    self.patientCell.textLabel.text = [NSString stringWithFormat:@"%@ %@", patient.firstName, patient.lastName];
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
