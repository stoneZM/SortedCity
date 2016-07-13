//
//  ViewController.m
//  地区列表展示
//
//  Created by stone on 16/7/13.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "ViewController.h"
#import "ViewModel.h"
#import "ShowResultTableViewController.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchControllerDelegate,UISearchResultsUpdating,UISearchBarDelegate>
@property (nonatomic,strong)UITableView* tableView;
@property (nonatomic,strong)ViewModel* viewModel;
//增加属性：用于记录搜索控制器
@property(nonatomic,strong)UISearchController* secrchController;

//用于展示搜索结果的控制器
@property(nonatomic,strong)ShowResultTableViewController* showResultVC;
@end

@implementation ViewController

-(ShowResultTableViewController *)showResultVC{
    if (_showResultVC == nil) {
        _showResultVC = [ShowResultTableViewController new];
    }
    return _showResultVC;
}

-(UISearchController *)secrchController{
    if (_secrchController == nil) {
        _secrchController = [[UISearchController alloc]initWithSearchResultsController:self.showResultVC];
        _secrchController.delegate = self;
        [_secrchController.searchBar sizeToFit];
        _secrchController.definesPresentationContext = YES;
        _secrchController.searchResultsUpdater = self;
    }
    return _secrchController;
}

-(ViewModel *)viewModel{
    if (_viewModel == nil) {
        _viewModel = [ViewModel new];
    }
    return _viewModel;
}

-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView.backgroundColor = [UIColor redColor];
        _tableView.tableHeaderView = self.secrchController.searchBar;

    }
    return _tableView;
}

#pragma mark UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //    return self.viewModel.sectionNum;
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //    return [self.viewModel rowNumForSection:section];
    return [self.viewModel rowNum];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    //    cell.textLabel.text = [self.viewModel titleForRowInSection:indexPath.section row:indexPath.row];
    cell.textLabel.text = [self.viewModel titleForrow:indexPath.row];
    return cell;
}
//-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
////    return [self.viewModel titleForSection:section];
//}

#pragma mark UITabelViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 30;
    }
    else return 35;
}

#pragma mark - UISearchResultUpdating
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    //从委托方中获取用户在文本框中的输入内容
    //    NSString* searchText = searchController.searchBar.text;

    //到self.allProducts中逐一比对
    //    NSMutableArray* resultArray = [[NSMutableArray alloc]init];
    //    for (Product* p in self.allProducts) {
    //        NSRange range = [p.name rangeOfString:searchText];
    //        //如果名称匹配切类别相同，则将此产品记录到数组中
    //        if (range.length > 0&& p.type == selectedIndex) {
    //            [resultArray addObject:p];
    //        }
    //    }
    //将要展示的结果给负责展示数据的VC传过去
    //    self.showResultVC.resultArray = resultArray;
    [self.showResultVC.tableView reloadData];

    //为了点击serchBar上的类别按钮时，也能有响应，所以设置searchBar的代理
    self.secrchController.searchBar.delegate = self;

}


#pragma mark UISearchBarDelegate
-(void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope
{

    [self updateSearchResultsForSearchController:self.secrchController];

}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = YES;

    [self.view addSubview:self.tableView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
