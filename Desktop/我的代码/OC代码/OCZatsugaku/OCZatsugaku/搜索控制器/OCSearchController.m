//
//  OCSearchController.m
//  OCZatsugaku
//
//  Created by lkx on 2017/6/27.
//  Copyright © 2017年 lkx. All rights reserved.
//

#import "OCSearchController.h"
#import "NSFileManager+LKXCategory.h"
#import "Masonry.h"
//#import "UISearchBar+FMAdd.h"
#import "UISearchBar+LKXCategory.h"

/**
 * UISearchController
 * 在启动搜索的时候才会调用UISearchController
 * isActive:YES的时候表示开始搜索，NO表示退出搜索
 */

@interface OCSearchController () <UISearchResultsUpdating, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource>

/** 搜索控制器 */
@property(nonatomic, strong) UISearchController *searchController;
/** 搜索结果数据源 */
@property(nonatomic, strong) NSMutableArray *searchDataSource;
/** tableView */
@property(nonatomic, strong) UITableView *tableView;

@end

@implementation OCSearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self.view addSubview:self.tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.bottom.right.equalTo(@0);
    }];
    [_tableView registerClass:[UITableViewCell class]
       forCellReuseIdentifier:@"cell"];
    [self p_configureSearchController];
    
    [self p_getData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)p_configureSearchController {
    if (!_searchController) {
        _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
        _searchController.searchResultsUpdater = self;
        _searchController.dimsBackgroundDuringPresentation = NO;
        _searchController.definesPresentationContext = YES;
        [_searchController.searchBar sizeToFit];
        
        UISearchBar *searchBar = _searchController.searchBar;
        searchBar.placeholder = @"搜索";
        searchBar.delegate = self;
        
        // 1. 设置背景颜色
        // 设置背景颜色是为了去掉上下黑线
        searchBar.backgroundImage = [[UIImage alloc] init];
        searchBar.barTintColor = [UIColor whiteColor];
        
        // 2. 设置圆角和边框颜色
        UITextField *searchTFl = [searchBar valueForKey:@"searchField"];
        if (searchTFl) {
            [searchTFl setBackgroundColor:[UIColor whiteColor]
                             cornerRadius:14.0
                              borderWidth:1
                              borderColor:RGBCOLOR(247, 75, 31)];
        }
        
        // 3. 设置按钮文字和颜色
        [searchBar lkx_setCancelButtonTitle:@"取消"];
        searchBar.tintColor = RGBCOLOR(86, 179, 11);
        [searchBar lkx_setCancelButtonFont:[UIFont systemFontOfSize:22]];
        // 修正光标颜色
        [searchTFl setTintColor:[UIColor blackColor]];
        
        // 4. 设置输入框文字颜色和字体
        [searchBar lkx_setTextColor:[UIColor blackColor]];
        [searchBar lkx_setTextFont:[UIFont systemFontOfSize:14]];
        
        // 5. 设置搜索Icon
        [searchBar setImage:[UIImage imageNamed:@"Search_Icon"]
           forSearchBarIcon:UISearchBarIconSearch
                      state:UIControlStateNormal];
        
        // 6. 实现类似微信的搜索框
        UIButton *voiceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [voiceBtn setImage:[UIImage imageNamed:@"Voice_button_icon"]
                  forState:UIControlStateNormal];
        [voiceBtn addTarget:self
                     action:@selector(voiceAction:)
           forControlEvents:UIControlEventTouchUpInside];
        [searchTFl addSubview:voiceBtn];
//        [voiceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerY.equalTo(searchTFl);
//            make.right.equalTo(@21);
//            make.size.mas_equalTo(CGSizeMake(21, 21));
//        }];

        voiceBtn.translatesAutoresizingMaskIntoConstraints = NO;
        NSDictionary *views = NSDictionaryOfVariableBindings(voiceBtn);
        //设置水平方向约束
        [searchTFl addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[voiceBtn(21)]-|" options:NSLayoutFormatAlignAllRight | NSLayoutFormatAlignAllLeft metrics:nil views:views]];
        //设置高度约束
        [searchTFl addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[voiceBtn(21)]" options:NSLayoutFormatAlignAllTop | NSLayoutFormatAlignAllBottom metrics:nil views:views]];
        //设置垂直方向居中约束
        [searchTFl addConstraint:[NSLayoutConstraint constraintWithItem:voiceBtn attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:searchTFl attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
        
        self.tableView.tableHeaderView = searchBar;
    }
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (NSMutableArray *)searchDataSource {
    if(!_searchDataSource) {
        _searchDataSource = [NSMutableArray array];
    }
    return _searchDataSource;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.translatesAutoresizingMaskIntoConstraints = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = self.view.backgroundColor;
        _tableView.separatorInset = UIEdgeInsetsZero;
//        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    }
    
    return _tableView;
}

#pragma mark - UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *searchText = searchController.searchBar.text;
    LKXMLog(@"updateSearchResultsForSearchController----:%@", searchText);
    
    if (_searchController.isActive) {
        [_searchDataSource removeAllObjects];
        for (NSString *str in self.dataSource) {
            if ([str containsString:searchText]) {
                [_searchDataSource addObject:str];
            }
        }
    }
    
    [self.tableView reloadData];
}

#pragma mark - UISearchBarDelegate
// return NO to not become first responder
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    LKXMLog(@"searchBarShouldBeginEditing");
    return YES;
}
// called when text starts editing
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    LKXMLog(@"searchBarTextDidBeginEditing");
}
// return NO to not resign first responder
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
    LKXMLog(@"searchBarShouldEndEditing");
    return YES;
}

// called when text ends editing
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    LKXMLog(@"searchBarTextDidEndEditing");
}

// called when text changes (including clear)
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    LKXMLog(@"textDidChange");
}

// called before text changes
- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    LKXMLog(@"shouldChangeTextInRange");
    return YES;
}

// called when keyboard search button pressed
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    LKXMLog(@"searchBarSearchButtonClicked");
}

// called when bookmark button pressed
- (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar {
    LKXMLog(@"searchBarBookmarkButtonClicked");
}

// called when cancel button pressed
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self.tableView reloadData];
    LKXMLog(@"searchBarCancelButtonClicked");
}

// called when search results button pressed
- (void)searchBarResultsListButtonClicked:(UISearchBar *)searchBar {
    LKXMLog(@"searchBarResultsListButtonClicked");
}

- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope {
    LKXMLog(@"selectedScopeButtonIndexDidChange");
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_searchController.isActive) {
        return self.searchDataSource.count;
    } else {
        return _dataSource.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = _searchController.isActive ? _searchDataSource[indexPath.row] : _dataSource[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

#pragma mark - other
- (void)p_getData {
    NSString *string = [[NSFileManager defaultManager] lkx_stringWithBundleFilename:@"countries.txt"];
    NSArray *arr = [string componentsSeparatedByString:@"\n"];
    self.dataSource = [arr mutableCopy];
    [self.dataSource removeLastObject];
    
    [self.tableView reloadData];
}

- (void)voiceAction:(UIButton *)btn {
    
}

@end
