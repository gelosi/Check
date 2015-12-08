//
//  ChecklistDataSource.m
//  Check
//
//  Created by Oleg Shanyuk on 12/6/15.
//  Copyright © 2015 xaTa. All rights reserved.
//

#include "ChecklistDataSource.h"

NS_ASSUME_NONNULL_BEGIN

static NSUInteger const ActiveTasksSectionIndex = 0;
static NSUInteger const CompleteTasksSectionIndex = 1;



@implementation ChecklistDataSource

-(instancetype)initWithCheckList:(CheckList *)checkList
{
    self = [super init];
    
    if (self) {
        _checkList = checkList;
    }
    
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.checkList.completeTasks.taskCount > 0) {
        return 2;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self taskListForSection:section].taskCount;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = [self cellIdentifierForIndexPath:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    [self configureCell:cell forIndexPath:indexPath];
    
    return cell;
}



#pragma mark - helper methods

-(NSString *)cellIdentifierForIndexPath:(NSIndexPath *)indexPath
{
    // we can control which cells we actually want to have for different sections, etc
    return @"cell";
}

-(void)configureCell:(UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath
{
    TaskList *tasks = [self taskListForSection:indexPath.section];
    
    id<Task> task = [tasks taskAtIndex:indexPath.row];
    
    cell.textLabel.text = task.title;
    cell.accessoryType = task.complete ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
}

-(TaskList *)taskListForSection:(NSInteger)section
{
    switch (section) {
        case ActiveTasksSectionIndex:
            return self.checkList.activeTasks;
        case CompleteTasksSectionIndex:
            return self.checkList.completeTasks;
        default:
            return nil;
    }
}

@end

NS_ASSUME_NONNULL_END
