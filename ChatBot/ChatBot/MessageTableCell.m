//
//  MessageTableCell.m
//  ChatBot
//
//  Created by Gopi Krishnan on 20/03/16.
//  Copyright (c) 2016 Gopi Krishnan. All rights reserved.
//

#import "MessageTableCell.h"

@implementation MessageTableCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self initateSetup];
    }
    return self;
}


-(void)initateSetup
{
    self.backgroundColor    = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    bubbleView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, self.frame.size.width - 10, self.frame.size.height - 10)];
    bubbleView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.contentView addSubview:bubbleView];
    
    messageTextView = [[UITextView alloc] initWithFrame:CGRectMake(15, 7, bubbleView.frame.size.width - 30, bubbleView.frame.size.height - 35)];
    messageTextView.font  =   [UIFont systemFontOfSize:15];
    messageTextView.textColor  =   [UIColor blackColor];
    messageTextView.backgroundColor = [UIColor clearColor];
    messageTextView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    [bubbleView addSubview:messageTextView];
    
    statusLabel = [[UILabel alloc] init];
    statusLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    statusLabel.hidden = YES;
    [self.contentView addSubview:statusLabel];
    
}


-(void) setMessageWithType:(int)messageType
{
    
    messageTextView.text = @"This  is a test message";
    
    
    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:messageTextView.text attributes:@{ NSFontAttributeName:messageTextView.font}];
    CGSize  stringSize   =   [attributedText boundingRectWithSize:CGSizeMake( self.frame.size.width  -40,  self.frame.size.height - 45)
                                                          options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                                          context:nil].size;
    CGSize textSize     =   CGSizeMake(ceilf(stringSize.width), ceilf(stringSize.height));
    
    CGFloat messageWidth = (textSize.width > self.frame.size.width - 80) ? (self.frame.size.width - 10) : textSize.width + 10;
    
    
        if (messageType==0) // input msg
        {
            bubbleView.image = [[UIImage imageNamed:@"ServerMessage"]
                                stretchableImageWithLeftCapWidth:21 topCapHeight:14];
            messageTextView.textAlignment  = NSTextAlignmentRight;
            bubbleView.frame = CGRectMake(5, 5, messageWidth, self.frame.size.height - 10);
    
    
        }else
        {
            bubbleView.image = [[UIImage imageNamed:@"ClientMessage"]
                        stretchableImageWithLeftCapWidth:21 topCapHeight:14];
            messageTextView.textAlignment  = NSTextAlignmentLeft;
            bubbleView.frame = CGRectMake(self.frame.size.width  - messageWidth - 5, 5, messageWidth, self.frame.size.height - 10);
    
    
     }
    
    
}

@end
