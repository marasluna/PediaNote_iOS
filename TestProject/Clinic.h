//
//  Clinic.h
//  TestProject
//
//  Created by Team Ganda on 3/25/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Patient;

@interface Clinic : NSManagedObject

@property (nonatomic, retain) NSString * location;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * schedule;
@property (nonatomic, retain) NSSet *patientList;
@end

@interface Clinic (CoreDataGeneratedAccessors)

- (void)addPatientListObject:(Patient *)value;
- (void)removePatientListObject:(Patient *)value;
- (void)addPatientList:(NSSet *)values;
- (void)removePatientList:(NSSet *)values;
@end
