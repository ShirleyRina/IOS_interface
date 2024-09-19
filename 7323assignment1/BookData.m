//
//  BookData.m
//  7323assignment1
//
//  Created by shirley on 9/16/24.
//

#import <Foundation/Foundation.h>
@implementation BookData : NSObject 

+ (NSArray *)getBooks {
    // 获取JSON文件的路径
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"books" ofType:@"json"];
    
    // 读取文件数据
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    
    // 解析JSON数据
    NSError *error;
    NSArray *booksArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    if (error) {
        NSLog(@"Error reading JSON file: %@", error.localizedDescription);
        return @[];
    }
    
    return booksArray;
}


@end
