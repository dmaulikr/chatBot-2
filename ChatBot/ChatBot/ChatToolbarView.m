//
//  ChatToolbarView.m
//  ChatBot
//
//  Created by Gopi Krishnan on 20/03/16.
//  Copyright (c) 2016 Gopi Krishnan. All rights reserved.
//

#import "ChatToolbarView.h"

@implementation ChatToolbarView

- (id) initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self)
    {
        [self composeView];
    }
    return self;
}

- (void) composeView {
    
    CGSize size = self.frame.size;
    
    // Input
    _inputBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    _inputBackgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _inputBackgroundView.contentMode = UIViewContentModeScaleToFill;
    _inputBackgroundView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_inputBackgroundView];
    
    // Text field
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 5, self.frame.size.width -  80, 34)];
    _textView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _textView.backgroundColor = [UIColor clearColor];
    //_textView.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:.3];
    _textView.delegate = self;
    _textView.layer.cornerRadius = 3;
    _textView.showsVerticalScrollIndicator = NO;
    _textView.showsHorizontalScrollIndicator = NO;
    _textView.font = [UIFont systemFontOfSize:15.0f];
    [self addSubview:_textView];
    
    
    _lblPlaceholder = [[UILabel alloc] initWithFrame:CGRectMake(18.0f, 6, 220, 27)];
    _lblPlaceholder.font = [UIFont systemFontOfSize:15.0f];
    _lblPlaceholder.text = @"Type a message";
    _lblPlaceholder.textColor = [UIColor darkGrayColor];
    _lblPlaceholder.backgroundColor = [UIColor clearColor];
    [self addSubview:_lblPlaceholder];
    
    // Send button
    _sendButton = [UIButton buttonWithType:UIButtonTypeCustom] ;
    _sendButton.frame = CGRectMake(self.frame.size.width - 70,self.frame.size.height - 40, 70, 34);
    _sendButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin;
    _sendButton.titleLabel.font = [UIFont systemFontOfSize:14];
    _sendButton.titleLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
    [_sendButton setTitle:@"Send" forState:UIControlStateNormal];
    [_sendButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    [_sendButton setTitleColor:[UIColor colorWithRed:0.08 green:0.54 blue:1 alpha:1] forState:UIControlStateNormal];
    [_sendButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateDisabled];
    [_sendButton addTarget:self action:@selector(sendButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    _sendButton.enabled	=	NO;
    
    [self addSubview:_sendButton];
    
    [self sendSubviewToBack:_inputBackgroundView];
    
    // This could be in an init method.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardSizeCahnged:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    
}

- (void)keyboardSizeCahnged:(NSNotification*)notification
{
    
    keyboardRect = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    keyboardRect = [self.superview convertRect:keyboardRect fromView:nil]; //this is it!
    
    [UIView animateWithDuration:0
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         CGRect r = self.frame;
                         r.origin.y = keyboardRect.origin.y - 44;
                         [self setFrame:r];
                     } completion:nil];
}


- (void) adjustTextInputHeightForText:(NSString*)text{
    
    int h1 = [_textView.text sizeWithAttributes:@{ NSFontAttributeName:[UIFont systemFontOfSize:15]}].height;
    
    h1 = (h1 > 150) ? 150 : h1;
    
    [UIView animateWithDuration:0 animations:^
     {
         CGRect r = self.frame;
         r.size.height = h1 + 26;
         r.origin.y = keyboardRect.origin.y - r.size.height;
         self.frame  = r;
         
         _textView.frame = CGRectMake(10, 5, self.frame.size.width -  80, h1 + 14);
         
         
         
     } completion:^(BOOL finished)
     {
     }];
}



- (void) fitText {
    
    [self adjustTextInputHeightForText:_textView.text];
}

- (void) setText:(NSString*)text {
    
    _textView.text = text;
    _lblPlaceholder.hidden = text.length > 0;
    [self fitText];
}

-(void) resetToolbar
{
    [self setText:@""];
    _sendButton.enabled	= NO;
    [_textView resignFirstResponder];
}

-(void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}
#pragma mark UITextFieldDelegate Delegate

- (void) textViewDidBeginEditing:(UITextView*)textView {
    
    
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         CGRect r = self.frame;
                         r.origin.y -= 236;
                         [self setFrame:r];
                     } completion:nil];
    
    if ([_delegate respondsToSelector:@selector(toolBarViewBeginEditing)])
        [_delegate performSelector:@selector(toolBarViewBeginEditing) withObject:textView];
}

- (void) textViewDidEndEditing:(UITextView*)textView {
    
    [self fitText];
    
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         CGRect r = self.frame;
                         r.origin.y = self.superview.frame.size.height - 44;
                         r.size.height = 44;
                         [self setFrame:r];
                     } completion:nil];
    
    _lblPlaceholder.hidden = _textView.text.length > 0;
    
    _textView.frame = CGRectMake(10, 5, self.frame.size.width -  80, 34);
    if ([_delegate respondsToSelector:@selector(toolBarViewEndEditing)])
        [_delegate performSelector:@selector(toolBarViewEndEditing) withObject:textView];
}

- (void) textViewDidChange:(UITextView*)textView {
    
    _lblPlaceholder.hidden = textView.text.length > 0;
    _sendButton.enabled	=	(textView.text.length > 0);
    //
    [self fitText];
    
    if ([_delegate respondsToSelector:@selector(textViewDidChange:)])
        [_delegate performSelector:@selector(textViewDidChange:) withObject:textView];
}


#pragma mark ChatToolbar Delegate

- (void) sendButtonPressed:(id)sender {
    
    if ([_delegate respondsToSelector:@selector(sendButtonPressedInChatToolbarWithText:)])
        [_delegate sendButtonPressedInChatToolbarWithText:_textView.text];
}

@end