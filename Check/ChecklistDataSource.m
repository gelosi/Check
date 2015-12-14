//
//  ChecklistDataSource.m
//  Check
//
//  Created by Oleg Shanyuk on 12/6/15.
//  Copyright © 2015 xaTa. All rights reserved.
//

#include "ChecklistDataSource.h"

NS_ASSUME_NONNULL_BEGIN

#define LocalizedString(key)                                                   \
  [[NSBundle mainBundle] localizedStringForKey:(key) value:(key) table:nil]

typedef enum : NSUInteger {
  TaskSectionActive = 0,
  TaskSectionComplete
} TaskSection;

@implementation ChecklistDataSource

- (instancetype)initWithCheckList:(CheckList *)checkList {
  self = [super init];

  if (self) {
    _checkList = checkList;
  }

  return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 2;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
  return [self taskListForSection:section].taskCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
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
    [tableView deleteRowsAtIndexPaths:@[ indexPath ] withRowAnimation:UITableViewRowAnimationAutomatic];
  }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
  id sourceTask = [[self taskListForSection:sourceIndexPath.section] taskAtIndex:sourceIndexPath.row];
  [self deleteTaskAtIndexPath:sourceIndexPath];
  [self addTask:sourceTask atIndexPath:destinationIndexPath];

  if (!tableView.isEditing) {
    [tableView reloadRowsAtIndexPaths:@[ sourceIndexPath, destinationIndexPath ]
                     withRowAnimation:UITableViewRowAnimationAutomatic];
  }
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
  NSString *title;

  if (section == TaskSectionComplete && self.checkList.completeTasks.taskCount > 0) {
    title = LocalizedString(@"complete");
  }
  return title;
}

#pragma mark - Source Methods

-(NSIndexPath *)indexPathForNewActiveTask
{
    return [NSIndexPath indexPathForRow:0 inSection:TaskSectionActive];
}

-(NSIndexPath *)indexPathForNewCompleteTask
{
    return [NSIndexPath indexPathForRow:0 inSection:TaskSectionComplete];
}

-(id<Task>)taskAtIndexPath:(NSIndexPath *)indexPath
{
    TaskList *taskList = [self taskListForSection:indexPath.section];

    return [taskList taskAtIndex:indexPath.row];
}

- (void)addTask:(id<Task>)newTask atIndexPath:(NSIndexPath *)indexPath
{
  TaskList *taskList = [self taskListForSection:indexPath.section];

  [taskList addTask:newTask atIndex:indexPath.row];
}

- (void)deleteTaskAtIndexPath:(NSIndexPath *)indexPath
{
  TaskList *taskList = [self taskListForSection:indexPath.section];

  [taskList removeTaskAtIndex:indexPath.row];
}

- (NSIndexPath *)indexPathByUpdatingTaskCompletionStatusAtIndexPath:(NSIndexPath *)indexPath
{
  id<Task> task = [[self taskListForSection:indexPath.section] taskAtIndex:indexPath.row];

  TaskSection newSection = task.complete ? TaskSectionActive : TaskSectionComplete;

  id<Task> newTask = [task taskByInvertingCompletion];

  NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:0 inSection:newSection];

  [self deleteTaskAtIndexPath:indexPath];
  [self addTask:newTask atIndexPath:newIndexPath];

  return newIndexPath;
}

#pragma mark - helper methods

- (NSString *)cellIdentifierForIndexPath:(NSIndexPath *)indexPath
{
  // we can control which cells we actually want to have for different sections,
  // etc
  return @"cell";
}

- (void)configureCell:(UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath
{
  TaskList *tasks = [self taskListForSection:indexPath.section];

  id<Task> task = [tasks taskAtIndex:indexPath.row];

  cell.textLabel.text = task.title;

  cell.textLabel.textColor = task.complete ? [UIColor grayColor]
                                           : [UIColor darkTextColor];

  cell.accessoryType = task.complete ? UITableViewCellAccessoryCheckmark
                                     : UITableViewCellAccessoryNone;
}

- (nullable TaskList *)taskListForSection:(NSInteger)section {
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
