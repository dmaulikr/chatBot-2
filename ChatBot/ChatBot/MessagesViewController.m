//
//  MessagesViewController.m
//  ChatBot
//
//  Created by Gopi Krishnan on 20/03/16.
//  Copyright (c) 2016 Gopi Krishnan. All rights reserved.
//

#import "MessagesViewController.h"
#import "MessageTableCell.h"

@interface MessagesViewController ()

@end

@implementation MessagesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationItem.title = @"ChatBot";
    
    messagesArray  = [NSMutableArray new];
    [messagesArray addObject:@"Test Message"];
    [messagesArray addObject:@"Test Message"];
    [messagesArray addObject:@"Test Message"];
    [messagesArray addObject:@"Test Message"];
    
    messageTableView					=	[[UITableView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height - 44) style:UITableViewStylePlain];
    messageTableView.autoresizingMask	=	UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    messageTableView.backgroundColor	=	[UIColor clearColor];
    messageTableView.dataSource			=	self;
    messageTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    messageTableView.delegate			=	self;
    [self.view addSubview:messageTableView];
    
    messageTableView.rowHeight  = 90;
    
    toolBarView								= [[ChatToolbarView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 44, self.view.frame.size.width, 44)];
    toolBarView.backgroundColor				=	[UIColor whiteColor];
    toolBarView.delegate					=	self;
    toolBarView.autoresizingMask			=	UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:toolBarView];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardSizeCahnged:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];


    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return messagesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *CellIdentifier = @"Cell";
    
    MessageTableCell *cell = (MessageTableCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[MessageTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    [cell setMessageWithType:1 withMessage:[messagesArray objectAtIndex:messagesArray.count-1]];
    return cell;
}



-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:messagesArray[indexPath.row] attributes:@{ NSFontAttributeName:[UIFont systemFontOfSize:15]}];
    CGSize  stringSize   =   [attributedText boundingRectWithSize:CGSizeMake( self.view.frame.size.width  - 40,  CGFLOAT_MAX)
                                                          options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                                          context:nil].size;
    CGSize textSize     =   CGSizeMake(ceilf(stringSize.width), ceilf(stringSize.height));
    
    return  textSize.height + 50;

}

- (void) sendButtonPressedInChatToolbarWithText:(NSString*)inputText
{
    [messagesArray addObject:inputText];
    [messageTableView reloadData];
    
    [messageTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:messagesArray.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    
    [toolBarView resetToolbar];
    
}

-(void) toolBarViewBeginEditing
{
    
    //    messageTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 300)];
    [messageTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:messagesArray.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
}

-(void) toolBarViewEndEditing
{
    messageTableView.frame =  CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height - 44);
}

#pragma mark - keyboard handling


- (void)keyboardSizeCahnged:(NSNotification*)notification
{
    
    CGRect keyboardRect = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    keyboardRect = [self.view convertRect:keyboardRect fromView:nil]; //this is it!
    
    [UIView animateWithDuration:0
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         CGRect r = messageTableView.frame;
                         r.size.height = self.view.frame.size.height - keyboardRect.size.height - 44;
                         [messageTableView setFrame:r];
                     } completion:nil];
    [messageTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:messagesArray.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
}



@end
