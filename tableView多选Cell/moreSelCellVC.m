//
//  moreSelCellVC.m
//  tableView多选Cell
//
//  Created by 王奥东 on 16/7/14.
//  Copyright © 2016年 王奥东. All rights reserved.
//

#import "moreSelCellVC.h"
#import "EditView.h"
#import "deleteVeiwCell.h"



#define W [UIScreen mainScreen].bounds.size.width
#define H [UIScreen mainScreen].bounds.size.height
#define GrayColor  [UIColor colorWithRed:(242)/255.0 green:(242)/255.0 blue:(242)/255.0 alpha:1.0];


@interface moreSelCellVC ()<UITableViewDelegate,UITableViewDataSource>


@property (weak, nonatomic) IBOutlet UITableView *deleteTableView;

@property(nonatomic,strong)EditView *editView;

//原数据数组
@property(nonatomic,strong)NSMutableArray *dataArray;

//删除数据数组
@property(nonatomic,strong)NSMutableArray *deleteDataArray;

//删除数据中数组的个数
@property(assign,nonatomic)NSUInteger number;



@end

@implementation moreSelCellVC


//选中状态时的自定义视图可通过取出系统自带的选中视图而后手动修改
//[[cell.subviews lastObject]subviews]选中状态下的视图
//通过返回的数组修改第一个ImageView的Image即可

//通过编辑模式创建一个EditView，并打开tableView的可编辑模式
//通过可编辑模式为多选来达到可多选删除
//通过数组deleDataArray来保存要删除的数据
//通过源数据dataArray[indexPath.row]获取要添加的对象
//通过数组的removeObjectInArray来删除数组中保存的数据
//选中状态时即为添加选中状态，取消选中即为取消选中状态
//所以全选也是通过遍历所有的cell来手动添加或取消
//因为可变数组的个数无法监听，所以通过number的set方法监听
//添加可删除的数据时，即让Number+1，若number等于数据数组的count
//即为全选装填，Number=0即为取消全选状态
//否则就是普通的选择状态


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"多选删除";
    
    //设置编辑按钮
    UIButton * editingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [editingBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [editingBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    editingBtn.frame = CGRectMake(W - 50, 10, 40, 30);
    [editingBtn addTarget:self action:@selector(editingClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc]initWithCustomView:editingBtn];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    

    
    
}


//因为NSMutableArray的个数无法监听，才使用number
//number为删除数据的数组个数
//只要number的值发生变化，就会执行该方法

#pragma mark - number
-(void)setNumber:(NSUInteger)number{
    
    _number = number;
    
    //取消全选
    if (self.number == 0) {
        [self.editView.deleteButton setBackgroundColor:[UIColor grayColor]];
        self.editView.smallButton.selected = NO;
        self.editView.bigButton.selected =NO;
        [self.editView.smallButton setBackgroundImage:[UIImage imageNamed:@"chose_03"] forState:UIControlStateNormal];
    }
    //开启全选
    else if (self.number == self.dataArray.count){
        
        [self.editView.deleteButton setBackgroundColor:[UIColor redColor]];
        self.editView.smallButton.selected = YES;
        self.editView.bigButton.selected = YES;
        [self.editView.smallButton setBackgroundImage:[UIImage imageNamed:@"chose_06"] forState:0];
        
    }
    //选中了某一些要删除的数据
    else{
        
        [self.editView.deleteButton setBackgroundColor:[UIColor redColor]];
        self.editView.smallButton.selected = NO;
        self.editView.bigButton.selected = NO;
        [self.editView.smallButton setBackgroundImage:[UIImage imageNamed:@"chose_03"] forState:0];
        
    }
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
     return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    deleteVeiwCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ADCell" forIndexPath:indexPath];
    
    cell.deleteLabel.text = self.dataArray[indexPath.row];
    
    //此处一定不能使用None，否则会造成很多问题
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    
    //复用时自定义按钮不会被系统还原，需要手动修改
    if (cell.selected == YES && tableView.editing == YES) {
        //取出系统自带的选中视图
        //tableView允许编辑状态下打印cell.subViews 其中UITableViewCellEditiControl即为编辑状态下的视图
        //[[cell.subViews lastObject]subViews]选中状态下的视图
        UIImageView *imageView = [[[cell.subviews lastObject]subviews]firstObject];
        //改变选中状态下的视图
        imageView.image = [UIImage imageNamed:@"chose_06"];
        
    }
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

#pragma mark - cell的选种模式
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self.deleteTableView cellForRowAtIndexPath:indexPath];
    if (tableView.editing == YES) {
    
        UIImageView *imageView = [[[cell.subviews lastObject]subviews]firstObject];
        imageView.image = [UIImage imageNamed:@"chose_06"];
    
        //将选中的数据添加到deleteDataArray数组中
        [self.deleteDataArray addObject:self.dataArray[indexPath.row]];
        self.number = self.deleteDataArray.count;

    }
    
}

#pragma mark - 取消选中模式
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.editing == YES) {
        [self.deleteDataArray removeObject:self.dataArray[indexPath.row]];
        self.number = self.deleteDataArray.count;
    }
}





#pragma mark - UITableView是否可进入编辑状态
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
}

#pragma mark - 修改编辑时的状态
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
//    UITableViewCellEditingStyleNone, //无
//    UITableViewCellEditingStyleDelete, //删除状态
//    UITableViewCellEditingStyleInsert //插入状态


    //多选则是复合型：
    return   UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;

}


//提交编辑时响应的方法，编辑状态下不会调用
//-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
//
//}




//系统自带的单个删除的方法
//-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        [self.dataArray removeObjectAtIndex:indexPath.row];
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
//    }
//    
//}



#pragma mark - 编辑按钮的响应事件
-(void)editingClick:(UIButton *)sender{
    
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        
        [sender setTitle:@"完成" forState:UIControlStateNormal];
        [self.view addSubview:self.editView];
        
        //启动tableView的编辑模式
        self.deleteTableView.editing = YES;
    }
    else{
        
        [sender setTitle:@"编辑" forState:UIControlStateNormal];
        [self.editView removeFromSuperview];
        
        //关闭tableView的编辑模式
        self.deleteTableView.editing = NO;
        
    }
    
}


#pragma mark - 全选按钮的响应事件
-(void)editVeiwSelectButtonAction:(UIButton *)sender{
    
    if (sender.selected) {
        
        //先删除之前添加到deleteDataArray数组中的数据
        [self.deleteDataArray removeAllObjects];
        //再添加所有数据
        [self.deleteDataArray addObjectsFromArray:self.dataArray];
        
        for (int i = 0; i < self.dataArray.count; i++) {
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
            //设为选中状态
            //设为选中状态时，就添加到了可删除的数组
            [self.deleteTableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
            //改变选中状态下的视图
            UITableViewCell *cell = [self.deleteTableView cellForRowAtIndexPath:indexPath];
            UIImageView *imageView = [[[cell.subviews lastObject]subviews]firstObject];
            imageView.image = [UIImage imageNamed:@"chose_06"];
            
        }
        
        self.number = self.dataArray.count;
    }else{
        [self.deleteDataArray removeAllObjects];
        for (int i=0; i<self.dataArray.count; i++) {
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
            
            //取消选中状态
            [self.deleteTableView deselectRowAtIndexPath:indexPath animated:YES];
            self.number = 0;
            
        }
    }
    
}


#pragma mark - 删除按钮
-(void)editViewdeleteButtonAction:(UIButton *)sender{
    
    [self.dataArray removeObjectsInArray:self.deleteDataArray];
    [self.deleteTableView reloadData];
    
}


#pragma mark - editView初始化
-(EditView *)editView{
    
    if (!_editView) {
        self.editView = [[EditView alloc]initWithFrame:CGRectMake(0, H-50-64, W, 50)];
        _editView.backgroundColor = GrayColor;
        [_editView.deleteButton addTarget:self action:@selector(editViewdeleteButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_editView.bigButton addTarget:self action:@selector(editVeiwSelectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_editView.smallButton addTarget:self action:@selector(editVeiwSelectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return _editView;
}


-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray=[NSMutableArray array];
        NSArray *array = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11"];
        [_dataArray addObjectsFromArray:array];
    }
    return _dataArray;
}

-(NSMutableArray *)deleteDataArray{
    
    if (!_deleteDataArray) {
        _deleteDataArray = [NSMutableArray array];
    }
    return _deleteDataArray;
    
}





















@end
