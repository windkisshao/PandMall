//
//  DateUtil.h
//  BeeMusicPlayer
//
//  Created by Sherlock on 2017/3/16.
//  Copyright © 2017年 陈浩. All rights reserved.
//  时间工具类

#import <Foundation/Foundation.h>

#define DATE_TIME_FORMATTER @"yyyy-MM-dd"

#define DETAIL_TIME_FORMATTER @"yyyy-MM-dd HH:mm:ss"

#define SEARCH_DATE_FORMATTER @"yyyy-MM-dd'T'HH:mm:ss'Z'"

#define SEARCH_DATE_THIS_YEAR_FORMATTER @"yyyy-01-01'T'00:00:00'Z'" //2017-01-01T00:00:00Z

#define SEARCH_DATE_THIS_MONTH_FORMATTER @"yyyy-MM-01'T'00:00:00'Z'"

#define GREEN_TIME_FORMATTER @"d MMM yyyy HH:mm:ss"

#define HOUR_FORMATTER  @"HH"

#define USA_DATE_FORMATTER @"MM/dd/yyyy"

@interface DateUtil : NSObject

+(NSString*) getLocalTimestampByMicroSeconds;

+(NSString*) getLocalTimestamp;

+(NSString*)getDateDFromNumber:(NSString*)longTime;

+(NSString *)getLocalDFromNumber;

+(long long)getLongLocalTimestamp;

+(NSString*)parseISO8601Time:(NSString*)duration;

+(CGFloat)parseISO8601TimeToFloatValue:(NSString*)duration;

+(NSString *)getDateDFromMicroNumber:(NSString*)longTime;

+(NSString *)getDateTimeFormatter:(NSString *)longTime;

+(NSString *)getDateTimeFormatterWithDate:(NSDate *)date;

+(long long)getLongTimeFromGreenString:(NSString *)timeStr;

+(long long)getLocalLongTimeFromGreenString:(NSString *)timeStr;

+(NSTimeInterval)getIntervalTimeFromGreenString:(NSString *)timerStr;

+(NSString *)getLocalStringGreenTime:(long long)longTime;

+(NSString *)getNowDateFromatAnDate:(NSString *)longTimeStr;

+(NSString *)getCountDownTimeFormate:(long) time;

+(NSString *)getTodyDateStr;

+(NSDictionary *)getCurrentMonthAndYearDic;

+(NSString *)getWeekdayAndMonthAndYearStr:(BOOL)isToday;

+(NSString *)getTodayDateStrFromMicroTime:(NSString *)longTimeStr;

+(NSString *)getCurrentHourStr;

+(NSString *)getUSADateTimeFormatter:(NSString *)longTime;

@end
