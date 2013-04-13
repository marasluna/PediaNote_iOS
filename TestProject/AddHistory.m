//
//  AddHistory.m
//  TestProject
//
//  Created by BerDy on 1/13/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "AddHistory.h"
#import "Patient.h"
#import "History.h"

@implementation AddHistory

@synthesize delegate;
@synthesize managedObjectContext;
@synthesize history;
@synthesize patient;
@synthesize illnessInput;
@synthesize notesInput;
@synthesize historyType;

-(id)initWithStyle:(UITableViewStyle)style
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
    NSLog(@"add history class");
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [self setIllnessInput:nil];
    [self setNotesInput:nil];
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

-(IBAction)saveHistory:(id)sender
{
    NSLog(@"save history");
    NSLog(@"type: %@",self.historyType);
    NSLog(@"manage %@", self.managedObjectContext);
    self.history = (History *) [NSEntityDescription insertNewObjectForEntityForName:@"History" inManagedObjectContext:self.managedObjectContext];
    //NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    //[dateformatter setDateFormat:@"YYYY-MMMM-dd"];
    NSLog(@"aaaaaaaa");
    self.history.date = [NSDate date];
    self.history.type = self.historyType;
    self.history.illness = self.illnessInput.text;
    self.history.notes = self.notesInput.text;
    
    [self.patient addHistorysObject:history];
    NSError *error;
    if (![self.managedObjectContext save:&error])
        NSLog(@"Failed to add default user with error: %@", [error domain]);
    NSLog(@"save history");
    
    [self.delegate saveHistoryTable];
 
}

- (IBAction)cancel:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}



@end
