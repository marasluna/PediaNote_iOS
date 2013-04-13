//
//  SelectClinicDelegate.h
//  TestProject
//
//  Created by Team Ganda on 3/25/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Clinic.h"
@protocol SelectClinicDelegate <NSObject>
- (void) didSelectClinic:(Clinic *) pClinic;

@end
