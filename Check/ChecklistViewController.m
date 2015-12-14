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
    
    viewController.navigationItem.leftBarButtonItem = [viewController editButtonItem];
    
    return viewController;
}

- (void)setDataSource:(ChecklistDataSource *)dataSource
{
    _dataSource = dataSource;
    
    self.tableView.dataSource = dataSource;
    self.tableView.userInteractionEnabled = (self.dataSource != nil);
    
    [self.tableView reloadData];
}

#pragma mark - control table view

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSIndexPath *newIndexPath = [self.dataSource indexPathByUpdatingTaskCompletionStatusAtIndexPath:indexPath];

    [tableView moveRowAtIndexPath:indexPath toIndexPath:newIndexPath];

    [tableView reloadRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}


- (void)addTask:(id)sender
{
    TaskItem *Task = [[TaskItem alloc] initWithTitle:[self randomItemTitle] complete:NO];
    
    NSIndexPath *indexPath = [self.dataSource indexPathForNewActiveTask];
    
    [self.dataSource addTask:Task atIndexPath:indexPath];
    
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

-(NSString *)randomItemTitle
{
    NSArray *itemPart = @[@"Item", @"Task", @"Point", @"Punkt", @"Reminder", @"Pink", @"Check"];
    NSArray *explainPart = @[@"One", @"Two", @"Call Someone", @"Floyd", @"Break", @"Off", @"On", @"Pizza"];
    
    NSUInteger indexPart =  arc4random_uniform((u_int32_t)itemPart.count);
    NSUInteger indexExplain =  arc4random_uniform((u_int32_t)explainPart.count);
    
    return [@[itemPart[indexPart],explainPart[indexExplain]] componentsJoinedByString:@" "];
}

@end

NS_ASSUME_NONNULL_END
