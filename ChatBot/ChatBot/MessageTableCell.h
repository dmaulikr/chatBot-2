//
//  MessageTableCell.h
//  ChatBot
//
//  Created by Gopi Krishnan on 20/03/16.
//  Copyright (c) 2016 Gopi Krishnan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageTableCell : UITableViewCell {
    
    UITextView *messageTextView;
    UILabel* statusLabel;
    UIImageView * bubbleView;
    
    BOOL messageType;

}

-(void) setMessageWithType:(BOOL)_messageType withMessage:(NSString *)messageText;

@end
