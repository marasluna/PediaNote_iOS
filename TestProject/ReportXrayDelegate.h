//
//  ReportXrayDelegate.h
//  TestProject
//
//  Created by BerDy on 1/19/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Patient.h"

@protocol ReportXrayDelegate <NSObject>

- (void)saveXrayReport:(Patient *)patient;
@end
