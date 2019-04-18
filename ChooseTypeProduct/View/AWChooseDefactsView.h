//
//  AWChooseDefactsView.h
//  YearGoodsProduct
//
//  Created by iMac-1 on 2019/4/17.
//  Copyright © 2019 iOS_阿玮. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^AWBlackChooseData)(BOOL isHaveOther,NSMutableArray *chooseDataList,NSString *otherInfo);

@interface AWChooseDefactsView : UIView 

/**
 自定义创建选择类型view

 @param listData 数据源
 @param title 标题
 @param otherTitle 其他标题
 @param placeHolder 其他默认提示
 @param block 返回数据
 */
+ (void)showViewData:(NSMutableArray *)listData
           withTitle:(NSString *)title
      withOtherTitle:(NSString *)otherTitle
     withPlaceHolder:(NSString *)placeHolder
       withBackBlock:(AWBlackChooseData)block;


@end

NS_ASSUME_NONNULL_END
