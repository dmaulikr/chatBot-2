//
//  ChatEngine.m
//  ChatBot
//
//  Created by Gopi Krishnan on 20/03/16.
//  Copyright (c) 2016 Gopi Krishnan. All rights reserved.
//

#import "ChatEngine.h"
#import "AFNetworking.h"


@implementation ChatEngine

+ (ChatEngine *)sharedEngine {
    
    static ChatEngine *chatEngine = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        chatEngine                    = [[ChatEngine alloc] init];
    });
    
    return chatEngine;
}

-(void)sendMessageWithCompletion:(void (^)(NSError *))block forMessage:(NSString *)chatMessage {
    
    NSString* serverURL = [NSString stringWithFormat:@"http://www.personalityforge.com/api/chat/?apiKey=6nt5d1nJHkqbkphe&message=%@&chatBotID=63906&externalID=Gopi",chatMessage];
    
    NSMutableURLRequest* chatRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:serverURL]];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:chatRequest];
    
    [operation  setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"Chat message sent. Response receivved is: %@", operation.responseString);
    }
                                      failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                          NSLog(@"error: %@",  operation.responseString);
                                          block(error);
                                      }
     
     ];
    
    [operation start];

    
}

@end
