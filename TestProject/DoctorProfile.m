//
//  DoctorProfile.m
//  TestProject
//
//  Created by Team Ganda on 3/13/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "DoctorProfile.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation DoctorProfile
@synthesize password2Cell;
@synthesize password1Cell;


@synthesize managedObjectContext;
@synthesize name;
@synthesize email;
@synthesize username;
@synthesize password;
@synthesize doctorArray;
@synthesize confirmPassword;
@synthesize doctor;

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
      
    self.doctorArray = [CoreDataHelper getObjectsForEntity:@"Doctor" withSortKey:@"username" andSortAscending:YES andContext:self.managedObjectContext];
    if([self.doctorArray count]!=0){
        doctor = [self.doctorArray objectAtIndex:0];
        
        
        self.name.text = doctor.name;
        self.email.text = doctor.email;
        self.username.text = doctor.username;
        self.password.text = doctor.password;
        self.confirmPassword.text = doctor.password;
        self.password.secureTextEntry = YES;
        self.confirmPassword.secureTextEntry = YES;
    }
    
    
    [super viewDidLoad];
    
    

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [self setName:nil];
    [self setEmail:nil];
    [self setUsername:nil];
    [self setPassword:nil];
    [self setConfirmPassword:nil];
    [self setPassword2Cell:nil];
    [self setPassword1Cell:nil];

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

#pragma mark - Table view data source
/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    
    return cell;
}
*/
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
        [self.name becomeFirstResponder];
    
    }
    else if(indexPath.row==1){
        [self.email becomeFirstResponder];
    }
    else if(indexPath.row ==2){
        [self.username becomeFirstResponder];
    }
    else if(indexPath.row ==3){
        [self.password becomeFirstResponder];
    }
    else{
        [self.confirmPassword becomeFirstResponder];
    }
}

- (IBAction)saveButton:(id)sender {
    

    //self.doctor.name = [[NSString alloc]init];
    //self.doctor.email = [[NSString alloc] init];
    //self.doctor.name = @"";
    self.doctor.name = self.name.text;
    self.doctor.username = self.username.text;
    
    NSLog(@"%@ %@", self.doctor.email, self.email.text);
    //self.doctor.email = @"";
    NSLog(@"%@", self.doctor.email);
    self.doctor.email = self.email.text;
    

    if([self.password.text isEqualToString: self.confirmPassword.text]){
        self.doctor.password = self.password.text;
        self.password1Cell.backgroundColor = [UIColor whiteColor];
        self.password2Cell.backgroundColor = [UIColor whiteColor];
    }else{ 
        self.password1Cell.backgroundColor = UIColorFromRGB(0xFFFFEE);
        self.password2Cell.backgroundColor = UIColorFromRGB(0xFFFFEE);
        self.confirmPassword.text = @"";
        self.password.text = @"";
    }
    
    [self.name resignFirstResponder];
    [self.email resignFirstResponder];
    [self.username resignFirstResponder];
    [self.password resignFirstResponder];
    [self.confirmPassword resignFirstResponder];
    
    NSLog(@"%@",self.managedObjectContext);
    // Commit to core data
    NSError *error;
    if (![self.managedObjectContext save:&error])
        NSLog(@"Failed to add default user with error: %@", [error domain]);

    
}
@end
