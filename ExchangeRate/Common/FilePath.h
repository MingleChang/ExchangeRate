//
//  FilePath.h
//  ExchangeRate
//
//  Created by 常峻玮 on 15/7/28.
//  Copyright (c) 2015年 MingleChang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FilePath : NSObject
+(NSString *)homePath;
+(NSString *)documentPath;
+(NSString *)libraryPath;
+(NSString *)cachePath;
+(NSString *)tmpPath;
+(NSString *)pathInHomeWithFileName:(NSString *)fileName;
+(NSString *)pathInDocumentWithFileName:(NSString *)fileName;
+(NSString *)pathInLibraryWithFileName:(NSString *)fileName;
+(NSString *)pathInCacheWithFileName:(NSString *)fileName;
+(NSString *)pathInTmpFileName:(NSString *)fileName;
+(NSString *)pathWithDirectoryPath:(NSString *)directoryPath andFileName:(NSString *)fileName;
@end
