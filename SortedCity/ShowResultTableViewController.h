//
//  ShowResultTableViewController.h
//  搜索框
//
//  Created by stone on 16/4/29.
//  Copyright © 2016年 zm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowResultTableViewController : UITableViewController


//本控制器是被动使用的，所有要展示数据的来源，就有使用者提供，所以要公开一个数组，用于存储要展示的数据
@property (nonatomic,strong)NSArray* resultArray;;


@end
