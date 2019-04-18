//
//  AWChooseTypeModel.h
//  YearGoodsProduct
//
//  Created by iMac-1 on 2019/4/18.
//  Copyright © 2019 iOS_阿玮. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AWChooseTypeModel : NSObject

/**
 类型id
 */
@property (nonatomic,copy) NSString *type_id;

/**
 类型名称
 */
@property (nonatomic,copy) NSString *name;

/**
 是否选择
 */
@property (nonatomic,assign) BOOL isChoose;

/**
 其他描述
 */
@property (nonatomic,copy) NSString *content;

@end

NS_ASSUME_NONNULL_END
