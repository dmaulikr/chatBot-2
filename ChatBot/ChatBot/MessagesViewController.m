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
    
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    
    self.tableView.rowHeight  = 90;

    
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
    
    [cell setMessageWithType:2];
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

@end
