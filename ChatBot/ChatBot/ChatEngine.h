//
//  ChatEngine.h
//  ChatBot
//
//  Created by Gopi Krishnan on 20/03/16.
//  Copyright (c) 2016 Gopi Krishnan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ChatEngine;
@interface ChatEngine : NSObject

+ (ChatEngine *)sharedEngine;

-(void)sendMessageWithCompletion:(void (^)(NSError *))block forMessage:(NSString *)chatMessage;


@end
