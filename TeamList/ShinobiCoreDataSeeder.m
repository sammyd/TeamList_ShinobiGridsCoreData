//
//  ShinobiCoreDataSeeder.m
//  TeamList
//
//  Created by Sam Davies on 11/05/2013.
//  Copyright (c) 2013 Shinobi Controls. All rights reserved.
//

#import "ShinobiCoreDataSeeder.h"
#import "TeamListDAO.h"

@implementation ShinobiCoreDataSeeder

+ (void)seedCoreData
{
    id<TeamListDAOProtocol> dao = [TeamListDAO sharedInstance];
    
    for(NSUInteger i=0; i<[self numberOfEmployeesToCreate]; i++) {
        Employee *e = [dao createEmployee];
        e.name = [NSString stringWithFormat:@"Employee %d", i];
        e.phone = [NSString stringWithFormat:@"%08d", (12345678 - i)];
        e.email = [NSString stringWithFormat:@"employee_%02d@company.com", i];
    }
    
    // Save the context
    [dao save];
}

+ (void)emptyCoreData
{
    // Remove all the employees
    id<TeamListDAOProtocol> dao = [TeamListDAO sharedInstance];
    
    NSArray *employees = [dao getEmployeeList];
    
    for (Employee *e in employees) {
        [dao deleteEmployee:e];
    }
    
    // Save to fix the changes
    [dao save];
}

+ (NSUInteger)numberOfEmployeesToCreate
{
    return 10;
}

@end
