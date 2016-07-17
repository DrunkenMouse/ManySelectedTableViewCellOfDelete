//
//  EditView.m
//  tableView多选Cell
//
//  Created by 王奥东 on 16/7/17.
//  Copyright © 2016年 王奥东. All rights reserved.
//

#import "EditView.h"

#define W  [UIScreen mainScreen].bounds.size.width
#define GrayColor  [UIColor colorWithRed:(242)/255.0 green:(242)/255.0 blue:(242)/255.0 alpha:1.0];

@implementation EditView


-(instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = GrayColor;
        [self addSubview:self.bigButton];
        [self addSubview:self.numberLabel];
        [self addSubview:self.deleteButton];
    }

    return self;


}


-(UIButton *)bigButton{
    if (!_bigButton) {
        
        _bigButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _bigButton.frame = CGRectMake(0, 0, 100, 50);
        [_bigButton addSubview:self.smallButton];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.smallButton.frame), CGRectGetMinY(self.smallButton.frame), 40, CGRectGetHeight(self.smallButton.frame))];
        
        label.text = @"全选";
        label.textAlignment = NSTextAlignmentCenter;
        [_bigButton addSubview:label];
        [_bigButton addTarget:self action:@selector(EditBigButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
    }
    return _bigButton;
}


-(UIButton *)smallButton{
    if (!_smallButton) {
        self.smallButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _smallButton.frame = CGRectMake(10, 10, 30, 30);
        [_smallButton setBackgroundImage:[UIImage imageNamed:@"chose_03"] forState:UIControlStateNormal];
        
        [_smallButton addTarget:self action:@selector(EditBigButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _smallButton;
}

-(UIButton *)deleteButton{
    if (!_deleteButton) {
        
        self.deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _deleteButton.frame = CGRectMake(W - 80 - 10, 10, 80, 30);
        [_deleteButton setTitle:@"删除" forState:UIControlStateNormal];
        _deleteButton.titleLabel.font = [UIFont systemFontOfSize:16];
        _deleteButton.backgroundColor = [UIColor redColor];
        _deleteButton.layer.masksToBounds  = YES;
        
        _deleteButton.layer.cornerRadius = 5;
        
        
    }
    return _deleteButton;
}






-(void)EditBigButtonAction:(UIButton *)sender{
    
    
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        [self.smallButton setBackgroundImage:[UIImage imageNamed:@"chose_06"] forState:UIControlStateNormal];
    }else{
        [self.smallButton setBackgroundImage:[UIImage imageNamed:@"chose_03"] forState:0];
    }
    
}
























@end
