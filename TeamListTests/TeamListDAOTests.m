//
//  TeamListDAOTests.m
//  TeamList
//
//  Created by Sam Davies on 11/05/2013.
//  Copyright (c) 2013 Shinobi Controls. All rights reserved.
//

#import "TeamListDAOTests.h"
#import "TeamListDAO.h"
#import "ShinobiCoreDataSeeder.h"

@implementation TeamListDAOTests {
    id<TeamListDAOProtocol> dao;
}

- (void)setUp
{
    [super setUp];
    dao = [TeamListDAO sharedInstance];
}

- (void)tearDown
{
    // Spot of tidying up after each test
    [ShinobiCoreDataSeeder emptyCoreData];
    
    [super tearDown];
}

- (void)testCreatingAnEmployeeIncreasesTheCount
{
    NSUInteger startCount = [dao getEmployeeList].count;
    
    // Get the employee
    Employee *newEmployee = [dao createEmployee];
    newEmployee.name = @"new employee";
    newEmployee.phone = @"1234";
    newEmployee.email = @"new@employee.com";
    
    // Save the context
    [dao save];
    
    // Refresh
    STAssertEquals(startCount + 1, [dao getEmployeeList].count, @"Creating new employee increments the count by 1");
}

- (void)testCreatingATeamIncreasesTheCount
{
    NSUInteger startCount = [[dao getTeamList] count];
    
    // Get the team
    Team *newTeam = [dao createTeam];
    newTeam.name = @"new team";
    
    // Save the context
    [dao save];
    
    // Refresh
    STAssertEquals(startCount + 1, [[dao getTeamList] count], @"Creating a new team increments the count by 1");
}


@end
