//
//  LFBaseTableViewController.m
//  LayerTest
//
//  Created by 娜娜子 on 19/04/2019.
//  Copyright © 2019 Lonely traveller. All rights reserved.
//

#import "LFBaseTableViewController.h"
@interface LFBaseTableViewController ()

@end

@implementation LFBaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateSeperatorInsets];
}

- (void)updateSeperatorInsets
{
    if([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
      [self.tableView setSeparatorInset:self.tableViewSeperatorInsets];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
       [self.tableView setLayoutMargins:self.tableViewSeperatorInsets];
    }
}
#pragma mark - UITableViewDataSource,UITableViewDelegate
- (UIEdgeInsets)tableViewSeperatorInsets
{
    return UIEdgeInsetsZero;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CGFloat height = [self tableView:tableView heightForHeaderInSection:section];
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, height)];
    return header;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    CGFloat height = [self tableView:tableView heightForFooterInSection:section];
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, height)];
    return footer;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [UITableViewCell cellFromCodeWithTableView:tableView];
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:self.tableViewSeperatorInsets];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:self.tableViewSeperatorInsets];
    }
}
#pragma mark - getter && setter
- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
    }
    return _tableView;
}
@end
