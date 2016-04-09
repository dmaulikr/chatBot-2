//
//  MessagesViewController.h
//  ChatBot
//
//  Created by Gopi Krishnan on 20/03/16.
//  Copyright (c) 2016 Gopi Krishnan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatToolbarView.h"


@interface MessagesViewController : UIViewController <ChatToolbarDelegate, UITableViewDelegate, UITableViewDataSource > {

    NSMutableArray* messagesArray;
    UITableView* messageTableView;
    ChatToolbarView* toolBarView;
    
    

}

@end
