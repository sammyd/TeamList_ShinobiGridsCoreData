//
//  TeamListDAOProtocol.h
//  TeamList
//
//  Created by Sam Davies on 11/05/2013.
//  Copyright (c) 2013 Shinobi Controls. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Employee.h"
#import "Team.h"

@protocol TeamListDAOProtocol <NSObject>

- (NSArray *)getEmployeeList;
- (void)deleteEmployee:(Employee *)employee;
- (Employee *)createEmployee;

- (void)save;

@end
