//
//  WLSTEventCreator.m
//  WatchList
//
//  Created by Dmitry Mazuro on 11/05/2013.
//  Copyright (c) 2013 dmitry.mazuro. All rights reserved.
//

#import "WLSTEventCreator.h"
#import <EventKit/EventKit.h>


@implementation WLSTEventCreator
+ (void)addEventNamed:(NSString *)title description:(NSString *)description date:(NSDate *)date{
    
    EKEventStore *eventStore = [[EKEventStore alloc] initWithAccessToEntityTypes:EKEntityTypeEvent];
    EKEvent *event  = [EKEvent eventWithEventStore:eventStore];
    event.title = title;
    event.notes = description;
    [event setAllDay:YES];
    NSDateComponents *eventDate = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate: date];
    event.startDate = [[NSCalendar currentCalendar] dateFromComponents:eventDate];
    event.endDate   = [[NSDate alloc] initWithTimeInterval:3600*24 sinceDate:event.startDate];
    [event setCalendar:[eventStore defaultCalendarForNewEvents]];
    [eventStore saveEvent:event span:EKSpanThisEvent commit:YES error:nil];
}
@end
