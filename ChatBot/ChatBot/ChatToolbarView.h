//
//  ChatToolbarView.h
//  ChatBot
//
//  Created by Gopi Krishnan on 20/03/16.
//  Copyright (c) 2016 Gopi Krishnan. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol ChatToolbarDelegate <NSObject>
@optional
- (void) toolBarViewBeginEditing;
- (void) toolBarViewEndEditing;

@required

- (void) sendButtonPressedInChatToolbarWithText:(NSString*)inputText;

@end

@interface ChatToolbarView : UIView<UITextViewDelegate>
{
    CGRect keyboardRect;
}
@property (assign) id <ChatToolbarDelegate> delegate;

@property (strong, nonatomic) UIButton* sendButton;
@property (strong, nonatomic) UIButton* attachButton;
@property (strong, nonatomic) UITextView* textView;
@property (strong, nonatomic) UILabel* lblPlaceholder;
@property (strong, nonatomic) UIView* inputBackgroundView;

- (void) fitText;

- (void) setText:(NSString*)text;
- (void) resetToolbar;
@end
