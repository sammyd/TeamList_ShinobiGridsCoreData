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
#import "SdataGridImageCell.h"
#import <ShinobiGrids/SDataGridDataGroup.h>


@implementation ViewController {
    ShinobiDataGrid *_grid;
    SDataGridDataSourceHelper *datasourceHelper;
    Employee *employeeToDelete;
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
    
    // Now want to add a column to contain the delete buttons
    SDataGridColumn *col = [SDataGridColumn columnWithTitle:@""
                                                forProperty:@"delete"
                                                   cellType:[SdataGridImageCell class]
                                             headerCellType:[SDataGridHeaderCell class]];
    col.sortMode = SDataGridColumnSortModeNone;
    col.editable = NO;
    // Our delete icon is square
    col.width = _grid.defaultRowHeight;
    [_grid addColumn:col];
    
    datasourceHelper = [[SDataGridDataSourceHelper alloc] initWithDataGrid:_grid];
    
    // Assign the data to the helper
    datasourceHelper.data = [[TeamListDAO sharedInstance] getEmployeeList];
    
    // Set the datasource helper's delegate so we can listen to edit events
    datasourceHelper.delegate = self;
    
    // Set the data source helper to use grouping
    datasourceHelper.groupedPropertyKey = @"team";
    datasourceHelper.groupedPropertySortOrder = SDataGridColumnSortOrderAscending;
    
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

- (id)dataGridDataSourceHelper:(SDataGridDataSourceHelper *)helper displayValueForProperty:(NSString *)propertyKey withSourceObject:(id)object
{
    if([propertyKey isEqualToString:@"delete"]) {
        // We'll pass an image back for the delete column
        return [UIImage imageNamed:@"Delete-icon"];
    }
    // All the other columns should use the default behaviour
    return nil;
}

- (BOOL)dataGridDataSourceHelper:(SDataGridDataSourceHelper *)helper populateCell:(SDataGridCell *)cell withValue:(id)value forProperty:(NSString *)propertyKey sourceObject:(id)object
{
    if([propertyKey isEqualToString:@"delete"]) {
        // Populate the image cell correctly
        SdataGridImageCell *imageCell = (SdataGridImageCell*)cell;
        imageCell.image = value;
        // Tell the data source helper that we have populated it
        return YES;
    }
    // All the other columns should use the default behaviour
    return NO;
}

- (id)dataGridDataSourceHelper:(SDataGridDataSourceHelper *)helper groupValueForProperty:(NSString *)propertyKey withSourceObject:(id)object
{
    if([propertyKey isEqualToString:@"team"]) {
        // We've been asked for a team. We want to return the team name
        Employee *e = (Employee*)object;
        return e.team.name;
    }
    return nil;
}

- (void)shinobiDataGrid:(ShinobiDataGrid *)grid didTapCellAtCoordinate:(const SDataGridCoord *)gridCoordinate isDoubleTap:(BOOL)isDoubleTap
{
    // Only interested in single taps
    if(isDoubleTap) {
        return;
    }
    
    // Only interested in the delete column
    if([gridCoordinate.column.propertyKey isEqualToString:@"delete"]) {
        // Get hold of the employee record
        SDataGridDataGroup *dataGroup = datasourceHelper.sortedData[gridCoordinate.row.sectionIndex];
        employeeToDelete = dataGroup.items[gridCoordinate.row.rowIndex];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Delete User?"
                                                        message:[NSString stringWithFormat:@"Are you sure that you want to delete the employee record for %@?", employeeToDelete.name]
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@"Delete", nil];
        [alert show];
    }
    
}

#pragma mark - UIAlertViewDelegate methods
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == alertView.firstOtherButtonIndex) {
        TeamListDAO *dao = [TeamListDAO sharedInstance];
        
        // So we should delete the employee we've got cached
        [dao deleteEmployee:employeeToDelete];
        // Save the changes to the datasource
        [dao save];
        // Tell the datasource helper that we need to reload the data. Note that
        //  we can't use the reloadData method because of the way our DAO works.
        datasourceHelper.data = [dao getEmployeeList];
    }
    // Reset the cached variable
    employeeToDelete = nil;
}

@end
