//
//  BookData.m
//  7323assignment1
//
//  Created by shirley on 9/16/24.
//

#import <Foundation/Foundation.h>
@implementation BookData : NSObject 

+ (NSArray *)getBooks {
    return @[
        @{@"title": @"The Catcher in the Rye", @"author": @"J.D. Salinger", @"image": @"book1.jpg", @"description": @"A classic novel about teenage rebellion.", @"rating": @"4.5"},
        @{@"title": @"To Kill a Mockingbird", @"author": @"Harper Lee", @"image": @"book2.jpg", @"description": @"A novel about racial injustice.", @"rating": @"5.0"},
        @{@"title": @"YYDS^^^", @"author": @"kunkun", @"image": @"book3.jpg", @"description": @"A classic novel about teenage rebellion.", @"rating": @"3.0"}
    ];
}

@end
