//
//  ViewController.m
//  Check
//
//  Created by Oleg Shanyuk on 12/6/15.
//  Copyright © 2015 xaTa. All rights reserved.
//

#import "ChecklistViewController.h"

NS_ASSUME_NONNULL_BEGIN

static NSString* const ItemCell = @"cell";


@implementation ChecklistViewController

+(instancetype)viewController
{
    ChecklistViewController *viewController = [[ChecklistViewController alloc] initWithStyle:UITableViewStylePlain];
    
    [viewController.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ItemCell];
    
    viewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:viewController action:@selector(addTask:)];
    
    viewController.navigationItem.leftBarButtonItem = [viewController editButtonItem];

    viewController.taskController = [CreateTaskController createTaskControllerWithDelegate:viewController];
    
    return viewController;
}

- (void)setDataSource:(ChecklistDataSource *)dataSource
{
    _dataSource = dataSource;
    
    self.tableView.dataSource = dataSource;
    self.tableView.userInteractionEnabled = (self.dataSource != nil);
    
    [self.tableView reloadData];
}

- (void)addTask:(id)sender
{
    [self.taskController createNewTask];
}

#pragma mark - table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSIndexPath *newIndexPath = [self.dataSource indexPathByUpdatingTaskCompletionStatusAtIndexPath:indexPath];

    [tableView moveRowAtIndexPath:indexPath toIndexPath:newIndexPath];

    [tableView reloadRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - create task delegate

- (void)createdNewTask:(id<Task>)task
{
    NSIndexPath *indexPath = [self.dataSource indexPathForNewActiveTask];

    [self.dataSource addTask:task atIndexPath:indexPath];

    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}



@end

NS_ASSUME_NONNULL_END
