//
//  Employee.h
//  TeamList
//
//  Created by Sam Davies on 11/05/2013.
//  Copyright (c) 2013 Shinobi Controls. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Employee : NSManagedObject

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * phone;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSManagedObject *team;

@end
