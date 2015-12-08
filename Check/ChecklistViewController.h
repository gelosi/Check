//
//  ViewController.h
//  Check
//
//  Created by Oleg Shanyuk on 12/6/15.
//  Copyright © 2015 xaTa. All rights reserved.
//

#import "ChecklistDataSource.h"

@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@interface ChecklistViewController : UITableViewController

@property (nonatomic) ChecklistDataSource *dataSource;

+ (instancetype)viewController;

@end

NS_ASSUME_NONNULL_END

