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

@end
