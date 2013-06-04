//
//  ViewController.m
//  TeamList
//
//  Created by Sam Davies on 04/06/2013.
//  Copyright (c) 2013 Shinobi Controls. All rights reserved.
//

#import "ViewController.h"
#import <ShinobiGrids/ShinobiDataGrid.h>
#import <ShinobiGrids/SDataGridDataSourceHelper.h>
#import "TeamListDAO.h"
#import "ShinobiLicense.h"

@implementation ViewController {
    ShinobiDataGrid *grid;
    SDataGridDataSourceHelper *datasourceHelper;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self createGrid];
}

- (void)createGrid
{
    // Create a grid
    grid = [[ShinobiDataGrid alloc] initWithFrame:self.view.bounds];
    // Assign the license
    grid.licenseKey = [ShinobiLicense getShinobiLicenseKey];
    
    // Add the appropriate columns
    [@[@"name", @"phone", @"email"] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        // Create a column
        SDataGridColumn *col = [SDataGridColumn columnWithTitle:obj forProperty:obj];
        col.sortMode = SDataGridColumnSortModeBiState;
        // Add it to the grid
        [grid addColumn:col];
    }];
    
    datasourceHelper = [[SDataGridDataSourceHelper alloc] initWithDataGrid:grid];
    
    // Assign the data to the helper
    datasourceHelper.data = [[TeamListDAO sharedInstance] getEmployeeList];
    
    // And add the grid to the view
    [self.view addSubview:grid];
}

@end
