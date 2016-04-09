//
//  Message.h
//  ChatBot
//
//  Created by Gopi Krishnan on 09/04/16.
//  Copyright © 2016 Gopi Krishnan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Message : NSObject 

@property (nonatomic, strong) NSString* messageText;
@property BOOL isBotMessage;


-(id) initWithMessageText:(NSString*)  _text isBotMessge:(BOOL) _isBotMessage;
@end
