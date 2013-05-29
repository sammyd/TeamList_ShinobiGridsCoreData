//
//  TeamListDAO.h
//  TeamList
//
//  Created by Sam Davies on 11/05/2013.
//  Copyright (c) 2013 Shinobi Controls. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TeamListDAOProtocol.h"

@interface TeamListDAO : NSObject <TeamListDAOProtocol>

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+ (id)sharedInstance;

@end
