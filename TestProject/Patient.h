//
//  Patient.h
//  TestProject
//
//  Created by Team Ganda on 3/25/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Appointment, Clinic, Consultation, History, Immunization, Parent, Report;

@interface Patient : NSManagedObject

@property (nonatomic, retain) NSString * abdominalCircum;
@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * age;
@property (nonatomic, retain) NSDate * birthdate;
@property (nonatomic, retain) NSString * birthHeight;
@property (nonatomic, retain) NSString * birthWeight;
@property (nonatomic, retain) NSString * bloodtype;
@property (nonatomic, retain) NSString * chestCircum;
@property (nonatomic, retain) NSString * delivery;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * gender;
@property (nonatomic, retain) NSString * headCircum;
@property (nonatomic, retain) NSData * image;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSString * middleName;
@property (nonatomic, retain) NSString * term;
@property (nonatomic, retain) NSSet *appointment;
@property (nonatomic, retain) NSSet *consultations;
@property (nonatomic, retain) NSSet *historys;
@property (nonatomic, retain) Immunization *immunizations;
@property (nonatomic, retain) NSSet *parents;
@property (nonatomic, retain) NSSet *reports;
@property (nonatomic, retain) Clinic *clinic;
@end

@interface Patient (CoreDataGeneratedAccessors)

- (void)addAppointmentObject:(Appointment *)value;
- (void)removeAppointmentObject:(Appointment *)value;
- (void)addAppointment:(NSSet *)values;
- (void)removeAppointment:(NSSet *)values;
- (void)addConsultationsObject:(Consultation *)value;
- (void)removeConsultationsObject:(Consultation *)value;
- (void)addConsultations:(NSSet *)values;
- (void)removeConsultations:(NSSet *)values;
- (void)addHistorysObject:(History *)value;
- (void)removeHistorysObject:(History *)value;
- (void)addHistorys:(NSSet *)values;
- (void)removeHistorys:(NSSet *)values;
- (void)addParentsObject:(Parent *)value;
- (void)removeParentsObject:(Parent *)value;
- (void)addParents:(NSSet *)values;
- (void)removeParents:(NSSet *)values;
- (void)addReportsObject:(Report *)value;
- (void)removeReportsObject:(Report *)value;
- (void)addReports:(NSSet *)values;
- (void)removeReports:(NSSet *)values;
@end
