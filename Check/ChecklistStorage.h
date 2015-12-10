//
//  ChecklistStorage.h
//  Check
//
//  Created by Oleg Shanyuk on 12/7/15.
//  Copyright © 2015 xaTa. All rights reserved.
//

#import "CheckList.h"

typedef void(^ChecklistStorageCompletion)(CheckList *checklist, BOOL result);

@protocol ChecklistStorage <NSObject>

- (void)storeChecklist:(CheckList *)checkList comletion:(ChecklistStorageCompletion)completion;
- (void)loadCheckList:(NSString *)name comletion:(ChecklistStorageCompletion)completion;

@end


@interface ChecklistAsyncFileStorage : NSObject<ChecklistStorage>

+(instancetype) storage;

@end
