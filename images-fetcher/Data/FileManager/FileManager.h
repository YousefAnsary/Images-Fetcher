//
//  FileManager.h
//  images-fetcher
//
//  Created by Youssef on 08/04/2023.
//

#import <Foundation/Foundation.h>

@interface DataFileManager : NSObject

+ (instancetype)sharedInstance;
- (void)saveData:(NSData *)data withName:(NSString *)name;
- (NSData *)getDataWithName:(NSString *)name;
- (void)removeFileWithName:(NSString *)name;

@end
