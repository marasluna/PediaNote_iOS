//
//  AddClinic.m
//  TestProject
//
//  Created by Team Ganda on 3/14/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "AddClinic.h"


@implementation AddClinic
@synthesize name;
@synthesize location;
@synthesize schedule;
@synthesize managedObjectContext;
@synthesize delegate;
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

    if(indexPath.section == 0){
        [self.name becomeFirstResponder];
    }else if(indexPath.section ==1){
        [self.location becomeFirstResponder];
    }
    else{
        [self.schedule becomeFirstResponder];
    }
}

- (IBAction)saveButon:(id)sender {
    
    self.clinic = (Clinic *)[NSEntityDescription insertNewObjectForEntityForName:@"Clinic" inManagedObjectContext:self.managedObjectContext];
    
    self.clinic.name = self.name.text;
    self.clinic.schedule = self.schedule.text;
    self.clinic.location = self.location.text;
    // Commit to core data
    NSError *error;
    if (![self.managedObjectContext save:&error])
        NSLog(@"Failed to add default user with error: %@", [error domain]);

    
    
    [self.delegate didClickSave];
}
@end
