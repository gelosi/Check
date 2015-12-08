//
//  ChecklistStorage.m
//  Check
//
//  Created by Oleg Shanyuk on 12/7/15.
//  Copyright © 2015 xaTa. All rights reserved.
//

#import "ChecklistStorage.h"


@implementation ChecklistFileStorage

+ (instancetype)storage
{
    return [ChecklistFileStorage new];
}

- (NSString *)pathForFile:(NSString *)file
{
    NSArray*  paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:file];
    
    return filePath;
}


-(void)loadCheckList:(NSString *)name comletion:(ChecklistStorageCompletion)completion
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString *fileName = [self pathForFile:name];
        
        CheckList* checkList = [NSKeyedUnarchiver unarchiveObjectWithFile:fileName];
        
        BOOL success = checkList != nil;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(checkList, success);
        });
    });
}

- (void)storeChecklist:(CheckList *)checkList comletion:(ChecklistStorageCompletion)completion
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString *fileName = [self pathForFile:checkList.title];
        
        BOOL success = [NSKeyedArchiver archiveRootObject:checkList toFile:fileName];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(checkList, success);
        });
    });
}

@end
