//
//  ChecklistDataSource.h
//  Check
//
//  Created by Oleg Shanyuk on 12/6/15.
//  Copyright © 2015 xaTa. All rights reserved.
//

@import UIKit;

#import "CheckList.h"


@interface ChecklistDataSource : NSObject<UITableViewDataSource>

@property (nonatomic, readonly) CheckList *checkList;

-(instancetype)initWithCheckList:(CheckList *)checkList;

-(NSIndexPath *)indexPathForNewActiveTask;
-(NSIndexPath *)indexPathForNewCompleteTask;

-(id<Task>)taskAtIndexPath:(NSIndexPath *)indexPath;

-(void)addTask:(id<Task>)newTask atIndexPath:(NSIndexPath *)indexPath;
-(void)deleteTaskAtIndexPath:(NSIndexPath *)indexPath;
-(NSIndexPath *)indexPathByUpdatingTaskCompletionStatusAtIndexPath:(NSIndexPath *)indexPath;

@end
