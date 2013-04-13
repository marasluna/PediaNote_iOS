//
//  AddConsultation.m
//  TestProject
//
//  Created by BerDy on 1/13/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "AddConsultation.h"
#import "Patient.h"

@implementation AddConsultation

@synthesize delegate;
@synthesize heightInput;
@synthesize weightInput;
@synthesize subjectiveInput;
@synthesize objectiveInput;
@synthesize assessmentInput;
@synthesize planInput;
@synthesize managedObjectContext;
@synthesize consultation;
@synthesize patient;

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
    [self setHeightInput:nil];
    [self setWeightInput:nil];
    [self setSubjectiveInput:nil];
    [self setObjectiveInput:nil];
    [self setAssessmentInput:nil];
    [self setPlanInput:nil];
    [self setHeightInput:nil];
    [self setWeightInput:nil];
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

- (IBAction)saveConsultation:(id)sender
{
    self.consultation = (Consultation *) [NSEntityDescription insertNewObjectForEntityForName:@"Consultation" inManagedObjectContext:self.managedObjectContext];
    //Patient *patient = (Patient *) [NSEntityDescription insertNewObjectForEntityForName:@"Patient" inManagedObjectContext:self.managedObjectContext];
    
    NSLog(@"save consultation");
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MMMM-dd"];
    self.consultation.date = [NSDate date];
    self.consultation.height = self.heightInput.text;
    self.consultation.weight = self.weightInput.text;
    self.consultation.subjective = self.subjectiveInput.text;
    self.consultation.objective = self.objectiveInput.text;
    self.consultation.assessment = self.subjectiveInput.text;
    self.consultation.plan = self.planInput.text;
    [self.patient addConsultationsObject:consultation];
    NSError *error;
    if (![self.managedObjectContext save:&error])
        NSLog(@"Failed to add default user with error: %@", [error domain]);
    NSLog(@"save consultation");
    
    [self.delegate saveConsultationTable];
}

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
}

- (IBAction)cancel:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

@end
