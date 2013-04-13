//
//  Parent.h
//  TestProject
//
//  Created by BerDy on 1/22/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Patient;

@interface Parent : NSManagedObject

@property (nonatomic, retain) NSString * cellphone;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSSet *patientt;
@end

@interface Parent (CoreDataGeneratedAccessors)

- (void)addPatienttObject:(Patient *)value;
- (void)removePatienttObject:(Patient *)value;
- (void)addPatientt:(NSSet *)values;
- (void)removePatientt:(NSSet *)values;
@end
