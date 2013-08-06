//
//  ZMessage.m
//  Zulip
//
//  Created by Leonardo Franchi on 8/2/13.
//
//

#import "ZMessage.h"
#import "ZSubscription.h"
#import "ZUser.h"


@implementation ZMessage

@dynamic avatar_url;
@dynamic content;
@dynamic messageID;
@dynamic stream_recipient;
@dynamic subject;
@dynamic timestamp;
@dynamic type;
@dynamic flagData;
@dynamic pm_recipients;
@dynamic sender;
@dynamic subscription;

// MANUALLY ADDED BELOW THIS LINE
@synthesize linkedRawMessage;

- (NSArray *)messageFlags
{
    if (!self.flagData) {
        return @[];
    }
    
    return [NSKeyedUnarchiver unarchiveObjectWithData:self.flagData];
}

- (void)setMessageFlags:(NSArray *)flags
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:flags];
    self.flagData = data;
}

- (void)addMessageFlag:(NSString *)flag
{
    NSMutableArray *new_flags = [NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:self.flagData]];
    [new_flags addObject:flag];

    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:new_flags];

    self.flagData = data;
}

- (void)removeMessageFlag:(NSString *)flag
{
    NSMutableArray *new_flags = [NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:self.flagData]];
    [new_flags removeObject:flag];

    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:new_flags];

    self.flagData = data;
}

@end
