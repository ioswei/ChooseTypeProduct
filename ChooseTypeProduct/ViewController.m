//
//  ViewController.m
//  ChooseTypeProduct
//
//  Created by iMac-1 on 2019/4/18.
//  Copyright © 2019 iOS_阿玮. All rights reserved.
//

#import "ViewController.h"

#import "AWChooseDefactsView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)showClick:(UIButton *)sender {
    
    NSMutableArray *list = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i < 12; i++) {
        [list addObject:[NSString stringWithFormat:@"---特殊--%d",i]];
    }
    [list addObject:@"其他"];
    [AWChooseDefactsView showViewData:list withTitle:@"标题" withOtherTitle:@"详细描述" withPlaceHolder:@"请设置一个详细描述" withBackBlock:^(BOOL isHaveOther, NSMutableArray * _Nonnull chooseDataList, NSString * _Nonnull otherInfo) {
        
    }];

    
}

@end
