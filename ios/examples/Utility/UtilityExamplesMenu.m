//
//  UtilityExamplesMenu.m
//  ios
//
//  Created by 高敏 on 2018/6/6.
//  Copyright © 2018年 losermo4. All rights reserved.
//

#import "UtilityExamplesMenu.h"
#import "iOSExampleModel.h"

@interface UtilityExamplesMenu ()

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation UtilityExamplesMenu

static NSString *identifier = @"identifier";


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setData];
}


- (void)setData{
    [self addText:@"MGCDTimerExample" detailText:@"MGCDTimerExample demo" className:@"MGCDTimerExample"];

}


- (void)addText:(NSString *)text detailText:(NSString *)detailText className:(NSString *)className{
    iOSExampleModel *model = [[iOSExampleModel alloc] init];
    model.text = text;
    model.detailText = detailText;
    model.className = className;
    [self.dataSource addObject:model];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    iOSExampleModel *model = self.dataSource[indexPath.row];
    cell.textLabel.text = model.text;
    cell.detailTextLabel.text = model.detailText;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    iOSExampleModel *model = self.dataSource[indexPath.row];
    Class class = NSClassFromString(model.className);
    if (class) {
        UIViewController *controller = [[class alloc] init];
        controller.title = model.text;
        [self.navigationController pushViewController:controller animated:YES];
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSMutableArray *)dataSource{
    if (_dataSource) return _dataSource;
    _dataSource = [NSMutableArray array];
    return _dataSource;
}

@end
