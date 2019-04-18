//
//  AWChooseDefactsView.m
//  YearGoodsProduct
//
//  Created by iMac-1 on 2019/4/17.
//  Copyright © 2019 iOS_阿玮. All rights reserved.
//

#import "AWChooseDefactsView.h"
#import "AWPlaceHolderTextView.h"
#import "AWChooseTypeCollViewCell.h"

#import "AWChooseTypeModel.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define NorViewHeight 130

@interface AWChooseDefactsView () <UICollectionViewDelegate,UICollectionViewDataSource,AWChooseTypeCollViewCellDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *mainCollection;
@property (weak, nonatomic) IBOutlet UIView *otherView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *otherHeight;
@property (weak, nonatomic) IBOutlet AWPlaceHolderTextView *tf_content;
@property (weak, nonatomic) IBOutlet UIButton *btn_true;
@property (nonatomic,strong) NSMutableArray *mainSource;
@property (nonatomic,strong) NSMutableArray *chooseSource;

@property (nonatomic,copy) NSString *showTitle;
@property (nonatomic,copy) NSString *otherTitle;
@property (nonatomic,copy) NSString *showPlaceHolder;

@property (nonatomic,copy) AWBlackChooseData showBlock;
@property (weak, nonatomic) IBOutlet UILabel *lab_title;
@property (weak, nonatomic) IBOutlet UILabel *lab_otherTitle;

@property (nonatomic,strong) UIView *backView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btn_topHeight;

@end

@implementation AWChooseDefactsView

+ (instancetype)creatViewWithData:(NSMutableArray *)dataList
                    withShowTitle:(NSString *)title
                   withOtherTitle:(NSString *)otherTitle
              withShowPlaceHolder:(NSString *)placeHolder
                        withBlock:(AWBlackChooseData)block{
    
    float height = NorViewHeight+dataList.count/3.0*40;
    if (dataList.count %3 != 0) {
        height = NorViewHeight+(dataList.count/3.0+1)*40-15;
    }
    
    AWChooseDefactsView *chooseView = [[AWChooseDefactsView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, height) withHeight:height];
    chooseView.showPlaceHolder = placeHolder;
    chooseView.showBlock = block;
    chooseView.showTitle = title;
    chooseView.otherTitle = otherTitle;
    [chooseView.mainCollection registerNib:[UINib nibWithNibName:NSStringFromClass([AWChooseTypeCollViewCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([AWChooseTypeCollViewCell class])];
    return chooseView;
    
}

- (instancetype)initWithFrame:(CGRect)frame withHeight:(float)height{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.7f];
        //ARRewardView : 自定义的view名称
        NSArray *nibView = [[NSBundle mainBundle] loadNibNamed:@"AWChooseDefactsView"
                                                         owner:self
                                                       options:nil];
        self.backView = [nibView objectAtIndex:0];
        self.chooseSource = [NSMutableArray arrayWithCapacity:0];
        self.backView.frame = CGRectMake(0, 0, SCREEN_WIDTH, height);
        self.backView.center = self.center;
        self.mainCollection.delegate = self;
        self.mainCollection.dataSource = self;
        self.otherHeight.constant = 0.0f;
        self.btn_topHeight.constant = 0.0f;
        [self addSubview:self.backView];
        
        [self.mainCollection reloadData];
        
        self.btn_true.layer.cornerRadius = 5.0f;
        
        self.tf_content.placeholderColor = [UIColor grayColor];
        self.tf_content.layer.borderWidth = 0.5;
        self.tf_content.layer.borderColor = [UIColor grayColor].CGColor;
        
    }
    return self;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake((SCREEN_WIDTH-11*4)/3.0, 30);
    
}

// 告诉系统每组多少个
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.mainSource.count;
}

// 告诉系统每个Cell如何显示
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    // 1.从缓存池中取
    AWChooseTypeCollViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AWChooseTypeCollViewCell" forIndexPath:indexPath];
    cell.delegate = self;
    cell.showIndex = indexPath.item;
    cell.item = self.mainSource[indexPath.item];
    return cell;
    
}

#pragma mark —————————————————————————————————————— AWChooseTypeCollViewCellDelegate
- (void)aWChooseTypeCollViewCellChooseTypeClickBlockItemModel:(AWChooseTypeModel *)item
                                              withChooseIndex:(NSInteger)index{
    
    if (item.isChoose) {
        item.isChoose = NO;
        [self.chooseSource removeObject:item];
    }else{
        item.isChoose = YES;
        [self.chooseSource addObject:item];
    }
    [self.mainSource replaceObjectAtIndex:index withObject:item];
    [self.mainCollection reloadData];
    
    
    if ([self getUserChooseOther]) {
        
        self.otherHeight.constant = 128.0f;
        self.btn_topHeight.constant = 15.0f;
        float height = NorViewHeight+self.mainSource.count/3.0*40 + self.otherHeight.constant;
        if (self.mainSource.count %3 != 0) {
            height = NorViewHeight+(self.mainSource.count/3.0+1)*40 + self.otherHeight.constant - 15;
        }
        self.otherView.alpha = 1.0f;
        self.backView.frame = CGRectMake(0, 0, SCREEN_WIDTH, height);
        
    }else{
        
        self.otherHeight.constant = 0.0f;
        self.btn_topHeight.constant = 0.0f;
        float height = NorViewHeight+self.mainSource.count/3.0*40;
        if (self.mainSource.count %3 != 0) {
            height = NorViewHeight+(self.mainSource.count/3.0+1)*40-15;
        }
        self.otherView.alpha = 0.0f;
        self.backView.frame = CGRectMake(0, 0, SCREEN_WIDTH, height);
        
    }
    self.backView.center = self.center;
    
    
}

#pragma mark ————————————————————————————- 关闭
- (IBAction)closeViewClick:(UIButton *)sender {

    [self removeFromSuperview];
    
}

#pragma mark ————————————————————————————- 获取用户选择
- (IBAction)trueGetUserChooseClick:(UIButton *)sender {

    if ([self getUserChooseOther]) {
        
        if (self.tf_content.text.length == 0) {
            NSLog(@"==== 请输入其他描述");
            return;
        }
        if (self.showBlock) {
            
            NSMutableArray *backList = [NSMutableArray arrayWithCapacity:0];
            for (AWChooseTypeModel *tmpItem in self.chooseSource) {
                if (![tmpItem.name isEqualToString:@"其他"]) {
                    [backList addObject:tmpItem];
                }
            }
            
            self.showBlock([self getUserChooseOther], backList,self.tf_content.text);
        }
        
    }else{
        
        if (self.showBlock) {
            self.showBlock([self getUserChooseOther], self.chooseSource,self.tf_content.text);
        }
        
    }
    
    [self removeFromSuperview];
    
}

- (void)setShowTitle:(NSString *)showTitle{
    
    _showTitle = showTitle;
    if (!showTitle) {
        showTitle = @"请设置一个标题用于显示";
    }
    self.lab_title.text = showTitle;
    
}

- (void)setOtherTitle:(NSString *)otherTitle{
    
    _otherTitle = otherTitle;
    if (!otherTitle) {
        otherTitle = @"请设置一个其他标题用于显示";
    }
    self.lab_otherTitle.text = otherTitle;
    
}

- (void)setShowPlaceHolder:(NSString *)showPlaceHolder{
    
    _showPlaceHolder = showPlaceHolder;
    if (!showPlaceHolder) {
        showPlaceHolder = @"请输入内容";
    }
    self.tf_content.placeholder = showPlaceHolder;
    
}

/**
 获取用户是否点击了其他
 */
- (BOOL)getUserChooseOther{
    
    BOOL isHaveOther = NO;
    for (AWChooseTypeModel *tmpItem in self.chooseSource) {
        
        if ([tmpItem.name isEqualToString:@"其他"]) {
            isHaveOther = YES;
            break;
        }
        
    }
    return isHaveOther;
    
}

/**
 用于处理展示的model
 */
- (void)setMainSource:(NSMutableArray *)mainSource{
    
//    _mainSource = mainSource;
    _mainSource = [NSMutableArray arrayWithCapacity:0];
    for (NSString *name in mainSource) {
        
        AWChooseTypeModel *item = [AWChooseTypeModel new];
        item.name = name;
        [_mainSource addObject:item];
        
    }
    
    [self.mainCollection reloadData];
    
}

+ (void)showViewData:(NSMutableArray *)listData
           withTitle:(NSString *)title
      withOtherTitle:(NSString *)otherTitle
     withPlaceHolder:(NSString *)placeHolder
       withBackBlock:(AWBlackChooseData)block{
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    AWChooseDefactsView *chooseView = [AWChooseDefactsView creatViewWithData:listData
                                                               withShowTitle:title
                                                              withOtherTitle:otherTitle
                                                         withShowPlaceHolder:placeHolder
                                                                   withBlock:block];
    chooseView.mainSource = listData;
    [window addSubview:chooseView];
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
