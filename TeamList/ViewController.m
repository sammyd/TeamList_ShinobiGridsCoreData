//
//  ViewController.m
//  TeamList
//
//  Created by Sam Davies on 04/06/2013.
//  Copyright (c) 2013 Shinobi Controls. All rights reserved.
//

#import "ViewController.h"
#import "TeamListDAO.h"
#import "ShinobiLicense.h"


@implementation ViewController {
    ShinobiDataGrid *_grid;
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
    _grid = [[ShinobiDataGrid alloc] initWithFrame:self.view.bounds];
    // Assign the license
    _grid.licenseKey = [ShinobiLicense getShinobiLicenseKey];
    _grid.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    // Add the appropriate columns
    [@[@"name", @"phone", @"email"] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        // Create a column
        SDataGridColumn *col = [SDataGridColumn columnWithTitle:obj forProperty:obj];
        col.sortMode = SDataGridColumnSortModeBiState;
        col.editable = YES;
        // Add it to the grid
        [_grid addColumn:col];
    }];
    
    datasourceHelper = [[SDataGridDataSourceHelper alloc] initWithDataGrid:_grid];
    
    // Assign the data to the helper
    datasourceHelper.data = [[TeamListDAO sharedInstance] getEmployeeList];
    
    // Set the datasource helper's delegate so we can listen to edit events
    datasourceHelper.delegate = self;
    
    // And add the grid to the view
    [self.view addSubview:_grid];
}

#pragma mark - SDataGridDataSourceHelperDelegate methods
- (void)shinobiDataGrid:(ShinobiDataGrid *)grid didFinishEditingCellAtCoordinate:(const SDataGridCoord *)coordinate
{
    // Get hold of the cell
    SDataGridTextCell *cell = (SDataGridTextCell*)[grid visibleCellAtCoordinate:[SDataGridCoord coordinateWithCol:coordinate.column row:coordinate.row]];
    
    // Get the new text value
    NSString *newText = cell.textField.text;
    
    // Find the correct data model
    Employee *editedEmployee = datasourceHelper.sortedData[coordinate.row.rowIndex];
    
    // We can use KVO
    [editedEmployee setValue:newText forKey:coordinate.column.propertyKey];
    
    // And now we need to save the change
    [[TeamListDAO sharedInstance] save];
}

@end
