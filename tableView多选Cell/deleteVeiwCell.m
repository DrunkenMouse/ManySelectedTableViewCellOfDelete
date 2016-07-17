//
//  deleteVeiwCell.m
//  tableView多选Cell
//
//  Created by 王奥东 on 16/7/17.
//  Copyright © 2016年 王奥东. All rights reserved.
//

#import "deleteVeiwCell.h"

@implementation deleteVeiwCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}



-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    
    [super setHighlighted:highlighted animated:animated];
    
    if (highlighted) {
        if (super.editing == YES) {
            UIImageView *imageView = [[[self.subviews lastObject]subviews]firstObject];
            imageView.image = [UIImage imageNamed:@"chose_06"];
        }
    }
    
    
    
    
}








@end
