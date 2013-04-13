//
//  PatientProfile.h
//  TestProject
//
//  Created by BerDy on 1/11/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

#import "PatientProfileDelegate.h"
#import "PatientTVCDelegate.h"
#import "Patient.h"
#import "SeeFullProfile.h"
#import "AddConsultation.h"
#import "AddConsultationDelegate.h"
#import "AddHistoryDelegate.h"
#import "AddHistory.h"
#import "AddReport.h"
#import "PatientAddDelegate.h"
#import "SeeFullProfileDelegate.h"
#import "AddReportDelegate.h"
#import "ReportXrayDelegate.h"
#import "ReportUrinalysisDelegate.h"
#import "ReportOthersDelegate.h"
#import "ReportFecalysisDelegate.h"
#import "ReportCBCDelegate.h"
#import "SelectHistoryType.h"
#import "SelectHistoryTypeDelegate.h"
#import "AddHistoryDelegate.h"
#import "AddImmunizationDelegate.h"
#import "AddRequestDelegate.h"

@interface PatientProfile : UITableViewController <UISplitViewControllerDelegate, PatientTVCDelegate, AddConsultationDelegate, AddHistoryDelegate,  SeeFullProfileDelegate, AddReportDelegate, ReportCBCDelegate, ReportFecalysisDelegate, ReportOthersDelegate, ReportUrinalysisDelegate, ReportXrayDelegate, SelectHistoryTypeDelegate, AddImmunizationDelegate, AddHistoryDelegate, AddRequestDelegate,MFMailComposeViewControllerDelegate>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (retain, nonatomic) id <PatientProfileDelegate> delegate;

@property (strong, nonatomic) NSMutableArray *patientConsultationList;
@property (strong, nonatomic) NSMutableArray *patientHistoryList1;
@property (strong, nonatomic) NSMutableArray *patientHistoryList2;
@property (strong, nonatomic) NSMutableArray *patientHistoryList3;
@property (strong, nonatomic) NSMutableArray *patientReportsList;
@property (strong, nonatomic) NSMutableArray *patientImmunizationList;
@property (strong, nonatomic) NSMutableArray *parentMatched;
@property (strong, nonatomic) NSMutableArray *vaccineList;

@property (strong, nonatomic) Patient *currentPatient;
@property (strong, nonatomic) SeeFullProfile *seeFullProfile;
@property (strong, nonatomic) UIPopoverController *seeProfilePopover;
@property (strong, nonatomic) AddConsultation *addConsultation;
@property (strong, nonatomic) UIPopoverController *addConsultationPopover;
@property (strong, nonatomic) SelectHistoryType *selectHistoryType;
@property (strong, nonatomic) AddReport *addReport;
@property (strong, nonatomic) UIPopoverController *addHistoryPopover;
@property (weak, nonatomic) IBOutlet UIView *patientDetailView;

@property (assign, nonatomic) NSInteger checkRow;
@property (assign, nonatomic) NSInteger selectedSegmentIndex;

@property (weak, nonatomic) IBOutlet UITextField *nameInput;
@property (weak, nonatomic) IBOutlet UITextField *ageInput;
@property (weak, nonatomic) IBOutlet UITextField *contactInput;
@property (weak, nonatomic) IBOutlet UITextField *bdayInput;
@property (weak, nonatomic) IBOutlet UITextField *guardianInput;

@property (weak, nonatomic) IBOutlet UIImageView *iconView;


- (IBAction)seeFullProfile:(id)sender;
- (IBAction)selectSegment:(UISegmentedControl *)sender;
- (IBAction)addTableCell:(id)sender;
- (IBAction)performLongPress:(UIGestureRecognizer *)sender;

@end
