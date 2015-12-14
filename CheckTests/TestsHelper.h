//
//  TestsHelper.h
//  Check
//
//  Created by Oleg Shanyuk on 14/12/15.
//  Copyright © 2015 xaTa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CheckList.h"


@interface TestsHelper : NSObject

+ (NSArray *)threeTasksArray:(BOOL)complete;
+ (TaskList *)taskListWithThreeCompleteTasks;
+ (TaskList *)taskListWithThreeIncompleteTasks;

@end
