//
//  Team.h
//  TeamList
//
//  Created by Sam Davies on 11/05/2013.
//  Copyright (c) 2013 Shinobi Controls. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Employee;

@interface Team : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSSet *members;
@end

@interface Team (CoreDataGeneratedAccessors)

- (void)addMembersObject:(Employee *)value;
- (void)removeMembersObject:(Employee *)value;
- (void)addMembers:(NSSet *)values;
- (void)removeMembers:(NSSet *)values;

@end
