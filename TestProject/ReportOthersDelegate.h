//
//  ReportOthersDelegate.h
//  TestProject
//
//  Created by BerDy on 1/20/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Patient.h"

@protocol ReportOthersDelegate <NSObject>

- (void)saveOthersReport:(Patient *)patient;
@end
