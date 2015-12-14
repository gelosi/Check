//
//  ViewController.h
//  Check
//
//  Created by Oleg Shanyuk on 12/6/15.
//  Copyright © 2015 xaTa. All rights reserved.
//

#import "ChecklistDataSource.h"
#import "CreateTaskController.h"

@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@interface ChecklistViewController : UITableViewController<CreateTaskControllerDelegate>

@property (nonatomic) ChecklistDataSource *dataSource;
@property (nonatomic) CreateTaskController *taskController;

+ (instancetype)viewController;

@end

NS_ASSUME_NONNULL_END

