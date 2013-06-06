//
//  ShinobiCoreDataSeeder.h
//  TeamList
//
//  Created by Sam Davies on 11/05/2013.
//  Copyright (c) 2013 Shinobi Controls. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShinobiCoreDataSeeder : NSObject

/**
 Populate our core data store with some sample data
 */
+ (void)seedCoreData;

/**
 Dispose of all our sample data
 */
+ (void)emptyCoreData;

/**
 Number of employee records to create
 */
+ (NSUInteger)numberOfEmployeesToCreate;

/**
 Number of teams to create
 */
+ (NSUInteger)numberOfTeamsToCreate;

@end
