//
//  MarvelApi.h
//  YTKNetworkDemo
//
//  Created by 1 on 2019/2/2.
//  Copyright © 2019 yuantiku.com. All rights reserved.
//

#import "YTKRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface MarvelApi : YTKRequest


- (id)initWithCharacterId:(NSInteger)characterId;

@end

NS_ASSUME_NONNULL_END
