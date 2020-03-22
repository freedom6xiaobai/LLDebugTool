//
//  LLNetworkFilterViewController.m
//
//  Copyright (c) 2018 LLDebugTool Software Foundation (https://github.com/HDB-Li/LLDebugTool)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

#import "LLNetworkFilterViewController.h"

#import "LLFormatterTool.h"
#import "LLNetworkModel.h"
#import "LLTitleCellCategoryModel.h"
#import "LLTitleCellModel.h"

@interface LLNetworkFilterViewController ()

@property (nonatomic, strong) NSDate *fromDate;

@property (nonatomic, strong) NSDate *endDate;

@end

@implementation LLNetworkFilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.allowsMultipleSelection = YES;
}

#pragma mark - Public
- (void)configWithData:(NSArray<LLNetworkModel *> *)data {
    //    self.tableView.editing = YES;

    [self loadFilterData:data];
    // Date
    //    NSString *fromString = data.lastObject.startDate;
    //    NSString *endString = data.firstObject.startDate;
    //
    //    NSDate *fromDate = [LLFormatterTool dateFromString:fromString style:FormatterToolDateStyle1];
    //    NSDate *endDate = [LLFormatterTool dateFromString:endString style:FormatterToolDateStyle1];
    //    if (!fromDate) {
    //        fromDate = [NSDate date];
    //    }
    //    if (!endDate) {
    //        endDate = [NSDate date];
    //    }
    //
    //    self.fromDate = fromDate;
    //    self.endDate = endDate;
    [self loadDateData];

    [self.tableView reloadData];
}

- (void)loadFilterData:(NSArray<LLNetworkModel *> *)data {
    NSMutableArray *settings = [[NSMutableArray alloc] init];

    // Host
    NSMutableSet *hostSet = [NSMutableSet set];
    for (LLNetworkModel *model in data) {
        if (model.url.host.length) {
            [hostSet addObject:model.url.host];
        }
    }

    for (NSString *host in hostSet.allObjects) {
        LLTitleCellModel *model = [LLTitleCellModel modelWithTitle:host];
        [settings addObject:model];
    }

    LLTitleCellCategoryModel *category0 = [LLTitleCellCategoryModel modelWithTitle:@"Host" items:settings];
    [self.dataArray addObject:category0];
    [settings removeAllObjects];

    // Filter
    for (NSString *filter in @[@"Header", @"Body", @"Response"]) {
        LLTitleCellModel *model = [LLTitleCellModel modelWithTitle:filter];
        [settings addObject:model];
    }

    LLTitleCellCategoryModel *category = [LLTitleCellCategoryModel modelWithTitle:@"Filter" items:settings];
    [self.dataArray addObject:category];
}

- (void)loadDateData {
    NSMutableArray *settings = [[NSMutableArray alloc] init];
    [settings addObject:[LLTitleCellModel modelWithTitle:@"Please Select From Date"]];
    [settings addObject:[LLTitleCellModel modelWithTitle:@"Please Select End Date"]];
    LLTitleCellCategoryModel *category = [LLTitleCellCategoryModel modelWithTitle:@"Date" items:settings];
    [self.dataArray addObject:category];
}

#pragma mark - Over write
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    return cell;
}

@end
