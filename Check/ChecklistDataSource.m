//
//  ChecklistDataSource.m
//  Check
//
//  Created by Oleg Shanyuk on 12/6/15.
//  Copyright © 2015 xaTa. All rights reserved.
//

#include "ChecklistDataSource.h"

NS_ASSUME_NONNULL_BEGIN

NS_ENUM(NSUInteger, TaskSection) {
    TaskSectionActive = 0,
    TaskSectionComplete
};


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

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self deleteTaskAtIndexPath:indexPath];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    id sourceTask = [[self taskListForSection:sourceIndexPath.section] taskAtIndex:sourceIndexPath.row];
    [self deleteTaskAtIndexPath:sourceIndexPath];
    [self addTask:sourceTask atIndexPath:destinationIndexPath];
    
    [tableView reloadRowsAtIndexPaths:@[sourceIndexPath, destinationIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}


#pragma mark - Source Methods

-(void)addTask:(id<Task>)newTask atIndexPath:(NSIndexPath *)indexPath
{
    TaskList *taskList = [self taskListForSection:indexPath.section];
    
    [taskList addTask:newTask atIndex:indexPath.row];
}

-(void)updateTask:(id<Task>)newTask atIndexPath:(NSIndexPath *)indexPath
{
    TaskList *taskList = [self taskListForSection:indexPath.section];
    
    [taskList removeTaskAtIndex:indexPath.row];
    [taskList addTask:newTask atIndex:indexPath.row];
}

-(void)deleteTaskAtIndexPath:(NSIndexPath *)indexPath
{
    TaskList *taskList = [self taskListForSection:indexPath.section];
    
    [taskList removeTaskAtIndex:indexPath.row];
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

-(nullable TaskList *)taskListForSection:(NSInteger)section
{
    switch (section) {
        case TaskSectionActive:
            return self.checkList.activeTasks;
        case TaskSectionComplete:
            return self.checkList.completeTasks;
        default:
            return nil;
    }
}

@end

NS_ASSUME_NONNULL_END
