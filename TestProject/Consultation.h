//
//  Consultation.h
//  TestProject
//
//  Created by BerDy on 1/22/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Patient;

@interface Consultation : NSManagedObject

@property (nonatomic, retain) NSString * assessment;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * height;
@property (nonatomic, retain) NSString * objective;
@property (nonatomic, retain) NSString * plan;
@property (nonatomic, retain) NSString * subjective;
@property (nonatomic, retain) NSString * weight;
@property (nonatomic, retain) Patient *patientt;

@end
