//
//  PatientTVCDelegate.h
//  TestProject
//
//  Created by BerDy on 1/11/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Patient.h"

@protocol PatientTVCDelegate <NSObject>

-(void)seePatientDetail:(Patient *)patient;

@end
