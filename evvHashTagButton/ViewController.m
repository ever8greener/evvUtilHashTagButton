//
//  ViewController.m
//  evvHashTagButton
//
//  Created by artist on 8/15/16.
//  Copyright © 2016 EddieKwon. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *hashContainView;

@end

/*
 
 note:
 
    1.Not support AUTO LAYOUT.
    2.Not support auto rotation case.
 
 */
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray* hashTags = @[@"Love",@"Hatred",@"Life",@"Michael Jackson",@"Human",@"Like",@"Pink lol",@"Kpop star",@"Pretty",@"hama",@"California state",@"halo",@"psy",@"펑크락"];
   
    CGFloat boxLimitXPos = _hashContainView.bounds.size.width;
    
    [hashTags enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSString *aHash = [NSString stringWithFormat:@"#%@", obj];
        
        static CGFloat curX = 0 , curY=5;
        CGFloat pad = 5;
        CGFloat startPoint  = idx * 60.0;
        CGFloat btnWidth   = [self calcButtonSize:aHash].width;
        CGFloat btnHeight   = [self calcButtonSize:aHash].height;
        
        CGFloat endXPoint = curX + pad + btnWidth ; // 맨 우측 X (right edge x pos of tag view)

        if (endXPoint > boxLimitXPos ) {
            curX = 0;
            curY = curY + pad + btnHeight;          // NEXT LINE.
        }
        
        UIButton *aButton =  [[UIButton alloc]initWithFrame:CGRectMake(curX + pad , curY, btnWidth, btnHeight)];
        NSLog(@"curx:%f",curX);
        
        
        [aButton setTitle:aHash forState:UIControlStateNormal];
        [aButton setBackgroundColor:[UIColor yellowColor]];
        [aButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [aButton addTarget:self action:@selector(actionHashTapped:) forControlEvents:UIControlEventTouchUpInside];
        
        [_hashContainView addSubview:aButton];
        
        curX = curX + btnWidth + pad ; //for next button X axis
        
        if (idx == hashTags.count -1 ) {
            
            _hashContainView.frame   = CGRectMake(20, 100, boxLimitXPos, curY+btnHeight+pad);
            
            //container's height varies depend on the number of tag strings.
            //세로크기는 태그의 개수에 따라서 가변적 임.
        }
    }];
    
    
}

-(CGSize)calcButtonSize:(NSString*)aText{
    
    CGSize constraint = CGSizeMake(300,NSUIntegerMax);
    
    UIFont *font = [UIFont fontWithName:@"Helvetica-BoldOblique" size:21];
    NSDictionary *attributes = @{NSFontAttributeName: font};
    
    CGRect rect = [aText boundingRectWithSize:constraint
        options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
        attributes:attributes
        context:nil];
    
    return rect.size;
    
}

-(void)actionHashTapped:(UIButton *)sender{
    
    NSLog(@"%@ tapped",sender.titleLabel.text);
    
}


@end
