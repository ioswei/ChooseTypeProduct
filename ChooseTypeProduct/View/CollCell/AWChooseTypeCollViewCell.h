//
//  AWChooseTypeCollViewCell.h
//  YearGoodsProduct
//
//  Created by iMac-1 on 2019/4/17.
//  Copyright © 2019 iOS_阿玮. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AWChooseTypeModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol AWChooseTypeCollViewCellDelegate <NSObject>

/**
 获取点击返回的titem
 */
- (void)aWChooseTypeCollViewCellChooseTypeClickBlockItemModel:(AWChooseTypeModel *)item
                                              withChooseIndex:(NSInteger)index;

@end

@interface AWChooseTypeCollViewCell : UICollectionViewCell

@property (nonatomic,strong) AWChooseTypeModel *item;
@property (nonatomic,assign) NSInteger showIndex;
@property (nonatomic,assign) id<AWChooseTypeCollViewCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
