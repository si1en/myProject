//
//  NSDate+Interval.h
//  
//
//  Created by Apple on 2016/11/30.
//
//

#import <Foundation/Foundation.h>

@interface NSDate (Interval)

- (BOOL)hw_isThisYear;
- (BOOL)hw_isToday;
- (BOOL)hw_isYesterday;

- (NSDateComponents *)timeInterval;
@end
