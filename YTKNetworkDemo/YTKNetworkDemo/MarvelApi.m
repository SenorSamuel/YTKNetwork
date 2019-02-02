//
//  MarvelApi.m
//  YTKNetworkDemo
//
//  Created by 1 on 2019/2/2.
//  Copyright © 2019 yuantiku.com. All rights reserved.
//

#import "MarvelApi.h"

@implementation MarvelApi {
    NSInteger _characterId;
}

- (id)initWithCharacterId:(NSInteger)characterId {
    self = [super init];
    if (self) {
        _characterId = characterId;
    }
    return self;
}

- (NSString *)requestUrl {
    
    return [NSString stringWithFormat:@"/v1/public/characters/%@",@(_characterId)];;
}

//- (id)requestArgument {
//    return @{@"characterId": @(_characterId)};
//}

//- (id)jsonValidator {
//    return @{
//             @"nick": [NSString class],
//             @"level": [NSNumber class]
//             };
//}

//- (NSInteger)cacheTimeInSeconds {
//    return 60 * 3;
//}





@end
