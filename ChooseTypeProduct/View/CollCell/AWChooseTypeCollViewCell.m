//
//  AWChooseTypeCollViewCell.m
//  YearGoodsProduct
//
//  Created by iMac-1 on 2019/4/17.
//  Copyright © 2019 iOS_阿玮. All rights reserved.
//

#import "AWChooseTypeCollViewCell.h"

@interface AWChooseTypeCollViewCell ()

@property (weak, nonatomic) IBOutlet UIButton *btn_showName;

@end

@implementation AWChooseTypeCollViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)chooseClick:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(aWChooseTypeCollViewCellChooseTypeClickBlockItemModel:withChooseIndex:)]) {
        [self.delegate aWChooseTypeCollViewCellChooseTypeClickBlockItemModel:self.item withChooseIndex:self.showIndex];
    }
    
    
}

- (void)setShowIndex:(NSInteger)showIndex{
    
    _showIndex = showIndex;
    
}

- (void)setItem:(AWChooseTypeModel *)item{
    
    _item = item;
    if (item) {
        
        self.btn_showName.selected = item.isChoose;
        [self.btn_showName setTitle:[NSString stringWithFormat:@"  %@",item.name] forState:(UIControlStateNormal)];
        
    }
    
}

@end
