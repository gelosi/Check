//
//  AppDelegate.m
//  Check
//
//  Created by Oleg Shanyuk on 12/6/15.
//  Copyright © 2015 xaTa. All rights reserved.
//

#import "AppDelegate.h"
#import "ChecklistViewController.h"
#import "ChecklistStorage.h"

static NSString * const ChecklistName = @"Cheklist";

@interface AppDelegate ()
@property (nonatomic) ChecklistViewController *viewController;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.viewController = [ChecklistViewController viewController];
    
    self.viewController.dataSource = [self emptyChecklistDataSource];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:self.viewController];
    
    self.window = [[UIWindow alloc] init];
    
    [self.window setRootViewController:navigationController];
    
    [self.window makeKeyAndVisible];
    
    [self loadChecklistAsync];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    [[ChecklistAsyncFileStorage storage] storeChecklist:self.viewController.dataSource.checkList comletion:^(CheckList *checklist, BOOL result) {
        NSLog(@"App Data %@", result ? @"Successfully Stored" : @"Failed To Store");
    }];
}

- (void)loadChecklistAsync
{
    [[ChecklistAsyncFileStorage storage] loadCheckList:ChecklistName comletion:^(CheckList *checklist, BOOL result) {
        if (!result) {
            NSLog(@"%s: Loading Checklist failed",__PRETTY_FUNCTION__);
            return;
        }
        
        self.viewController.dataSource = [[ChecklistDataSource alloc] initWithCheckList:checklist];
    }];
}

- (ChecklistDataSource *) emptyChecklistDataSource
{
    CheckList *checklist = [[CheckList alloc] initWithTitle:ChecklistName
                                                activeTasks:[[TaskList alloc] initWithTasks:@[]]
                                              completeTasks:[[TaskList alloc] initWithTasks:@[]]];
    
    return [[ChecklistDataSource alloc] initWithCheckList:checklist];
}


@end
