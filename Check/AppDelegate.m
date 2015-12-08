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

@interface AppDelegate ()
@property (nonatomic) ChecklistViewController *viewController;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.viewController = [ChecklistViewController viewController];
    
    self.viewController.dataSource = [[ChecklistDataSource alloc] initWithCheckList:[[CheckList alloc] initWithTitle:@"Checklist" activeTasks:[[TaskList alloc] initWithTasks:@[]] completeTasks:[[TaskList alloc] initWithTasks:@[]]] ];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:self.viewController];
    
    self.window = [[UIWindow alloc] init];
    
    [self.window setRootViewController:navigationController];
    
    [self.window makeKeyAndVisible];
    
    [self loadChecklistAsync];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    [[ChecklistFileStorage storage] storeChecklist:self.viewController.dataSource.checkList comletion:^(CheckList *checklist, BOOL result) {
        NSLog(@"App Data %@", result ? @"Successfully Stored" : @"Failed To Store");
    }];
}

- (void)loadChecklistAsync
{
    [[ChecklistFileStorage storage] loadCheckList:@"Checklist" comletion:^(CheckList *checklist, BOOL result) {
        if (!result) {
            NSLog(@"%s: Loading Checklist failed",__PRETTY_FUNCTION__);
            return;
        }
        
        self.viewController.dataSource = [[ChecklistDataSource alloc] initWithCheckList:checklist];
    }];
}


@end
