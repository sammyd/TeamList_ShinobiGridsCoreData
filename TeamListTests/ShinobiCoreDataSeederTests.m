//
//  ShinobiCoreDataSeederTests.m
//  TeamList
//
//  Created by Sam Davies on 29/05/2013.
//  Copyright (c) 2013 Shinobi Controls. All rights reserved.
//

#import "ShinobiCoreDataSeederTests.h"
#import "ShinobiCoreDataSeeder.h"
#import "TeamListDAO.h"

@implementation ShinobiCoreDataSeederTests {
    id<TeamListDAOProtocol> dao;
}

- (void)setUp
{
    [super setUp];
    // Save the ivar
    dao = [TeamListDAO sharedInstance];
    // Always start empty
    [ShinobiCoreDataSeeder emptyCoreData];
}


#pragma mark - Tests for the core data seeder class
- (void)testSeedCoreDataCreatesEmployeeRecords
{
    // Should start empty
    STAssertEquals([dao getEmployeeList].count, 0U, @"CoreData should start empty");
    
    // Seed core data
    [ShinobiCoreDataSeeder seedCoreData];
    
    // There should now be some employee records
    STAssertTrue([dao getEmployeeList].count > 0, @"Seeding coredata should create some employee records");
}

- (void)testSeedCoreDataCreatesTheCorrectNumberOfEmployeeRecords
{
    // Seed it
    [ShinobiCoreDataSeeder seedCoreData];
    
    // Check we have the correct number
    STAssertEquals([dao getEmployeeList].count, [ShinobiCoreDataSeeder numberOfEmployeesToCreate], @"Seeder should create the correct number of employees");
}

- (void)testEmptyCoreDataRemovesAllEmployeeRecords
{
    // Pop some records into the data store
    [ShinobiCoreDataSeeder seedCoreData];
    
    // Empty
    [ShinobiCoreDataSeeder emptyCoreData];
    
    STAssertTrue([dao getEmployeeList].count == 0, @"Emptying core data should remove all employees");
}

@end
