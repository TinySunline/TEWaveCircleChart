//
//  TEWaveCircleChart.m
//  Pods
//
//  Created by kingdomrain on 2017/2/15.
//
//

#import "TEWaveCircleChart.h"
#import <UIKit/UIKit.h>
#define LINE 4

@interface TEWaveCircleChart()
{
    float _currentLinePointY;
    float a;
    float b;
    float num;
    BOOL jia;
    float t1;
    float t2;
}
@property (nonatomic,strong)UILabel *now;
@property (nonatomic,strong)UILabel *min;
@property (nonatomic,strong)UILabel *totle;

@end

@implementation TEWaveCircleChart

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)init {
    if (self = [super init]) {
        [self initFunc];
    }
    return self;
}

//初始值设置
-(void)initFunc
{
    [self setBackgroundColor:[UIColor clearColor]];
    self.layer.cornerRadius =self.frame.size.width/2;
    self.layer.backgroundColor = [UIColor whiteColor].CGColor;
    self.layer.masksToBounds = YES;
    a = 1.5;
    b = 0;
    num = 1.00;
    jia = NO;
    _percentum = 0.5;
    _currentWaterColor = [UIColor colorWithRed:38/255.0f green:207/255.0f blue:170/255.0f alpha:1];
    [NSTimer scheduledTimerWithTimeInterval:0.06 target:self selector:@selector(animateWave) userInfo:nil repeats:YES];
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(40, 50, 120, 25)];
//    label.text = @"当前可购";
//    label.textColor = [UIColor grayColor];
//    label.textAlignment = NSTextAlignmentCenter;
//    label.font = [UIFont systemFontOfSize:14];
//    label.textColor = [UIColor grayColor];
//    
//    [self addSubview:label];
//    _now= [[UILabel alloc] initWithFrame:CGRectMake(40, 70, 73, 30)];
//    _now.text = @"3.5";
//    _now.textColor=[UIColor orangeColor];
//    _now.textAlignment = NSTextAlignmentRight;
//    _now.font = [UIFont systemFontOfSize:33];
//    [self addSubview:_now];
//    
//    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(113, 73, 47, 30)];
//    label2.text = @"万元";
//    label2.textColor=[UIColor blackColor];
//    label2.font = [UIFont systemFontOfSize:18];
//    [self addSubview:label2];
//    
//    _min = [[UILabel alloc] initWithFrame:CGRectMake(40, 105, 120, 20)];
//    _min.text = @"100起购";
//    _min.textColor=[UIColor lightGrayColor];
//    _min.textAlignment = NSTextAlignmentCenter;
//    _min.font = [UIFont systemFontOfSize:13];
//    [self addSubview: _min];
//    
//    _totle = [[UILabel alloc] initWithFrame:CGRectMake(40, 120, 120, 25)];
//    _totle.text = @"融资250万元";
//    _totle.textAlignment = NSTextAlignmentCenter;
//    _totle.textColor=[UIColor lightGrayColor];
//    _totle.font = [UIFont systemFontOfSize:13];
//    [self addSubview: _totle];
}



-(void)setParam:(NSString *)name :(id)value
{
//    [super setParam:name value:value];
    if ([name isEqualToString:@"totle"]) {
        _totle.text = [NSString stringWithFormat:@"融资%@万元",value];
        t1 = [value floatValue];
    }
    if ([name isEqualToString:@"min"]) {
        _min.text = [NSString stringWithFormat:@"%@元起购",value];
        NSLog(@"%@",value);
        
    }
    if ([name isEqualToString:@"now"]) {
        
        if (((NSString*)value).length > 3) {
            _now.text = [NSString stringWithFormat:@"%@",value];
            _now.font = [UIFont systemFontOfSize:20];
            UILabel *label = [self  viewWithTag:101];
            label.frame =CGRectMake(113, 70, 47, 30);
            label.font = [UIFont systemFontOfSize:14];
        }else{
            _now.text = [NSString stringWithFormat:@"%@",value];
            
        }
        t2 = [value floatValue];
    }
    [self setNeedsDisplay];
}

-(void)animateWave
{
    if (jia) {
        a += 0.01;
    }else{
        a -= 0.01;
    }
    if (a<=1) {
        jia = YES;
    }
    
    if (a>=1.5) {
        jia = NO;
    }
    b+=0.1;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect{
    _currentLinePointY = self.frame.size.height * (t2/t1);
    if (num *self.frame.size.height > _currentLinePointY) {
        num = num - 0.01;
    }
    
    CGContextRef context1 = UIGraphicsGetCurrentContext();
    CGMutablePathRef path1 = CGPathCreateMutable();
    //画水
    CGContextSetStrokeColorWithColor(context1, [UIColor redColor].CGColor);
    CGContextSetLineWidth(context1, 2);
    UIColor * t = [UIColor colorWithRed:153/255.0f green:222/255.0f blue:195/255.0f alpha:1];
    CGContextSetFillColorWithColor(context1, [t CGColor]);
    float y=_currentLinePointY;
    CGPathMoveToPoint(path1, NULL, 0, y);
    for(float x=0;x<=self.frame.size.width;x++){
        y= 2*a * cos( x/180*M_PI + 4*b/M_PI ) * 5 + num*self.frame.size.height;
        CGPathAddLineToPoint(path1, nil, x, y);
    }
    
    CGPathAddLineToPoint(path1, nil, self.frame.size.width, rect.size.height);
    CGPathAddLineToPoint(path1, nil, 0, rect.size.height);
    
    CGPathAddLineToPoint(path1, nil, 0, num*self.frame.size.height);
    
    CGContextAddPath(context1, path1);
    CGContextFillPath(context1);
    CGContextDrawPath(context1, kCGPathStroke);
    CGPathRelease(path1);
    
    //
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGMutablePathRef path = CGPathCreateMutable();
    CGContextSetLineWidth(context, 2);
    CGContextSetFillColorWithColor(context, [_currentWaterColor CGColor]);
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    
    CGPathMoveToPoint(path, NULL, 0, num * rect.size.height);
    for(float x=0;x<=self.frame.size.width;x++){
        y= 2*a * sin( x/180*M_PI + 4*b/M_PI ) * 5 +num *self.frame.size.height;
        CGPathAddLineToPoint(path, nil, x, y);
    }
    
    CGPathAddLineToPoint(path, nil, self.frame.size.width,self.frame.size.height);
    CGPathAddLineToPoint(path, nil, 0, self.frame.size.height);
    CGPathAddLineToPoint(path, nil, 0, num*self.frame.size.height);
    CGContextAddPath(context, path);
    CGContextFillPath(context);
    CGContextDrawPath(context, kCGPathStroke);
    CGPathRelease(path);
    
    CGContextRef context3 = UIGraphicsGetCurrentContext();//一个不透明类型的Quartz 2D绘画环境,相当于一个画布,你可以在上面任意绘画
    
    CGContextSetRGBFillColor(context3, 1, 0, 0, 1.0);//填充颜色
    
    CGContextSetRGBStrokeColor(context3, 236.0/255.0, 236.0/255.0, 236.0/255.0, 1.0);//画线笔的颜色
    
    CGContextSetLineWidth(context3, 8.0);//线的宽度
    
    CGContextAddArc(context3, self.frame.size.height/2, self.frame.size.height/2, self.frame.size.height/2, 0, 2 * M_PI, 0);//添加一个圆，x,y为圆点坐标，radius半径，startAngle为开始的弧度，endAngle为 结束的弧度，clockwise 0为顺时针，1为逆时针。
    
    CGContextDrawPath(context3, kCGPathStroke);
    
    CGContextRef context4 = UIGraphicsGetCurrentContext();//一个不透明类型的Quartz 2D绘画环境,相当于一个画布,你可以在上面任意绘画
    CGContextDrawPath(context4, kCGPathFill);
    
    
    CGContextSetRGBStrokeColor(context4, 236.0/255.0, 236.0/255.0, 236.0/255.0, 1.0);//画线笔的颜色
    
    CGContextSetLineWidth(context4, 2.0);//线的宽度
    float num =  self.frame.size.height/2 - 40;
    
    CGContextAddArc(context4, self.frame.size.height/2, self.frame.size.height/2, num, 0, 2 * M_PI, 0);//添加一个圆，x,y为圆点坐标，radius半径，startAngle为开始的弧度，endAngle为 结束的弧度，clockwise 0为顺时针，1为逆时针。
    CGContextSetFillColorWithColor(context4, [UIColor whiteColor].CGColor);
    // CGContextDrawPath(context4, kCGPathFill);//绘制填充
    CGContextDrawPath(context4, kCGPathEOFillStroke);
}



@end
