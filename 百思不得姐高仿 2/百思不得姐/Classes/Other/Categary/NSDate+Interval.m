//
//  NSDate+Interval.m
//  
//
//  Created by Apple on 2016/11/30.
//
//

#import "NSDate+Interval.h"

@implementation NSDate (Interval)

- (BOOL)hw_isThisYear
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yy-MM-dd";
    
    NSString *selfStr = [fmt stringFromDate:self];
    NSString *nowStr = [fmt stringFromDate:[NSDate date]];
    
    NSDate *selfDate = [fmt dateFromString:selfStr];
    NSDate *nowDate  = [fmt dateFromString:nowStr];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSCalendarUnit unit = NSCalendarUnitYear;
    NSDateComponents *cps = [calendar components:unit fromDate:selfDate toDate:nowDate options:0];
    return cps.year == 0;
}
- (BOOL)hw_isToday
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yy-MM-dd";
    
    NSString *selfStr = [fmt stringFromDate:self];
    NSString *nowStr = [fmt stringFromDate:[NSDate date]];
    
    NSDate *selfDate = [fmt dateFromString:selfStr];
    NSDate *nowDate  = [fmt dateFromString:nowStr];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *conponent = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:selfDate toDate:nowDate options:0];
    
    return conponent.year == 0 && conponent.month == 0  && conponent.day == 0;

}
- (BOOL)hw_isYesterday
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yy-MM-dd";
    
    NSString *selfStr = [fmt stringFromDate:self];
    NSString *nowStr = [fmt stringFromDate:[NSDate date]];
    
    NSDate *selfDate = [fmt dateFromString:selfStr];
    NSDate *nowDate  = [fmt dateFromString:nowStr];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *conponent = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:selfDate toDate:nowDate options:0];
    
    return conponent.year == 0 && conponent.month == 0  && conponent.day == 1;
    
}
- (NSDateComponents *)timeInterval{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yy-MM-dd HH:mm:ss";
    
    NSString *selfStr = [fmt stringFromDate:self];
    NSString *nowStr = [fmt stringFromDate:[NSDate date]];
    
    NSDate *selfDate = [fmt dateFromString:selfStr];
    NSDate *nowDate  = [fmt dateFromString:nowStr];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *conponent = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:selfDate toDate:nowDate options:0];
    
    return conponent;
}
@end
