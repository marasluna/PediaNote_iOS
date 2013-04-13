//
//  Report.h
//  TestProject
//
//  Created by BerDy on 1/22/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Patient;

@interface Report : NSManagedObject

@property (nonatomic, retain) NSString * d1;
@property (nonatomic, retain) NSString * d2;
@property (nonatomic, retain) NSString * d3;
@property (nonatomic, retain) NSString * d4;
@property (nonatomic, retain) NSString * d5;
@property (nonatomic, retain) NSString * d6;
@property (nonatomic, retain) NSString * d7;
@property (nonatomic, retain) NSString * d8;
@property (nonatomic, retain) NSString * d9;
@property (nonatomic, retain) NSString * d10;
@property (nonatomic, retain) NSString * d11;
@property (nonatomic, retain) NSString * d12;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) Patient *patientt;

@end
