//
//  SelectDoseDelegate.h
//  TestProject
//
//  Created by BerDy on 1/21/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SelectDoseDelegate <NSObject>

- (void)getDose:(NSInteger)row;
@end
