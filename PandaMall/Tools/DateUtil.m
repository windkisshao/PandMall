//
//  DateUtil.m
//  BeeMusicPlayer
//
//  Created by Sherlock on 2017/3/16.
//  Copyright © 2017年 陈浩. All rights reserved.
//

#import "DateUtil.h"

@implementation DateUtil

+(NSString *)getLocalTimestampByMicroSeconds {
    long long timestamp = [[NSDate date] timeIntervalSince1970] * 1000 * 1000;
    return [NSString stringWithFormat:@"%@", @(timestamp)];
}

+(NSString*) getLocalTimestamp
{
    long long timestamp = [[NSDate date] timeIntervalSince1970] * 1000;
    return [NSString stringWithFormat:@"%@", @(timestamp)];
}

+(long long)getLongLocalTimestamp {
    
    return [[NSDate date] timeIntervalSince1970] * 1000;
}

+(NSString *)getDateDFromMicroNumber:(NSString*)longTime {
    NSTimeInterval timestamp = [longTime doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp/1000/1000];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:DETAIL_TIME_FORMATTER];//设置格式化样式
    NSString *formatDate = [formatter stringFromDate:date];
    return formatDate;
}

+(NSString*)getDateDFromNumber:(NSString*)longTime
{
    NSTimeInterval timestamp = [longTime doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp/1000];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:DETAIL_TIME_FORMATTER];//设置格式化样式
    NSString *formatDate = [formatter stringFromDate:date];
    return formatDate;
}

+(NSString *)getDateTimeFormatter:(NSString *)longTime {
    NSTimeInterval timestamp = [longTime doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp/1000];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:DATE_TIME_FORMATTER];//设置格式化样式
    NSString *formatDate = [formatter stringFromDate:date];
    return formatDate;
}

+(NSString *)getDateTimeFormatterWithDate:(NSDate *)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:DATE_TIME_FORMATTER];//设置格式化样式
    NSString *formatDate = [formatter stringFromDate:date];
    return formatDate;
}

+(NSString *)getUSADateTimeFormatter:(NSString *)longTime {
    NSTimeInterval timestamp = [longTime doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp/1000];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:USA_DATE_FORMATTER];//设置格式化样式
    NSString *formatDate = [formatter stringFromDate:date];
    return formatDate;
}

+(long long)getLongTimeFromGreenString:(NSString *)timeStr {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:GREEN_TIME_FORMATTER];
    NSLocale *locale = [[NSLocale alloc]
                        initWithLocaleIdentifier:@"us"];
    [formatter setLocale:locale];
    
    NSDate *date = [formatter dateFromString:timeStr];
    
    return [date timeIntervalSince1970] * 1000;
}

+(long long)getLocalLongTimeFromGreenString:(NSString *)timeStr {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:GREEN_TIME_FORMATTER];
    NSLocale *locale = [[NSLocale alloc]
                        initWithLocaleIdentifier:@"us"];
    [formatter setLocale:locale];
    
    NSInteger gapTime = [NSTimeZone localTimeZone].secondsFromGMT;  //本地时区和标准时区的差值
    
    NSDate *date = [formatter dateFromString:timeStr];
    
    return ([date timeIntervalSince1970] + gapTime) * 1000;
}


+(NSTimeInterval)getIntervalTimeFromGreenString:(NSString *)timerStr {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:GREEN_TIME_FORMATTER];
    NSLocale *locale = [[NSLocale alloc]
                        initWithLocaleIdentifier:@"us"];
    [formatter setLocale:locale];
    
    NSDate *date = [formatter dateFromString:timerStr];
    
    return [date timeIntervalSince1970];
}


+(NSString *)getLocalStringGreenTime:(long long)longTime {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:longTime/1000];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:GREEN_TIME_FORMATTER];
    NSLocale *locale = [[NSLocale alloc]
                        initWithLocaleIdentifier:@"us"];
    [formatter setLocale:locale];
    
    NSString *str = [formatter stringFromDate:date];
    return str;
}

+(NSString *)getLocalDFromNumber {
    return [self getDateDFromNumber:[self getLocalTimestamp]];
}

+ (NSString*)parseISO8601Time:(NSString*)duration
{
    NSInteger hours = 0;
    NSInteger minutes = 0;
    NSInteger seconds = 0;
    
    duration = [duration substringFromIndex:[duration rangeOfString:@"T"].location];
    
    while ([duration length] > 1) { //only one letter remains after parsing
        duration = [duration substringFromIndex:1];
        
        NSScanner *scanner = [[NSScanner alloc] initWithString:duration];
        
        NSString *durationPart = [[NSString alloc] init];
        [scanner scanCharactersFromSet:[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] intoString:&durationPart];
        
        NSRange rangeOfDurationPart = [duration rangeOfString:durationPart];
        
        duration = [duration substringFromIndex:rangeOfDurationPart.location + rangeOfDurationPart.length];
        
        if ([[duration substringToIndex:1] isEqualToString:@"H"]) {
            hours = [durationPart intValue];
        }
        if ([[duration substringToIndex:1] isEqualToString:@"M"]) {
            minutes = [durationPart intValue];
        }
        if ([[duration substringToIndex:1] isEqualToString:@"S"]) {
            seconds = [durationPart intValue];
        }
    }
    
    if (hours > 0) {
        return [NSString stringWithFormat:@"%02ld:%02ld:%02ld", (long)hours, (long)minutes, (long)seconds];
        
    } else {
        return [NSString stringWithFormat:@"%02ld:%02ld", (long)minutes, (long)seconds];
        
    }
    
}

+(CGFloat)parseISO8601TimeToFloatValue:(NSString *)duration {
    NSInteger hours = 0;
    NSInteger minutes = 0;
    NSInteger seconds = 0;
    
    duration = [duration substringFromIndex:[duration rangeOfString:@"T"].location];
    
    while ([duration length] > 1) { //only one letter remains after parsing
        duration = [duration substringFromIndex:1];
        
        NSScanner *scanner = [[NSScanner alloc] initWithString:duration];
        
        NSString *durationPart = [[NSString alloc] init];
        [scanner scanCharactersFromSet:[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] intoString:&durationPart];
        
        NSRange rangeOfDurationPart = [duration rangeOfString:durationPart];
        
        duration = [duration substringFromIndex:rangeOfDurationPart.location + rangeOfDurationPart.length];
        
        if ([[duration substringToIndex:1] isEqualToString:@"H"]) {
            hours = [durationPart intValue];
        }
        if ([[duration substringToIndex:1] isEqualToString:@"M"]) {
            minutes = [durationPart intValue];
        }
        if ([[duration substringToIndex:1] isEqualToString:@"S"]) {
            seconds = [durationPart intValue];
        }
    }
    
    return hours * 3600 + minutes * 60 + seconds;
}


+(NSString *)getNowDateFromatAnDate:(NSString *)longTimeStr {
    long long timeStamp = [DateUtil getLocalLongTimeFromGreenString:longTimeStr];
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeStamp/1000];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:GREEN_TIME_FORMATTER];
    
    NSLocale *locale = [[NSLocale alloc]
                        initWithLocaleIdentifier:@"us"];
    [formatter setLocale:locale];
    
    NSString *str = [formatter stringFromDate:date];
    
    return str;
}

+(NSString *)getCountDownTimeFormate:(long) time {
    long hours = time / 3600;
    long mins = (time - hours * 3600) / 60;
    long secs = time - hours * 3600 - mins * 60;
    
    if (hours > 0) {
        return [NSString stringWithFormat:@"%02ld:%02ld:%02ld", (long)hours, (long)mins, (long)secs];
        
    } else {
        return [NSString stringWithFormat:@"00:%02ld:%02ld", (long)mins, (long)secs];
        
    }
    
}

+(NSDictionary *)getCurrentMonthAndYearDic {
    NSDate *date = [NSDate date];//这个是NSDate类型的日期，所要获取的年月日都放在这里；
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSCalendarUnitYear|NSCalendarUnitMonth|
    NSCalendarUnitDay;//这句是说你要获取日期的元素有哪些。获取年就要写NSYearCalendarUnit，获取小时就要写NSHourCalendarUnit，中间用|隔开；
    
    NSDateComponents *d = [cal components:unitFlags fromDate:date];//把要从date中获取的unitFlags标示的日期元素存放在NSDateComponents类型的d里面；
    //然后就可以从d中获取具体的年月日了；
    NSInteger year = [d year];
    NSInteger month = [d month];
    
    NSArray *arr = @[@"January",@"February",@"March",@"April",@"May",@"June",@"July",@"August",@"September",@"October",@"November",@"December"];
    
    NSString *monthStr = [arr objectAtIndex:month - 1];
    NSString *yearStr = [NSString stringWithFormat:@"%@",@(year)];

    return @{@"year":yearStr,@"month":monthStr};

}

+(NSString *)getWeekdayAndMonthAndYearStr:(BOOL)isToday {
    NSString *str = nil;    
    NSDate *nowDate = nil;
    if (isToday) {
        nowDate = [NSDate date];
        
    } else {
        nowDate = [NSDate jk_dateTomorrow];
    }
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comp = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday  fromDate:nowDate];
    // 获取今天是周几
    NSInteger weekDay = [comp weekday];
    // 获取今天是几号
    NSInteger day = [comp day];
    //月份
    NSInteger month = [comp month];
    // 获取年
    NSInteger year = [comp year];
    
    NSArray *weekArray = @[@"Sunday",@"Monday",@"Tuesday",@"Wednesday",@"Thursday",@"Friday",@"Saturday"];
    NSArray *arr = @[@"Jan",@"Feb",@"Mar",@"Apr",@"May",@"Jun",@"Jul",@"Aug",@"Sept",@"Oct",@"Nov",@"Dec"];
    
    NSString *weekStr = weekArray[weekDay - 1];
    NSString *monhtStr = arr[month - 1];
    
    str = [NSString stringWithFormat:@"%@  /  %@ %@  /  %@",weekStr,monhtStr,@(day),@(year)];
    
    return str;
}

+(NSString *)getTodyDateStr {
    return [self getDateTimeFormatter:[self getLocalTimestamp]];
}

+(NSString *)getTodayDateStrFromMicroTime:(NSString *)longTimeStr {
    NSTimeInterval timestamp = [longTimeStr doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp/1000/1000];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:DATE_TIME_FORMATTER];//设置格式化样式
    NSString *formatDate = [formatter stringFromDate:date];
    return formatDate;
}

+(NSString *)getCurrentHourStr {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[[NSDate date] timeIntervalSince1970]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:HOUR_FORMATTER];//设置格式化样式
    NSString *formatDate = [formatter stringFromDate:date];
    return formatDate;
}

@end
