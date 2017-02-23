//
//  zhiHuObtainDataOperation.m
//  SwiftTest
//
//  Created by lianpeng on 2017/2/23.
//  Copyright © 2017年 xulianpeng. All rights reserved.
//

#import "zhiHuObtainDataOperation.h"

@implementation zhiHuObtainDataOperation

- (id)initWithUrl:(NSString *)url
{
    if (self = [super init]) {
        
        self.urlStr  = url;
    }
    return self;
}
- (void)main{
    if (self.cancelled) {
        return;
    }
    
    [self obtainData];

}
- (void)obtainData{
    
    
}
@end
