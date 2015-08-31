//
//  MCEmptyView.m
//  ExchangeRate
//
//  Created by 常峻玮 on 15/8/31.
//  Copyright (c) 2015年 MingleChang. All rights reserved.
//

#import "MCEmptyView.h"
#import "MCSentence.h"
@interface MCEmptyView()
@property(nonatomic,strong)IBOutlet UILabel *detailLabel;
@property(nonatomic,strong)IBOutlet UILabel *nameLabel;
@end
@implementation MCEmptyView

-(void)resetLabelText{
    NSString *lPath=[[NSBundle mainBundle]pathForResource:@"Sentences" ofType:@"json"];
    NSData *lData=[NSData dataWithContentsOfFile:lPath];
    NSArray *lArray=[NSJSONSerialization JSONObjectWithData:lData options:NSJSONReadingAllowFragments error:nil];
    NSInteger index=arc4random()%lArray.count;
    NSDictionary *lDic=[lArray objectAtIndex:index];
    MCSentence *lSentence=[[MCSentence alloc]initWithDic:lDic];
    self.nameLabel.text=lSentence.showName;
    self.detailLabel.text=lSentence.detail;
}
-(void)show{
    [self resetLabelText];
    self.hidden=NO;
}
-(void)hide{
    self.hidden=YES;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
