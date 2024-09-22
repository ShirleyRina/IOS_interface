//
//  BookData.m
//  7323assignment1
//
//  Created by shirley on 9/16/24.
//

#import <Foundation/Foundation.h>
@implementation BookData : NSObject 

+ (NSArray *)getBooks {
    // Obtain path for JSON file
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"books" ofType:@"json"];
    
    // Load JSON data
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    
    // Parse JSON data
    NSError *error;
    NSArray *booksArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    if (error) {
        NSLog(@"Error reading JSON file: %@", error.localizedDescription);
        return @[];
    }
    
    return booksArray;
}


@end
