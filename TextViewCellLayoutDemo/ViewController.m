//
//  ViewController.m
//  TextViewCellLayoutDemo
//
//  Created by Robin on 16/8/20.
//  Copyright © 2016年 Robin. All rights reserved.
//

#import "ViewController.h"
#import "TextViewTableViewCell.h"

@interface ViewController ()<UITableViewDelegate ,UITableViewDataSource,UITextViewDelegate>{
    
    UITextView *_currentTextView;
    NSIndexPath *_currentIndexPath;
}
@property (weak, nonatomic) IBOutlet UITableView *textViewList;
@property (nonatomic ,strong)NSMutableDictionary *cellHeightDic;
@property (nonatomic ,strong)UIView *keybroadView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.textViewList.estimatedRowHeight = 50.f;
    self.textViewList.rowHeight = UITableViewAutomaticDimension;
    [self.textViewList registerNib:[UINib nibWithNibName:@"TextViewTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"TextCell"];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(reset:)];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(test:)];
    [self.textViewList addGestureRecognizer:tap];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)test:(id)sender{
    NSLog(@"tap");
}
- (void)reset:(UIBarButtonItem *)sender{
    [self.cellHeightDic removeAllObjects];
    [self.textViewList reloadData];
}

- (UIView *)keybroadView{
    if (!_keybroadView) {
        _keybroadView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen]bounds]];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [_keybroadView addGestureRecognizer:tap];
    }
    return _keybroadView;
}

- (NSMutableDictionary *)cellHeightDic{
    if (!_cellHeightDic) {
        _cellHeightDic = [NSMutableDictionary dictionary];
    }
    return _cellHeightDic;
}

- (void)tapAction:(UITapGestureRecognizer *)sender{
    [_currentTextView resignFirstResponder];
    [self.keybroadView removeFromSuperview];
}

#pragma mark -- Tabledelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TextCell"];

    TextViewTableViewCell *tempCell = (TextViewTableViewCell *)cell;
    tempCell.textView.text = self.cellHeightDic[indexPath]? :@"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.";
    tempCell.textView.delegate = self;
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 20;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - textViewDelegate

- (void)textViewDidChange:(UITextView *)textView{
    
    CGRect bounds = textView.bounds;
    CGSize maxSize = CGSizeMake(bounds.size.width, CGFLOAT_MAX);
    CGRect tempRect =  [textView.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
    bounds.size.height = tempRect.size.height;
    textView.bounds = bounds;
    [self.textViewList beginUpdates];
    [self.textViewList endUpdates];
   
}
- (void)textViewDidEndEditing:(UITextView *)textView{
     [self.cellHeightDic setObject:textView.text forKey:_currentIndexPath];
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    [self.view addSubview:self.keybroadView];
    _currentTextView = textView;
    UITableViewCell *tempCell = (UITableViewCell *)[[_currentTextView superview] superview];
    _currentIndexPath = [self.textViewList indexPathForCell:tempCell];
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
