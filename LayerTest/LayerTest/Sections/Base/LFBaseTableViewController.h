//
//  LFBaseTableViewController.h
//  LayerTest
//
//  Created by 娜娜子 on 19/04/2019.
//  Copyright © 2019 Lonely traveller. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITableViewCell+DequeCell.h"
#import "UIColor+Tools.h"

@interface LFBaseTableViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
- (UIEdgeInsets)tableViewSeperatorInsets;
@end

