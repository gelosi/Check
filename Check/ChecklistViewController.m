//
//  ViewController.m
//  Check
//
//  Created by Oleg Shanyuk on 12/6/15.
//  Copyright © 2015 xaTa. All rights reserved.
//

#import "ChecklistViewController.h"
#import "ItemPresenter.h"

NS_ASSUME_NONNULL_BEGIN

static NSString* const ItemCell = @"cell";


@implementation ChecklistViewController

+(instancetype)viewController
{
    ChecklistViewController *viewController = [[ChecklistViewController alloc] initWithStyle:UITableViewStylePlain];
    
    [viewController.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ItemCell];
    
    viewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:viewController action:@selector(addTask:)];
    
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
    TaskItem *Task = [[TaskItem alloc] initWithTitle:@"Item" complete:NO];
    
    [self.dataSource.checkList.activeTasks addTask:Task];
    
    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForItem:0 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
}

@end

NS_ASSUME_NONNULL_END
