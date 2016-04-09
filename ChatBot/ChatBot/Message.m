//
//  Message.m
//  ChatBot
//
//  Created by Gopi Krishnan on 09/04/16.
//  Copyright © 2016 Gopi Krishnan. All rights reserved.
//

#import "Message.h"

@implementation Message
@synthesize messageText,isBotMessage;

-(id) initWithMessageText:(NSString*)  _text isBotMessge:(BOOL) _isBotMessage
{
    self = [super init];
    
    if (self) {
        self.messageText    = _text;
        self.isBotMessage   = _isBotMessage;
    }
    
    return self;
}
@end
