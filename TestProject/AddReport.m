//
//  AddReport.m
//  TestProject
//
//  Created by BerDy on 1/15/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "AddReport.h"
#import "ReportCBC.h"
#import "ReportFecalysis.h"
#import "ReportOthers.h"
#import "ReportUrinalysis.h"
#import "ReportXray.h"

@implementation AddReport

@synthesize delegate;
@synthesize cbcCell;
@synthesize fecalysisCell;
@synthesize urinalysisCell;
@synthesize Xray;
@synthesize othersCell;
@synthesize managedObjectContext;
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
    [self setCbcCell:nil];
    [self setFecalysisCell:nil];
    [self setUrinalysisCell:nil];
    [self setXray:nil];
    [self setOthersCell:nil];
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"prepare report");
    if ([[segue identifier] isEqualToString:@"CBCSegue"])
    {
        ReportCBC *reportCBC = [segue destinationViewController];
        reportCBC.managedObjectContext = self.managedObjectContext;
        reportCBC.delegate = self.delegate;
        reportCBC.patient = patient;
    }
    
    if ([[segue identifier] isEqualToString:@"FecalysisSegue"])
    {
        ReportFecalysis *reportFecalysis = [segue destinationViewController];
        reportFecalysis.managedObjectContext = self.managedObjectContext;
        reportFecalysis.delegate = self.delegate;
        reportFecalysis.patient = patient;
    }

    if ([[segue identifier] isEqualToString:@"UrinalysisSegue"])
    {
        ReportUrinalysis *reportUrinalysis = [segue destinationViewController];
        reportUrinalysis.managedObjectContext = self.managedObjectContext;
        reportUrinalysis.delegate = self.delegate;
        reportUrinalysis.patient = patient;
    }

    if ([[segue identifier] isEqualToString:@"XraySegue"])
    {
        ReportXray *reportXray = [segue destinationViewController];
        reportXray.managedObjectContext = self.managedObjectContext;
        reportXray.delegate = self.delegate;
        reportXray.patient = patient;
    }

    if ([[segue identifier] isEqualToString:@"OthersSegue"])
    {
        ReportOthers *reportOthers = [segue destinationViewController];
        reportOthers.managedObjectContext = self.managedObjectContext;
        reportOthers.delegate = self.delegate;
        reportOthers.patient = patient;
    }
}
@end
