//
//  PatientProfile.m
//  TestProject
//
//  Created by BerDy on 1/11/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "PatientProfile.h"
#import "CoreDateHelper.h"
#import "PatientTVC.h"
#import "PatientAdd.h"
#import "ConsultationCell.h"
#import "HistoryCell.h"
#import "Patient.h"
#import "History.h"
#import "Consultation.h"
#import "SelectedConsultationCell.h"
#import "AddReport.h"
#import "AddConsultation.h"
#import "AddHistory.h"
#import "ReportCell.h"
#import "Parent.h"
#import "Report.h"
#import "SelectHistoryType.h"
#import "ImmunizationCell.h"
#import "Immunization.h"
#import "CustomPagerViewController.h"
#import "ShowCBC.h"
#import "ShowFecalysis.h"
#import "ShowOthers.h"
#import "ShowUrinalysis.h"
#import "ShowXray.h"
#import "AddRequest.h"

@implementation PatientProfile

@synthesize managedObjectContext;
@synthesize delegate;
@synthesize currentPatient;
@synthesize nameInput;
@synthesize ageInput;
@synthesize contactInput;
@synthesize bdayInput;
@synthesize guardianInput;
@synthesize iconView;
@synthesize patientConsultationList;
@synthesize patientHistoryList1;
@synthesize patientHistoryList2;
@synthesize patientHistoryList3;
@synthesize selectedSegmentIndex;
@synthesize seeFullProfile;
@synthesize seeProfilePopover;
@synthesize addConsultation;
@synthesize addConsultationPopover;
@synthesize addHistoryPopover;
@synthesize patientDetailView;
@synthesize checkRow;
@synthesize patientReportsList;
@synthesize addReport;
@synthesize parentMatched;
@synthesize selectHistoryType;
@synthesize patientImmunizationList;
@synthesize vaccineList;

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
    NSLog(@"enter prof %@",currentPatient.firstName);
    
    self.iconView.image = [UIImage imageNamed:@"baby.png"];

    
    
    
    self.checkRow = -1;
    self.selectedSegmentIndex = 0;
    
    self.vaccineList = [[NSMutableArray alloc] init];
    [self.vaccineList addObject:@"BCG"];
    [self.vaccineList addObject:@"Hepatitis A"];
    [self.vaccineList addObject:@"DTwP/DTaP"];
    [self.vaccineList addObject:@"OPV/TVP"];
    [self.vaccineList addObject:@"Measles"];
    [self.vaccineList addObject:@"H. Influenza type B"];
    [self.vaccineList addObject:@"Rotavirus"];
    [self.vaccineList addObject:@"Influenza"];
    [self.vaccineList addObject:@"MMR"];
    [self.vaccineList addObject:@"Typhoid"];
    
    
    
    [super viewDidLoad];

}

- (void)viewDidUnload
{
    [self setIconView:nil];
    [self setNameInput:nil];
    [self setAgeInput:nil];
    [self setContactInput:nil];
    [self setBdayInput:nil];
    [self setGuardianInput:nil];
    [self setPatientDetailView:nil];
    [super viewDidUnload];

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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.selectedSegmentIndex == 0) return 4;
    else if (self.selectedSegmentIndex == 1) return 1;
    else return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.selectedSegmentIndex == 0) {
        if (section == 0){
            NSLog(@"HISTORY1 COUNT %d", [self.patientHistoryList1 count]);
            return [self.patientHistoryList1 count];
        }
        else if (section == 1){
            NSLog(@"HISTORY2 COUNT %d", [self.patientHistoryList2 count]);
            return [self.patientHistoryList2 count];
        }
        else if(section == 2) {
            NSLog(@"HISTORY2 COUNT %d", [self.patientHistoryList3 count]);
            return [self.patientHistoryList3 count];
        }
        else return 10;
    }
    
    else if (self.selectedSegmentIndex == 1) {
            return [self.patientConsultationList count];
    }
    
    else {
        return [self.patientReportsList count];
    }
}

- (NSString *)getAge:(NSDate *) dateOfBirth {
    
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"MMMM dd, YYYY"];
    NSLog(@"getAge date: %@",[NSString stringWithFormat:@"%@", [dateformatter stringFromDate:dateOfBirth]]);

    NSInteger years;
    NSInteger months;
    NSInteger days;
    if(dateOfBirth == NULL){
     return @"";   
    }
    else{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSDateComponents *dateComponentsNow = [calendar components:unitFlags fromDate:[NSDate date]];
    NSDateComponents *dateComponentsBirth = [calendar components:unitFlags fromDate:dateOfBirth];
    
    if (([dateComponentsNow month] < [dateComponentsBirth month]) ||
        (([dateComponentsNow month] == [dateComponentsBirth month]) && ([dateComponentsNow day] < [dateComponentsBirth day]))) {
        years = [dateComponentsNow year] - [dateComponentsBirth year] - 1;
    } else {
        years = [dateComponentsNow year] - [dateComponentsBirth year];
    }
    
    NSLog(@"years:%d", years);
    
    if ([dateComponentsNow year] == [dateComponentsBirth year]) {
        months = [dateComponentsNow month] - [dateComponentsBirth month];
    } else if ([dateComponentsNow year] > [dateComponentsBirth year] && [dateComponentsNow month] > [dateComponentsBirth month]) {
        months = [dateComponentsNow month] - [dateComponentsBirth month];
    } else if ([dateComponentsNow year] > [dateComponentsBirth year] && [dateComponentsNow month] < [dateComponentsBirth month]) {
        months = [dateComponentsNow month] - [dateComponentsBirth month] + 12;
    } else {
        months = [dateComponentsNow month] - [dateComponentsBirth month];
    }
    
    NSLog(@"months:%d", months);
    
    if ([dateComponentsNow year] == [dateComponentsBirth year] && [dateComponentsNow month] == [dateComponentsBirth month]) {
        days = [dateComponentsNow day] - [dateComponentsBirth day];
    }
    
    if (years == 0 && months == 0) {
        if (days == 1) {
            return [NSString stringWithFormat:@"%d %@", days, NSLocalizedString(@"day", @"day")];
        } else {
            return [NSString stringWithFormat:@"%d %@", days, NSLocalizedString(@"days", @"days")];
        }
    } else if (years == 0) {
        if (months == 1) {
            return [NSString stringWithFormat:@"%d %@", months, NSLocalizedString(@"month", @"month")];
        } else {
            return [NSString stringWithFormat:@"%d %@", months, NSLocalizedString(@"months", @"months")];
        }
    } else if ((years != 0) && (months == 0)) {
        if (years == 1) {
            return [NSString stringWithFormat:@"%d %@", years, NSLocalizedString(@"year", @"year")];
        } else {
            return [NSString stringWithFormat:@"%d %@", years, NSLocalizedString(@"years", @"years")];
        }
    } else {
        if ((years == 1) && (months == 1)) {
            return [NSString stringWithFormat:@"%d %@ %d %@", years, NSLocalizedString(@"year and", @"year and"), months, NSLocalizedString(@"month", @"month")];
        } else if (years == 1) {
            return [NSString stringWithFormat:@"%d %@ %d %@", years, NSLocalizedString(@"year and", @"year and"), months, NSLocalizedString(@"months", @"months")];
        } else if (months == 1) {
            return [NSString stringWithFormat:@"%d %@ %d %@", years, NSLocalizedString(@"years and", @"years and"), months, NSLocalizedString(@"month", @"month")];
        } else {
            return [NSString stringWithFormat:@"%d %@ %d %@", years, NSLocalizedString(@"years and", @"years and"), months, NSLocalizedString(@"months", @"months")];
        }
        
    }
        
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    static NSString *CellIdentifier;
    static NSString *CellIdentifier2;
    static NSString *CellIdentifier3;
    static NSString *CellIdentifier4;
    
    if ((selectedSegmentIndex == 0) && (indexPath.section == 3))
    {
        //NSLog(@"Enter 33333");
        CellIdentifier4 = @"Immunization Cell";

        ImmunizationCell *cell4 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier4];
        if (cell4 == nil) {
            cell4 = [[ImmunizationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier4];
        }

        NSLog(@"immune");
        NSDateFormatter *dateformatter4 = [[NSDateFormatter alloc] init];
        [dateformatter4 setDateFormat:@"MM/dd/YY"];
        cell4.nameLabel.text = [self.vaccineList objectAtIndex:indexPath.row];
        NSLog(@"count %d",[self.patientImmunizationList count]);
        Immunization *immunization; 
        
        if(self.patientImmunizationList > 0)
            immunization = [self.patientImmunizationList objectAtIndex:0];

            if (indexPath.row == 0) {
                
                if (immunization.bcg1 != NULL) cell4.a1.text = [NSString stringWithFormat:@"%@", [dateformatter4 stringFromDate:immunization.bcg1]];
                else cell4.a1.text= @"";
                if (immunization.bcg2 != NULL) cell4.a2.text = [NSString stringWithFormat:@"%@", [dateformatter4 stringFromDate:immunization.bcg2]];
                else cell4.a2.text= @"";
                 if (immunization.bcg3 != NULL) cell4.a3.text = [NSString stringWithFormat:@"%@", [dateformatter4 stringFromDate:immunization.bcg3]];
                else cell4.a3.text= @"";
                if (immunization.bcg4 != NULL) cell4.a4.text = [NSString stringWithFormat:@"%@", [dateformatter4 stringFromDate:immunization.bcg4]];
                else cell4.a4.text= @"";
                if (immunization.bcg5 != NULL) cell4.a5.text = [NSString stringWithFormat:@"%@", [dateformatter4 stringFromDate:immunization.bcg5]];
                else cell4.a5.text= @"";
                if (immunization.bcg6 != NULL) cell4.a6.text = [NSString stringWithFormat:@"%@", [dateformatter4 stringFromDate:immunization.bcg6]];
                else cell4.a6.text= @"";
            }
            
            else if (indexPath.row == 1) {
                 
            if (immunization.hepa1 != NULL) cell4.a1.text = [NSString stringWithFormat:@"%@", [dateformatter4 stringFromDate:immunization.hepa1]];
            else cell4.a1.text= @"";
            if (immunization.hepa2 != NULL) cell4.a2.text = [NSString stringWithFormat:@"%@", [dateformatter4 stringFromDate:immunization.hepa2]];
            else cell4.a2.text= @"";
            if (immunization.hepa3 != NULL) cell4.a3.text = [NSString stringWithFormat:@"%@", [dateformatter4 stringFromDate:immunization.hepa3]];
            else cell4.a3.text= @"";
            if (immunization.hepa4 != NULL) cell4.a4.text = [NSString stringWithFormat:@"%@", [dateformatter4 stringFromDate:immunization.hepa4]];
            else cell4.a4.text= @"";
            if (immunization.hepa5 != NULL) cell4.a5.text = [NSString stringWithFormat:@"%@", [dateformatter4 stringFromDate:immunization.hepa5]];
            else cell4.a5.text= @"";
            if (immunization.hepa6 != NULL) cell4.a6.text = [NSString stringWithFormat:@"%@", [dateformatter4 stringFromDate:immunization.hepa6]];
            
            else cell4.a6.text= @"";
                NSLog(@"row2 %d", indexPath.row);
            //break;
            }
            
            else if (indexPath.row == 2) {
                 
            if (immunization.d1 != NULL) cell4.a1.text = [NSString stringWithFormat:@"%@", [dateformatter4 stringFromDate:immunization.d1]];
            else cell4.a1.text= @"";
            if (immunization.d2 != NULL) cell4.a2.text = [NSString stringWithFormat:@"%@", [dateformatter4 stringFromDate:immunization.d2]];
            else cell4.a2.text= @"";
            if (immunization.d3 != NULL) cell4.a3.text = [NSString stringWithFormat:@"%@", [dateformatter4 stringFromDate:immunization.d3]];
            else cell4.a3.text= @"";
             if (immunization.d4 != NULL) cell4.a4.text = [NSString stringWithFormat:@"%@", [dateformatter4 stringFromDate:immunization.d4]];
            else cell4.a4.text= @"";
            if (immunization.d5 != nil) cell4.a5.text = [NSString stringWithFormat:@"%@", [dateformatter4 stringFromDate:immunization.d5]];
            else cell4.a5.text= @"";
            if (immunization.d6 != nil) {
                cell4.a6.text = [NSString stringWithFormat:@"%@", [dateformatter4 stringFromDate:immunization.d6]];
                NSLog(@"d6 %@",[dateformatter4 stringFromDate:immunization.d6]);
                
            }//else cell4.a6.text= @"";
                NSLog(@"row3 %d", indexPath.row);
            //break;
            }
            
            if (indexPath.row == 3) {
            if (immunization.o1 != NULL) cell4.a1.text = [NSString stringWithFormat:@"%@", [dateformatter4 stringFromDate:immunization.o1]];
            else cell4.a1.text= @"";
                if (immunization.o2 != NULL) cell4.a2.text = [NSString stringWithFormat:@"%@", [dateformatter4 stringFromDate:immunization.o2]];
            else cell4.a2.text= @"";
            if (immunization.o3 != NULL) cell4.a3.text = [NSString stringWithFormat:@"%@", [dateformatter4 stringFromDate:immunization.o3]];
            else cell4.a3.text= @"";
            if (immunization.o4 != NULL) cell4.a4.text = [NSString stringWithFormat:@"%@", [dateformatter4 stringFromDate:immunization.o4]];
            else cell4.a4.text= @"";
            if (immunization.o5 != NULL) cell4.a5.text = [NSString stringWithFormat:@"%@", [dateformatter4 stringFromDate:immunization.o5]];
            else cell4.a5.text= @"";
            if (immunization.o6 != NULL) cell4.a6.text = [NSString stringWithFormat:@"%@", [dateformatter4 stringFromDate:immunization.o6]];
            else cell4.a6.text= @"";
                NSLog(@"row4 %d", indexPath.row);

            //break;
            }
            
            else if (indexPath.row == 4) {
                 
            if (immunization.measles1 != NULL) cell4.a1.text = [NSString stringWithFormat:@"%@", [dateformatter4 stringFromDate:immunization.measles1]];
            else cell4.a1.text= @"";
            if (immunization.measles2 != NULL) cell4.a2.text = [NSString stringWithFormat:@"%@", [dateformatter4 stringFromDate:immunization.measles2]];
            else cell4.a2.text= @"";
            if (immunization.measles3 != NULL) cell4.a3.text = [NSString stringWithFormat:@"%@", [dateformatter4 stringFromDate:immunization.measles3]];
            else cell4.a3.text= @"";
            if (immunization.measles4 != NULL) cell4.a4.text = [NSString stringWithFormat:@"%@", [dateformatter4 stringFromDate:immunization.measles4]];
            else cell4.a4.text= @"";
            if (immunization.measles5 != NULL) cell4.a5.text = [NSString stringWithFormat:@"%@", [dateformatter4 stringFromDate:immunization.measles5]];
            else cell4.a5.text= @"";
            if (immunization.measles6 != NULL) cell4.a6.text = [NSString stringWithFormat:@"%@", [dateformatter4 stringFromDate:immunization.measles6]];
            else cell4.a6.text= @"";
             //   NSLog(@"row5 %d", indexPath.row);
            //break;
                
            }
            
            else if (indexPath.row == 5) {
                 
            if (immunization.influenzaB1 != NULL) cell4.a1.text = [NSString stringWithFormat:@"%@", [dateformatter4 stringFromDate:immunization.influenzaB1]];
            else cell4.a1.text= @"";
            if (immunization.influenzaB2 != NULL) cell4.a2.text = [NSString stringWithFormat:@"%@", [dateformatter4 stringFromDate:immunization.influenzaB2]];
            else cell4.a2.text= @"";
            if (immunization.influenzaB3 != NULL) cell4.a3.text = [NSString stringWithFormat:@"%@", [dateformatter4 stringFromDate:immunization.influenzaB3]];
            else cell4.a3.text= @"";
            if (immunization.influenzaB4 != NULL) cell4.a4.text = [NSString stringWithFormat:@"%@", [dateformatter4 stringFromDate:immunization.influenzaB4]];
            else cell4.a4.text= @"";
            if (immunization.influenzaB5 != NULL) cell4.a5.text = [NSString stringWithFormat:@"%@", [dateformatter4 stringFromDate:immunization.influenzaB5]];
            else cell4.a5.text= @"";
            if (immunization.influenzaB6 != NULL) cell4.a6.text = [NSString stringWithFormat:@"%@", [dateformatter4 stringFromDate:immunization.influenzaB6]];
            else cell4.a6.text= @"";
                NSLog(@"row6 %d", indexPath.row);
            //break;
            }
            
            else if (indexPath.row == 6) {
                
                
            if (immunization.rota1 != NULL) cell4.a1.text = [NSString stringWithFormat:@"%@", [dateformatter4 stringFromDate:immunization.rota1]];
            else cell4.a1.text= @"";
            if (immunization.rota2 != NULL) cell4.a2.text = [NSString stringWithFormat:@"%@", [dateformatter4 stringFromDate:immunization.rota2]];
            else cell4.a2.text= @"";
            if (immunization.rota3 != NULL) cell4.a3.text = [NSString stringWithFormat:@"%@", [dateformatter4 stringFromDate:immunization.rota3]];
            else cell4.a3.text= @"";
            if (immunization.rota4 != NULL) cell4.a4.text = [NSString stringWithFormat:@"%@", [dateformatter4 stringFromDate:immunization.rota4]];
            else cell4.a4.text= @"";
            if (immunization.rota5 != NULL) cell4.a5.text = [NSString stringWithFormat:@"%@", [dateformatter4 stringFromDate:immunization.rota5]];
            else cell4.a5.text= @"";
            if (immunization.rota6 != NULL) cell4.a6.text = [NSString stringWithFormat:@"%@", [dateformatter4 stringFromDate:immunization.rota6]];
            else cell4.a6.text= @"";
                 NSLog(@"row7 %d", indexPath.row);
            //break;
                
            }
            
            else if (indexPath.row == 7) {
                
                 
            if (immunization.influenza1 != NULL) cell4.a1.text = [NSString stringWithFormat:@"%@", [dateformatter4 stringFromDate:immunization.influenza1]];
            else cell4.a1.text= @"";
             if (immunization.influenza2 != NULL) cell4.a2.text = [NSString stringWithFormat:@"%@", [dateformatter4 stringFromDate:immunization.influenza2]];
            else cell4.a2.text= @"";
            if (immunization.influenza3 != NULL) cell4.a3.text = [NSString stringWithFormat:@"%@", [dateformatter4 stringFromDate:immunization.influenza3]];
            else cell4.a3.text= @"";
             if (immunization.influenza4 != NULL) cell4.a4.text = [NSString stringWithFormat:@"%@", [dateformatter4 stringFromDate:immunization.influenza4]];
            else cell4.a4.text= @"";
            if (immunization.influenza5 != NULL) cell4.a5.text = [NSString stringWithFormat:@"%@", [dateformatter4 stringFromDate:immunization.influenza5]];
            else cell4.a5.text= @"";
            if (immunization.influenza6 != NULL) cell4.a6.text = [NSString stringWithFormat:@"%@", [dateformatter4 stringFromDate:immunization.influenza6]];
            else cell4.a6.text= @"";
                NSLog(@"row8 %d", indexPath.row);
            //break;
            }
            
            else if (indexPath.row == 8) {
                 
            if (immunization.mmr1 != NULL) cell4.a1.text = [NSString stringWithFormat:@"%@", [dateformatter4 stringFromDate:immunization.mmr1]];
            else cell4.a1.text= @"";
            if (immunization.mmr2 != NULL) cell4.a2.text = [NSString stringWithFormat:@"%@", [dateformatter4 stringFromDate:immunization.mmr2]];
            else cell4.a2.text= @"";
            if (immunization.mmr3 != NULL) cell4.a3.text = [NSString stringWithFormat:@"%@", [dateformatter4 stringFromDate:immunization.mmr3]];
            else cell4.a3.text= @"";
                
            if (immunization.mmr4 != NULL) cell4.a4.text = [NSString stringWithFormat:@"%@", [dateformatter4 stringFromDate:immunization.mmr4]];
            else cell4.a4.text= @"";
            if (immunization.mmr5 != NULL) cell4.a5.text = [NSString stringWithFormat:@"%@", [dateformatter4 stringFromDate:immunization.mmr5]];
            else cell4.a5.text= @"";
            if (immunization.mmr6 != NULL) cell4.a6.text = [NSString stringWithFormat:@"%@", [dateformatter4 stringFromDate:immunization.mmr6]];
            else cell4.a6.text= @"";
                NSLog(@"row9 %d", indexPath.row);
            //break;
                
            }
            
            else if (indexPath.row == 9) {
                 NSLog(@"row10");
            if (immunization.typhoid1 != NULL) cell4.a1.text = [NSString stringWithFormat:@"%@", [dateformatter4 stringFromDate:immunization.typhoid1]];
            else cell4.a1.text= @"";
            if (immunization.typhoid2 != NULL) cell4.a2.text = [NSString stringWithFormat:@"%@", [dateformatter4 stringFromDate:immunization.typhoid2]];
            else cell4.a2.text= @"";
            if (immunization.typhoid3 != NULL) cell4.a3.text = [NSString stringWithFormat:@"%@", [dateformatter4 stringFromDate:immunization.typhoid3]];
            else cell4.a3.text= @"";
            if (immunization.typhoid4 != NULL) cell4.a4.text = [NSString stringWithFormat:@"%@", [dateformatter4 stringFromDate:immunization.typhoid4]];
            else cell4.a4.text= @"";
            if (immunization.typhoid5 != NULL) cell4.a5.text = [NSString stringWithFormat:@"%@", [dateformatter4 stringFromDate:immunization.typhoid5]];
            else cell4.a5.text= @"";
            if (immunization.typhoid6 != NULL) cell4.a6.text = [NSString stringWithFormat:@"%@", [dateformatter4 stringFromDate:immunization.typhoid6]];
            else cell4.a6.text= @"";
                NSLog(@"row10 %d", indexPath.row);
            //break;
            }
               

        //}
       
        return cell4;

    }
    
    else if ((selectedSegmentIndex == 0) && ((indexPath.section == 0) || (indexPath.section == 1) || (indexPath.section == 2)))
    {
        
        CellIdentifier2 = @"History Cell";
        
        HistoryCell *cell2 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier2];
        if (cell2 == nil) {
            cell2 = [[HistoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier2];
        }
        
        
        
        if (indexPath.section == 0)
        {
            NSLog(@"allergy");
            History *history1 = [self.patientHistoryList1 objectAtIndex:indexPath.row];
            
            
            NSDateFormatter *dateformatter2 = [[NSDateFormatter alloc] init];
            [dateformatter2 setDateFormat:@"MMM dd, YYYY"];
            cell2.historyDateField.text = [NSString stringWithFormat:@"%@", [dateformatter2 stringFromDate:history1.date]];
            cell2.historyIllnessField.text = history1.illness;
            cell2.historyNotesField.text = history1.notes;
        }   
        
        else if (indexPath.section == 1)
        {
            NSLog(@"past");
            History *history2 = [self.patientHistoryList2 objectAtIndex:indexPath.row];
            
            NSDateFormatter *dateformatter2 = [[NSDateFormatter alloc] init];
            [dateformatter2 setDateFormat:@"MMM dd, YYYY"];
            cell2.historyDateField.text = [NSString stringWithFormat:@"%@", [dateformatter2 stringFromDate:history2.date]];
            cell2.historyIllnessField.text = history2.illness;
            cell2.historyNotesField.text = history2.notes;
        }   
        
        else if (indexPath.section == 2)
        {
            NSLog(@"fam");
            History *history3 = [self.patientHistoryList3 objectAtIndex:indexPath.row];
            NSDateFormatter *dateformatter2 = [[NSDateFormatter alloc] init];
            [dateformatter2 setDateFormat:@"MMM dd, YYYY"];
            cell2.historyDateField.text = [NSString stringWithFormat:@"%@", [dateformatter2 stringFromDate:history3.date]];
            cell2.historyIllnessField.text = history3.illness;
            cell2.historyNotesField.text = history3.notes;
        }   
        
        return cell2;
    }

    
    else if (self.selectedSegmentIndex==1) {
        
        if (indexPath.row == checkRow) {
            CellIdentifier = @"Selected Consultation Cell";
            SelectedConsultationCell *cell1 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            //CGRect rect = CGRectMake(cell1.bounds.origin.x, cell1.bounds.origin.y, 703, 102);
            
            
            if (cell1 == nil) {
                cell1 = [[SelectedConsultationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            NSDateFormatter *dateformatter1 = [[NSDateFormatter alloc] init];
            [dateformatter1 setDateFormat:@"MMM dd, YYYY"];
            
            Consultation *consultation = [self.patientConsultationList objectAtIndex:indexPath.row];
            // Configure the cell...
            
            
            cell1.dateField.text = [NSString stringWithFormat:@"%@", [dateformatter1 stringFromDate:consultation.date]];
            cell1.heightField.text = consultation.height;
            cell1.weightField.text = consultation.weight;
            cell1.subjectiveField.text = consultation.subjective;
            cell1.objectiveField.text = consultation.objective;
            cell1.assessmentField.text = consultation.assessment;
            cell1.planField.text = consultation.plan;
            
            return cell1;
            
        }
        else
        {
            CellIdentifier = @"Consultation Cell";
            ConsultationCell *cell1 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell1 == nil) {
                cell1 = [[ConsultationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            NSDateFormatter *dateformatter1 = [[NSDateFormatter alloc] init];
            [dateformatter1 setDateFormat:@"MMM dd, YYYY"];
            
            Consultation *consultation = [self.patientConsultationList objectAtIndex:indexPath.row];
            // Configure the cell...
            
            cell1.dateField.text = [NSString stringWithFormat:@"%@", [dateformatter1 stringFromDate:consultation.date]];
            cell1.heightField.text = consultation.height;
            cell1.weightField.text = consultation.weight;
            cell1.subjectiveField.text = consultation.subjective;
            
            
            return cell1;
        }
    }

    else 
    {
        
        CellIdentifier3 = @"Report Cell";
        
        ReportCell *cell3 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier3];
        if (cell3 == nil) {
            cell3 = [[ReportCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier3];
        }
        
        Report *report = [self.patientReportsList objectAtIndex:indexPath.row];
        
        NSDateFormatter *dateformatter3 = [[NSDateFormatter alloc] init];
        [dateformatter3 setDateFormat:@"MMM dd, YYYY"];
        cell3.reportDateField.text = [NSString stringWithFormat:@"%@", [dateformatter3 stringFromDate:report.date]];
        cell3.reportTypeField.text = report.type;
        cell3.reportNotesField.text = report.notes;
        
        return cell3;
        
    }
     
                    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat result;
    if (self.selectedSegmentIndex == 1)
    {
        if (indexPath.row == checkRow)
        {
            result = 102;
        }
        else result = 40;
    }
    else result = 40;
    return result;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



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

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    if (self.selectedSegmentIndex == 1) {
        if([self.patientConsultationList count]==0){
            return @"";
        }
        else
            return @"CONSULTATION";
    }
    else if (self.selectedSegmentIndex == 0) {
   
       if(section==0) {
           if([self.patientHistoryList1 count]==0)
               return @"";
           else
            return @"ALLERGY";
       }
       else if(section==1){
           if([self.patientHistoryList2 count]==0)
               return @"";
           else
                return @"PAST ILLNESS";
       }
       else if(section==2){
           if([self.patientHistoryList3 count]==0)
               return @"";
           else
               return @"FAMILY HISTORY";
       }
       else{
           return @"IMMUNIZATION\nVaccine            1st         2nd           3rd         Booster1   Booster2   Booster3";
       }
        
    }
    else {
        return @"REPORTS GENERATED";
    }

}

// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}



// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.selectedSegmentIndex == 1) {
        self.checkRow = indexPath.row;
        [self.tableView reloadData];
    }

    else if (self.selectedSegmentIndex == 2) {
        NSLog(@"selected report");
        Report *currentReport = [self.patientReportsList objectAtIndex:indexPath.row]; 
        NSLog(@"type: %@", currentReport.type);
        if ([currentReport.type isEqualToString:@"CBC"]) 
        {
            NSLog(@"cbc cbc");
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
            UINavigationController *nav = [storyboard instantiateViewControllerWithIdentifier:@"DisplayCBC"];
            ShowCBC *showCBC = (id) nav.topViewController;         
            showCBC.managedObjectContext = self.managedObjectContext;
            showCBC.report = currentReport;
            NSLog(@"managed: %@", self.managedObjectContext);
            [self presentModalViewController:nav animated:YES];
            NSLog(@"hahahaha");
        }
        else if ([currentReport.type isEqualToString:@"Fecalysis"]) 
        {
            NSLog(@"cbc cbc2");
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
            UINavigationController *nav2 = [storyboard instantiateViewControllerWithIdentifier:@"DisplayFecalysis"];
            ShowFecalysis *showFecalysis = (id) nav2.topViewController;         
            showFecalysis.managedObjectContext = self.managedObjectContext;
            showFecalysis.report = currentReport;
            NSLog(@"managed: %@", self.managedObjectContext);
            [self presentModalViewController:nav2 animated:YES];
            NSLog(@"hahuhu");
        }
        else if ([currentReport.type isEqualToString:@"Urinalysis"]) 
        {
            NSLog(@"cbc cbc3");
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
            UINavigationController *nav3 = [storyboard instantiateViewControllerWithIdentifier:@"ReportsUrinalysisNav"];
            ShowUrinalysis *showUrinalysis = (id) nav3.topViewController;         
            showUrinalysis.managedObjectContext = self.managedObjectContext;
            showUrinalysis.report = currentReport;
            NSLog(@"managed: %@", self.managedObjectContext);
            [self presentModalViewController:nav3 animated:YES];
        }
        else if ([currentReport.type isEqualToString:@"Xray"]) 
        {
            NSLog(@"cbc cbc4");
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
            UINavigationController *nav4 = [storyboard instantiateViewControllerWithIdentifier:@"ReportsXrayNav"];
            ShowXray *showXray = (id) nav4.topViewController;         
            showXray.managedObjectContext = self.managedObjectContext;
            showXray.report = currentReport;
            NSLog(@"managed: %@", self.managedObjectContext);
            [self presentModalViewController:nav4 animated:YES];
        }
        else 
        {
            NSLog(@"others others");
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
            UINavigationController *nav1 = [storyboard instantiateViewControllerWithIdentifier:@"ReportsOthersNav"];
            ShowOthers *showOthers = (id) nav1.topViewController;         
            showOthers.managedObjectContext = self.managedObjectContext;
            showOthers.report = currentReport;
            NSLog(@"managed: %@", self.managedObjectContext);
            [self presentModalViewController:nav1 animated:YES];
        }
        
    }       

}


-(void)seePatientDetail:(Patient *)patient
{
    NSLog(@"gets at see");
    self.currentPatient = patient;
    NSLog(@"PATIENT NAME: %@", self.currentPatient.firstName);
 
        if(self.currentPatient.image != nil){
            self.iconView.image = [UIImage imageWithData:currentPatient.image];
        }else{
            self.iconView.image = [UIImage imageNamed:@"baby.png"];
        }
    
    
    NSPredicate *pred1 = [NSPredicate predicateWithFormat: @"(patientt.firstName CONTAINS[cd] %@) AND (type LIKE[cd] %@)", self.currentPatient.firstName, @"guardian"];
    self.parentMatched = [CoreDataHelper searchObjectsForEntity:@"Parent" withPredicate:pred1 andSortKey:@"firstName" andSortAscending:YES andContext:self.managedObjectContext];
    Parent *parent = [self.parentMatched objectAtIndex:0];
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"(patientt.firstName == %@)", self.currentPatient.firstName];
    NSPredicate *preda= [NSPredicate predicateWithFormat:@"(patientt.firstName == %@) AND (type == 'Allergy')", self.currentPatient.firstName];
    NSPredicate *predb = [NSPredicate predicateWithFormat:@"(patientt.firstName == %@) AND (type == 'Past Illness')", self.currentPatient.firstName];
    NSPredicate *predc = [NSPredicate predicateWithFormat:@"(patientt.firstName == %@) AND (type == 'Family History')", self.currentPatient.firstName];
    self.patientConsultationList = [CoreDataHelper searchObjectsForEntity:@"Consultation" withPredicate:pred andSortKey:@"date" andSortAscending:YES andContext:self.managedObjectContext];
    self.patientHistoryList1 = [CoreDataHelper searchObjectsForEntity:@"History" withPredicate:preda andSortKey:@"date" andSortAscending:YES andContext:self.managedObjectContext];
    self.patientHistoryList2 = [CoreDataHelper searchObjectsForEntity:@"History" withPredicate:predb andSortKey:@"date" andSortAscending:YES andContext:self.managedObjectContext];
    self.patientHistoryList3 = [CoreDataHelper searchObjectsForEntity:@"History" withPredicate:predc andSortKey:@"date" andSortAscending:YES andContext:self.managedObjectContext];
    self.patientReportsList = [CoreDataHelper searchObjectsForEntity:@"Report" withPredicate:pred andSortKey:@"date" andSortAscending:YES andContext:self.managedObjectContext];
    self.patientImmunizationList = [CoreDataHelper searchObjectsForEntity:@"Immunization" withPredicate:pred andSortKey:nil andSortAscending:NO andContext:self.managedObjectContext];
    
 
    [self.tableView reloadData];
    
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"MMMM dd, YYYY"];
    
    self.nameInput.text = [NSString stringWithFormat:@"%@ %@", self.currentPatient.firstName, self.currentPatient.lastName];
    self.contactInput.text = parent.cellphone;
    self.ageInput.text = [self getAge:currentPatient.birthdate];
    self.guardianInput.text = [NSString stringWithFormat:@"%@ %@", parent.firstName, parent.lastName];
    self.bdayInput.text = [dateformatter stringFromDate:currentPatient.birthdate];
        
   
    self.nameInput.userInteractionEnabled = NO;
    self.contactInput.userInteractionEnabled = NO;
    self.ageInput.userInteractionEnabled = NO;
    self.guardianInput.userInteractionEnabled = NO;
    self.bdayInput.userInteractionEnabled = NO;
    
    Immunization *im = [self.patientImmunizationList objectAtIndex:0];
    NSLog(@"PATIENT FIRSTNAME IMM: %@", im.patientt.firstName);
    NSLog(@"gets at see");
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"prepare");
    
    if ([[segue identifier] isEqualToString:@"ChartSegue"])
    {
        NSLog(@"HERE");
        
        UINavigationController *nav = [segue destinationViewController];
        CustomPagerViewController *vc = (CustomPagerViewController *)nav.topViewController;
        
        
        vc.birthDate = self.currentPatient.birthdate;
        
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"(patientt.firstName CONTAINS[cd] %@)", self.currentPatient.firstName];
        
        self.patientConsultationList = [CoreDataHelper searchObjectsForEntity:@"Consultation" withPredicate:pred andSortKey:@"date" andSortAscending:YES andContext:self.managedObjectContext];
        
        vc.consultationDates = [[NSMutableArray alloc]init];
        vc.weightValues = [[NSMutableArray alloc]init];
        vc.heightValues = [[NSMutableArray alloc]init];
        for(Consultation *consultation in self.patientConsultationList){
            [vc.consultationDates addObject:consultation.date];
            [vc.weightValues addObject:consultation.weight];
            [vc.heightValues addObject:consultation.height];
        }
        
        
        //vc.consultationDates = consul;
        
        NSLog(@" gender %@", self.currentPatient.gender);
        vc.patientGender = self.currentPatient.gender;
      
        
        
    }

    if ([[segue identifier] isEqualToString:@"SeeFullSegue"])
    {
        UINavigationController *seeFullNav = [segue destinationViewController];
        seeFullProfile = (SeeFullProfile *)seeFullNav.topViewController;
        seeFullProfile.managedObjectContext = self.managedObjectContext;
        seeFullProfile.delegate = self;
        seeFullProfile.patient = currentPatient;
    }
        
    if ([[segue identifier] isEqualToString:@"AddConsultationSegue"]) {
        UINavigationController *conNav = [segue destinationViewController];
        addConsultation = [[conNav viewControllers] objectAtIndex:0];
        addConsultation.delegate = self;
        addConsultation.managedObjectContext = self.managedObjectContext;
        addConsultation.patient = self.currentPatient;
    }
    if ([[segue identifier] isEqualToString:@"AddHistorySegue"])
    {
        UINavigationController *conNav = [segue destinationViewController];
        self.selectHistoryType = [[conNav viewControllers] objectAtIndex:0];
        self.selectHistoryType.delegate1 = self;
        self.selectHistoryType.delegate2 = self;
        self.selectHistoryType.delegate3 = self;
        self.selectHistoryType.delegate4 = self;
        self.selectHistoryType.managedObjectContext = self.managedObjectContext;
        NSLog(@"huhu his %@", self.managedObjectContext);
        self.selectHistoryType.patient = self.currentPatient;
    }
    if ([[segue identifier] isEqualToString:@"AddReportSegue"])
    {
        UINavigationController *repNav = [segue destinationViewController];
        addReport = [[repNav viewControllers] objectAtIndex:0];
        addReport.delegate = self;
        addReport.managedObjectContext = self.managedObjectContext;
        addReport.patient = self.currentPatient;
    }
    
}




- (IBAction)seeFullProfile:(id)sender {
    
    if(self.currentPatient != nil){
        [self performSegueWithIdentifier:@"SeeFullSegue" sender:self];
    }
}

- (IBAction)selectSegment:(UISegmentedControl *)sender 
{
    self.selectedSegmentIndex = sender.selectedSegmentIndex;
    [self.tableView reloadData];
    NSLog(@"patient index: %d", self.selectedSegmentIndex);
    NSLog(@"sender: %d", sender.selectedSegmentIndex);
    
    switch (self.selectedSegmentIndex) {
        case 0:
            NSLog(@"second");
            break;
        case 1:
            NSLog(@"first");
            break;
        
        case 2:
            NSLog(@"third");
            UIBarButtonItem *mailButton = [[UIBarButtonItem alloc] 
                                                           initWithTitle:@"Lab Request"                                            
                                                           style:UIBarButtonItemStylePlain 
                                                           target:self 
                                                           action:@selector(addRequest)];
            self.navigationItem.leftBarButtonItem = mailButton;
            
            break;
    }
}

- (void) addRequest
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    UINavigationController *nav = [storyboard instantiateViewControllerWithIdentifier:@"AddRequestNav"];
    AddRequest *addRequest = (id) nav.topViewController;
    addRequest.managedObjectContext = self.managedObjectContext;
    addRequest.patient = self.currentPatient;
    addRequest.delegate = self;
    [self presentModalViewController:nav animated:YES];
    NSLog(@"hahuhu");

}



-(IBAction)addTableCell:(id)sender
{
    if (self.selectedSegmentIndex == 1) 
    {
        NSLog(@"enter con segue");
       [self performSegueWithIdentifier:@"AddConsultationSegue" sender:self];
    }
    else if (self.selectedSegmentIndex == 0)
    {
        [self performSegueWithIdentifier:@"AddHistorySegue" sender:self];
    }
    else [self performSegueWithIdentifier:@"AddReportSegue" sender:self];

}

- (void) saveConsultationTable
{
    [self dismissModalViewControllerAnimated:YES];
    NSLog(@"enter save consult");
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"(patientt.firstName CONTAINS[cd] %@)", currentPatient.firstName];
    
    self.patientConsultationList = [CoreDataHelper searchObjectsForEntity:@"Consultation" withPredicate:pred andSortKey:@"date" andSortAscending:YES andContext:self.managedObjectContext];
        
    [self.tableView reloadData];
    NSLog(@"enter save consult");
    
}

- (void) saveHistoryTable
{
    [self dismissModalViewControllerAnimated:YES];
    NSLog(@"enter save history");
    NSPredicate *preda= [NSPredicate predicateWithFormat:@"(patientt.firstName == %@) AND (type == 'Allergy')", self.currentPatient.firstName];
    NSPredicate *predb = [NSPredicate predicateWithFormat:@"(patientt.firstName == %@) AND (type == 'Past Illness')", self.currentPatient.firstName];
    NSPredicate *predc = [NSPredicate predicateWithFormat:@"(patientt.firstName == %@) AND (type == 'Family History')", self.currentPatient.firstName];
    self.patientHistoryList1 = [CoreDataHelper searchObjectsForEntity:@"History" withPredicate:preda andSortKey:@"date" andSortAscending:YES andContext:self.managedObjectContext];
    self.patientHistoryList2 = [CoreDataHelper searchObjectsForEntity:@"History" withPredicate:predb andSortKey:@"date" andSortAscending:YES andContext:self.managedObjectContext];
    self.patientHistoryList3 = [CoreDataHelper searchObjectsForEntity:@"History" withPredicate:predc andSortKey:@"date" andSortAscending:YES andContext:self.managedObjectContext];

    NSLog(@"ALLERGY COUNT %d", [self.patientHistoryList1 count]);
    NSLog(@"ALLERGY COUNT %d", [self.patientHistoryList2 count]); 
    NSLog(@"ALLERGY COUNT %d", [self.patientHistoryList3 count]); 
    [self.tableView reloadData];
    NSLog(@"enter save history");

}

- (void) saveImmunizationTable
{
    [self dismissModalViewControllerAnimated:YES];
    NSLog(@"enter save immunization");
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"(patientt == %@)", self.currentPatient];
    
    self.patientImmunizationList = [CoreDataHelper searchObjectsForEntity:@"Immunization" withPredicate:pred andSortKey:nil andSortAscending:NO andContext:self.managedObjectContext];   
    
    NSLog(@"before reload");
    [self.tableView reloadData];
    NSLog(@"enter save history");
    
}
- (void)saveCBCReport:(Patient *)patient
{
    NSLog(@"save cbc in prof");
    [self dismissModalViewControllerAnimated:YES];
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"(patientt.firstName CONTAINS[cd] %@)", currentPatient.firstName];
    
    self.patientReportsList = [CoreDataHelper searchObjectsForEntity:@"Report" withPredicate:pred andSortKey:@"date" andSortAscending:YES andContext:self.managedObjectContext];
    
    [self.tableView reloadData];
}

- (void) saveFecalysisReport:(Patient *)patient
{
    NSLog(@"save f in prof");
    [self dismissModalViewControllerAnimated:YES];
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"(patientt.firstName CONTAINS[cd] %@)", currentPatient.firstName];
    
    self.patientReportsList = [CoreDataHelper searchObjectsForEntity:@"Report" withPredicate:pred andSortKey:@"date" andSortAscending:YES andContext:self.managedObjectContext];
    
    [self.tableView reloadData];
}

- (void) saveUrinalysisReport:(Patient *)patient
{
    NSLog(@"save u in prof");
    [self dismissModalViewControllerAnimated:YES];
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"(patientt.firstName CONTAINS[cd] %@)", currentPatient.firstName];
    
    self.patientReportsList = [CoreDataHelper searchObjectsForEntity:@"Report" withPredicate:pred andSortKey:@"date" andSortAscending:YES andContext:self.managedObjectContext];
    
    [self.tableView reloadData];
}

- (void) saveXrayReport:(Patient *)patient
{
    NSLog(@"save x in prof");
    [self dismissModalViewControllerAnimated:YES];
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"(patientt.firstName CONTAINS[cd] %@)", currentPatient.firstName];
    
    self.patientReportsList = [CoreDataHelper searchObjectsForEntity:@"Report" withPredicate:pred andSortKey:@"date" andSortAscending:YES andContext:self.managedObjectContext];
    
    [self.tableView reloadData];
}

- (void) saveOthersReport:(Patient *)patient
{
    NSLog(@"save o in prof");
    [self dismissModalViewControllerAnimated:YES];
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"(patientt.firstName CONTAINS[cd] %@)", currentPatient.firstName];
    
    self.patientReportsList = [CoreDataHelper searchObjectsForEntity:@"Report" withPredicate:pred andSortKey:@"date" andSortAscending:YES andContext:self.managedObjectContext];
    
    [self.tableView reloadData];
}

@end
