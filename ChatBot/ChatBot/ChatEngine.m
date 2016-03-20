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

-(void)sendMessageWithCompletion:(void (^)(NSString *,NSError *))block forMessage:(NSString *)chatMessage {
    
    NSString* serverURL = [NSString stringWithFormat:@"http://test2.docsapp.in/ios_chatbot_api/chatbot.php?apiKey=6nt5d1nJHkqbkphe&message=%@&chatBotID=63906&externalID=Gopi",chatMessage];
    

    NSString *escapedPath = [serverURL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSLog(@"escapedPath: %@", escapedPath);
    
    NSMutableURLRequest* chatRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:escapedPath]];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:chatRequest];
    
    [operation  setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
    
//        NSString * test = @"[{\"success\":1},{\"message\":\"Hi\"}]";
        
        NSLog(@"%@",operation.responseString);
        
        NSString *botResponse = [[operation.responseString componentsSeparatedByString:@"\""] objectAtIndex:5];
        block(botResponse,nil);
    }
                                      failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                          NSLog(@"error: %@, %@",  operation.responseString, error.description);
                                          block(nil,error);
                                      }
     
     ];
    
    [operation start];

    
}

@end
