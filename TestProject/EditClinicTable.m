//
//  EditClinicTable.m
//  TestProject
//
//  Created by Team Ganda on 3/15/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "EditClinicTable.h"


@implementation EditClinicTable
@synthesize name;
@synthesize location;
@synthesize schedule;
@synthesize managedObjectContext;
@synthesize clinic;
@synthesize delegate;

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    self.name.text = self.clinic.name;
    self.location.text = self.clinic.location;
    self.schedule.text = self.clinic.schedule;
    
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{

    [self setName:nil];
    [self setLocation:nil];
    [self setSchedule:nil];
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
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    switch (indexPath.section) {
        case 0:
            [self.name becomeFirstResponder];
            break;
        case 1:
            [self.location becomeFirstResponder];
            break;
        case 2:
            [self.schedule becomeFirstResponder];
            break;
        default:
            break;
    }
}

- (IBAction)saveButton:(id)sender {
    
    self.clinic.name = self.name.text;
    self.clinic.location = self.location.text;
    self.clinic.schedule = self.schedule.text;
    
    NSError *error;
    if (![self.managedObjectContext save:&error])
        NSLog(@"Failed to add default user with error: %@", [error domain]);
    
    [self.delegate editSsave];
    [self.parentViewController dismissModalViewControllerAnimated:YES];
    
    
}

- (IBAction)cancelButton:(id)sender {
    
    [self.parentViewController dismissModalViewControllerAnimated:YES];
}
@end
