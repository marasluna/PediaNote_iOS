//
//  Immunization.h
//  TestProject
//
//  Created by BerDy on 1/22/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Patient;

@interface Immunization : NSManagedObject

@property (nonatomic, retain) NSDate * bcg1;
@property (nonatomic, retain) NSDate * bcg2;
@property (nonatomic, retain) NSDate * bcg3;
@property (nonatomic, retain) NSDate * bcg4;
@property (nonatomic, retain) NSDate * bcg5;
@property (nonatomic, retain) NSDate * bcg6;
@property (nonatomic, retain) NSDate * d1;
@property (nonatomic, retain) NSDate * d2;
@property (nonatomic, retain) NSDate * d3;
@property (nonatomic, retain) NSDate * d4;
@property (nonatomic, retain) NSDate * d5;
@property (nonatomic, retain) NSDate * d6;
@property (nonatomic, retain) NSDate * hepa1;
@property (nonatomic, retain) NSDate * hepa2;
@property (nonatomic, retain) NSDate * hepa3;
@property (nonatomic, retain) NSDate * hepa4;
@property (nonatomic, retain) NSDate * hepa5;
@property (nonatomic, retain) NSDate * hepa6;
@property (nonatomic, retain) NSDate * influenza1;
@property (nonatomic, retain) NSDate * influenza2;
@property (nonatomic, retain) NSDate * influenza3;
@property (nonatomic, retain) NSDate * influenza4;
@property (nonatomic, retain) NSDate * influenza5;
@property (nonatomic, retain) NSDate * influenza6;
@property (nonatomic, retain) NSDate * influenzaB1;
@property (nonatomic, retain) NSDate * influenzaB2;
@property (nonatomic, retain) NSDate * influenzaB3;
@property (nonatomic, retain) NSDate * influenzaB4;
@property (nonatomic, retain) NSDate * influenzaB5;
@property (nonatomic, retain) NSDate * influenzaB6;
@property (nonatomic, retain) NSDate * measles1;
@property (nonatomic, retain) NSDate * measles2;
@property (nonatomic, retain) NSDate * measles3;
@property (nonatomic, retain) NSDate * measles4;
@property (nonatomic, retain) NSDate * measles5;
@property (nonatomic, retain) NSDate * measles6;
@property (nonatomic, retain) NSDate * mmr1;
@property (nonatomic, retain) NSDate * mmr2;
@property (nonatomic, retain) NSDate * mmr3;
@property (nonatomic, retain) NSDate * mmr4;
@property (nonatomic, retain) NSDate * mmr5;
@property (nonatomic, retain) NSDate * mmr6;
@property (nonatomic, retain) NSDate * o1;
@property (nonatomic, retain) NSDate * o2;
@property (nonatomic, retain) NSDate * o3;
@property (nonatomic, retain) NSDate * o4;
@property (nonatomic, retain) NSDate * o5;
@property (nonatomic, retain) NSDate * o6;
@property (nonatomic, retain) NSDate * rota1;
@property (nonatomic, retain) NSDate * rota2;
@property (nonatomic, retain) NSDate * rota3;
@property (nonatomic, retain) NSDate * rota4;
@property (nonatomic, retain) NSDate * rota5;
@property (nonatomic, retain) NSDate * rota6;
@property (nonatomic, retain) NSDate * typhoid1;
@property (nonatomic, retain) NSDate * typhoid2;
@property (nonatomic, retain) NSDate * typhoid3;
@property (nonatomic, retain) NSDate * typhoid4;
@property (nonatomic, retain) NSDate * typhoid5;
@property (nonatomic, retain) NSDate * typhoid6;
@property (nonatomic, retain) Patient *patientt;

@end
