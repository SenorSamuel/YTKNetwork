//
//  ViewController.m
//  YTKNetworkDemo
//
//  Created by Chenyu Lan on 10/28/14.
//  Copyright (c) 2014 yuantiku.com. All rights reserved.
//

#import "ViewController.h"
#import "YTKBatchRequest.h"
#import "YTKChainRequest.h"
#import "GetImageApi.h"
#import "GetUserInfoApi.h"
#import "RegisterApi.h"
#import "YTKBaseRequest+AnimatingAccessory.h"
#import "MarvelApi.h"

@interface ViewController ()<YTKChainRequestDelegate,YTKRequestDelegate>

@end

@implementation ViewController

/// Send batch request
- (void)sendBatchRequest {
    GetImageApi *a = [[GetImageApi alloc] initWithImageId:@"1.jpg"];
    GetImageApi *b = [[GetImageApi alloc] initWithImageId:@"2.jpg"];
    GetImageApi *c = [[GetImageApi alloc] initWithImageId:@"3.jpg"];
    GetUserInfoApi *d = [[GetUserInfoApi alloc] initWithUserId:@"123"];
    YTKBatchRequest *batchRequest = [[YTKBatchRequest alloc] initWithRequestArray:@[a, b, c, d]];
    [batchRequest startWithCompletionBlockWithSuccess:^(YTKBatchRequest *batchRequest) {
        NSLog(@"succeed");
        NSArray *requests = batchRequest.requestArray;
        GetImageApi *a = (GetImageApi *)requests[0];
        GetImageApi *b = (GetImageApi *)requests[1];
        GetImageApi *c = (GetImageApi *)requests[2];
        GetUserInfoApi *user = (GetUserInfoApi *)requests[3];
        // deal with requests result ...
        NSLog(@"%@, %@, %@, %@", a, b, c, user);
    } failure:^(YTKBatchRequest *batchRequest) {
        NSLog(@"failed");
    }];
}

- (void)sendChainRequest {
    RegisterApi *reg = [[RegisterApi alloc] initWithUsername:@"username" password:@"password"];
    YTKChainRequest *chainReq = [[YTKChainRequest alloc] init];
    [chainReq addRequest:reg callback:^(YTKChainRequest *chainRequest, YTKBaseRequest *baseRequest) {
        RegisterApi *result = (RegisterApi *)baseRequest;
        NSString *userId = [result userId];
        GetUserInfoApi *api = [[GetUserInfoApi alloc] initWithUserId:userId];
        [chainRequest addRequest:api callback:nil];
        
    }];
    chainReq.delegate = self;
    // start to send request
    [chainReq start];
}

- (void)chainRequestFinished:(YTKChainRequest *)chainRequest {
    // all requests are done
    
}

- (void)chainRequestFailed:(YTKChainRequest *)chainRequest failedBaseRequest:(YTKBaseRequest*)request {
    // some one of request is failed
}

- (void)loadCacheData {
    NSString *userId = @"1";
    GetUserInfoApi *api = [[GetUserInfoApi alloc] initWithUserId:userId];
    if ([api loadCacheWithError:nil]) {
        NSDictionary *json = [api responseJSONObject];
        NSLog(@"json = %@", json);
        // show cached data
    }

    api.animatingText = @"正在加载";
    api.animatingView = self.view;

    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        NSLog(@"update ui");
    } failure:^(YTKBaseRequest *request) {
        NSLog(@"failed");
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self sendMarvelRequest];

}

-(void)sendMarvelRequest{
    
    MarvelApi *marvelApi = [[MarvelApi alloc]initWithCharacterId:1011334];
    marvelApi.animatingText = @"正在加载";
    marvelApi.animatingView = self.view;
    marvelApi.delegate = self;
    [marvelApi start];
}

- (void)requestFinished:(__kindof YTKBaseRequest *)request{
    NSLog(@"请求成功%@",request.responseString);
}

///  Tell the delegate that the request has failed.
///
///  @param request The corresponding request.
- (void)requestFailed:(__kindof YTKBaseRequest *)request{
    NSLog(@"请求失败%@",request);
}





@end
