//
//  CheckList.h
//  Check
//
//  Created by Oleg Shanyuk on 12/6/15.
//  Copyright © 2015 xaTa. All rights reserved.
//

#import "TaskList.h"

@interface CheckList : NSObject<NSCoding>

@property (nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) TaskList *activeTasks;
@property (nonatomic, readonly) TaskList *completeTasks;

-(instancetype)initWithTitle:(NSString *)title activeTasks:(TaskList *)active completeTasks:(TaskList *)complete;

@end
