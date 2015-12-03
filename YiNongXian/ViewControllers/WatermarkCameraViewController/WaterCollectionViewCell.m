//
//  WaterCollectionViewCell.m
//  YiNongXian
//
//  Created by 索金铭 on 15/12/2.
//  Copyright © 2015年 bxlt. All rights reserved.
//

#import "WaterCollectionViewCell.h"

@implementation WaterCollectionViewCell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"WaterCollectionViewCell" owner:self options:nil];
        
        if ([[arrayOfViews objectAtIndex:0] isKindOfClass:[UICollectionViewCell class]])
        {
            self = [arrayOfViews objectAtIndex:0];
            
            return self;
        }
    }
    return nil;
    
}
- (void)awakeFromNib {
    // Initialization code
}

@end
