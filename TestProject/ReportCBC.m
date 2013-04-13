//
//  ReportCBC.m
//  TestProject
//
//  Created by BerDy on 1/19/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "ReportCBC.h"
#import "Report.h"

@implementation ReportCBC 

@synthesize delegate;
@synthesize managedObjectContext;
@synthesize notesInput;
@synthesize dataField1;
@synthesize dataField2;
@synthesize dataField3;
@synthesize dataField4;
@synthesize dataField5;
@synthesize dataField6;
@synthesize dataField7;
@synthesize dataField8;
@synthesize dataField9;
@synthesize patient;
@synthesize report;

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
    NSLog(@"cbc patient: %@", patient.firstName);
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [self setNotesInput:nil];
    [self setDataField1:nil];
    [self setDataField2:nil];
    [self setDataField3:nil];
    [self setDataField4:nil];
    [self setDataField5:nil];
    [self setDataField6:nil];
    [self setDataField7:nil];
    [self setDataField8:nil];
    [self setDataField9:nil];
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

- (IBAction)cancel:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)save:(id)sender
{
    NSLog(@"save CBC");
    self.report = (Report *) [NSEntityDescription insertNewObjectForEntityForName:@"Report" inManagedObjectContext:self.managedObjectContext];
    self.report.date = [NSDate date];
    self.report.type = @"CBC";
    self.report.notes = self.notesInput.text;
    self.report.d1 = self.dataField1.text;
    self.report.d2 = self.dataField2.text;
    self.report.d3 = self.dataField3.text;
    self.report.d4 = self.dataField4.text;
    self.report.d5 = self.dataField5.text;
    self.report.d6 = self.dataField6.text;
    self.report.d7 = self.dataField7.text;
    self.report.d8 = self.dataField8.text;
    self.report.d9 = self.dataField9.text;

    [self.patient addReportsObject:self.report];
    NSError *error;
    if (![self.managedObjectContext save:&error])
        NSLog(@"Failed to add default user with error: %@", [error domain]);
    NSLog(@"save history");
    
    [self.delegate saveCBCReport:patient];

}

@end
