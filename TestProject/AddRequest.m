//
//  AddRequest.m
//  TestProject
//
//  Created by Team Ganda on 4/4/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "AddRequest.h"

@implementation AddRequest

@synthesize nameLabel;
@synthesize recipientInput;
@synthesize typeInput;
@synthesize notesInput;
@synthesize managedObjectContext;
@synthesize patient;
@synthesize delegate;

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
    self.nameLabel.text = [NSString stringWithFormat:@"%@ %@", self.patient.firstName, self.patient.lastName];
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [self setNameLabel:nil];
    [self setRecipientInput:nil];
    [self setTypeInput:nil];
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

- (IBAction)cancel:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)composeMail:(id)sender
{
    NSLog(@"compose mail WAHAHAHA");
    NSDateFormatter *dateformatter2 = [[NSDateFormatter alloc] init];
    [dateformatter2 setDateFormat:@"MMMM dd, YYYY"];
    NSString *dateToday = [NSString stringWithFormat:@"%@", [dateformatter2 stringFromDate:[NSDate date]]];
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        [[mailer navigationBar] setTintColor:UIColorFromRGB(0x006699)];
        mailer.mailComposeDelegate = self;
        [mailer setSubject:[NSString stringWithFormat:@"Lab Request for Patient %@",self.nameLabel.text]];
        NSArray *toRecipients = [NSArray arrayWithObjects:self.recipientInput.text, nil];
        [mailer setToRecipients:toRecipients];
        //UIImage *myImage = [UIImage imageNamed:@"mobiletuts-logo.png"];
        //NSData *imageData = UIImagePNGRepresentation(myImage);
        //[mailer addAttachmentData:imageData mimeType:@"image/png" fileName:@"mobiletutsImage"];
        NSString *emailBody = [NSString stringWithFormat:@"Date: %@ \n\nPatient Name: %@\n\nLaboratory Request for: %@\n\nNotes: %@\n\n\n\nThanks,\n Doctor Gregory House",dateToday, self.nameLabel.text, self.typeInput.text, self.notesInput.text];
        [mailer setMessageBody:emailBody isHTML:NO];
        mailer.modalPresentationStyle = UIModalPresentationFormSheet;

        [self presentModalViewController:mailer animated:YES];
        
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failure"
                                                        message:@"Your device doesn't support the composer sheet"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
    }
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error 
{	
	switch (result)
	{
		case MFMailComposeResultCancelled:
			NSLog(@"Mail cancelled: you cancelled the operation and no email message was queued");
			break;
		case MFMailComposeResultSaved:
			NSLog(@"Mail saved: you saved the email message in the Drafts folder");
			break;
		case MFMailComposeResultSent:
			NSLog(@"Mail send: the email message is queued in the outbox. It is ready to send the next time the user connects to email");
           // [ dismissModalViewControllerAnimated:YES];
			break;
		case MFMailComposeResultFailed:
			NSLog(@"Mail failed: the email message was nog saved or queued, possibly due to an error");
			break;
		default:
			NSLog(@"Mail not sent");
			break;
	}
    
	[self dismissModalViewControllerAnimated:YES];
    //[self.parentViewController.parentViewController dismissModalViewControllerAnimated:YES];
}

@end
