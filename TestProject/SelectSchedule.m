//
//  SelectSchedule.m
//  TestProject
//
//  Created by Team Ganda on 3/4/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "SelectSchedule.h"


@implementation SelectSchedule

@synthesize activeCell = _activeCell;
@synthesize dateCell = _dateCell;
@synthesize startTimeCell = _startTimeCell;
@synthesize endTimeCell = _endTimeCell;
@synthesize datePicker = _datePicker;
@synthesize appointment = _appointment;
@synthesize cameFromAdd = _cameFromAdd;
@synthesize delegate =  _delegate;

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


- (void)pickerChanged:(id)sender
{
    
    NSLog(@"value: %@",[sender date]);
    //NSDateFormatter *f = [[NSDateFormatter alloc] init];
    //[f setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //NSDate *date = [f dateFromString:@"2010-01-10 13:55:15"];
    
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    //[f2 setDateFormat:@"d. MMMM YYYY"];
    //NSString *s = [f2 stringFromDate:date];    
    
    if(self.activeCell==0){
        [f setDateFormat:@"MMMM dd, YYYY"];
        self.dateCell.detailTextLabel.text = [f stringFromDate:[sender date]];
        self.appointment.date =[sender date];
    }else if(self.activeCell==1){
        [f setDateFormat:@"hh:mm a"];
        self.startTimeCell.detailTextLabel.text = [f stringFromDate:[sender date]];
        self.appointment.startTime =[sender date];
    }else{
        [f setDateFormat:@"hh:mm a"];
        self.endTimeCell.detailTextLabel.text = [f stringFromDate:[sender date]];
        self.appointment.endTime =[sender date];
    }
    [self.tableView reloadData];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    

    
    self.activeCell = 0;
    self.datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 175, 325, 300)];
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    self.datePicker.minuteInterval = 15;
    self.datePicker.hidden = NO;
    self.datePicker.date = [NSDate date];
    
    [self.datePicker addTarget:self
                   action:@selector(pickerChanged:)
         forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.datePicker];    
    
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{

    [self setDateCell:nil];
    [self setStartTimeCell:nil];
    [self setEndTimeCell:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    //[f2 setDateFormat:@"d. MMMM YYYY"];
    //NSString *s = [f2 stringFromDate:date];    
    

        [f setDateFormat:@"MMMM dd, YYYY"];
        self.dateCell.detailTextLabel.text = [f stringFromDate:self.appointment.date];
        [f setDateFormat:@"hh:mm a"];
        self.startTimeCell.detailTextLabel.text = [f stringFromDate:self.appointment.startTime];
        self.endTimeCell.detailTextLabel.text = [f stringFromDate:self.appointment.endTime];
 
    
        
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
    if(indexPath.row==0){
        self.activeCell =0;
        self.datePicker.datePickerMode = UIDatePickerModeDate;
    }else if(indexPath.row==1){
        self.activeCell =1;
        self.datePicker.datePickerMode = UIDatePickerModeTime;
    }else{
        self.activeCell =2;
        self.datePicker.datePickerMode = UIDatePickerModeTime;
    }
}

- (IBAction)backButton:(id)sender {
    if(self.cameFromAdd == YES){
        [self.delegate backButtonPressed];
    
    }
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end
