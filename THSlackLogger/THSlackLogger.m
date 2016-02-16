//
//  THSlackLogger.m
//  Pods
//
//  Created by Hannes Tribus on 12/02/16.
//
//

#import "THSlackLogger.h"
#import <AFNetworking/AFHTTPSessionManager.h>
#import <AFNetworking/AFURLRequestSerialization.h>

#define kSlackPlistFilename @"Slack"
#define kSlackwebhookURLKey @"webHookUrl"

@interface THSlackLogger ()

@property (nonatomic, strong) AFHTTPSessionManager *manager;
@property (nonatomic, strong) NSURL *webhookURL;
@property (nonatomic, strong) NSString *path;

@end

@implementation THSlackLogger

@synthesize webhookURL = _webhookURL;

+ (instancetype)initWithWebhookURL:(NSURL *)webhookURL {
    THSlackLogger *client = [THSlackLogger sharedInstance];
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        client.webhookURL = webhookURL;
    });
    
    return client;
}

+ (instancetype)sharedInstance {
    static THSlackLogger *_sharedClient = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _sharedClient = [[THSlackLogger alloc] init];
        [_sharedClient setWebhookURL:nil];
    });
    
    return _sharedClient;
}

- (NSURL *)webhookURL {
    if (!_webhookURL) {
        NSString *path = [[NSBundle mainBundle] pathForResource:kSlackPlistFilename ofType:@"plist"];
        NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
        _webhookURL = (dict ? [NSURL URLWithString:dict[kSlackwebhookURLKey]] : nil);
    }
    return _webhookURL;
}

- (void)setWebhookURL:(NSURL *)webhookURL {
    _webhookURL = webhookURL ? webhookURL : self.webhookURL;
    if (!_webhookURL) {
        return;
    }
    
    NSString *baseURLString = [NSString stringWithFormat:@"%@://%@", _webhookURL.scheme, _webhookURL.host];
    NSString *path = [[[_webhookURL pathComponents] componentsJoinedByString:@"/"] substringFromIndex:2];
    
    self.manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:baseURLString]];
    self.manager.requestSerializer = [AFJSONRequestSerializer serializer];
    self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    self.path = path;
}

- (void)postNotificationToChannel:(NSString *)channel
                             text:(NSString *)text
                         username:(NSString *)username
                          iconURL:(NSURL *)iconURL
                        iconEmoji:(NSString *)iconEmoji
progress:(void (^)(NSProgress *progress))progress
                          success:(void (^)())success
                          failure:(void (^)(NSError *error))failure {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    if (channel) {
        params[@"channel"] = channel;
    }
    if (!text) {
        return;
    }
    if (username) {
        params[@"username"] = username;
    }
    if (iconURL) {
        params[@"icon_url"] = iconURL.absoluteString;
    }
    if (iconEmoji) {
        params[@"icon_emoji"] = iconEmoji;
    }
    params[@"text"] = text;
    
    [self.manager POST:self.path parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) progress(uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) success();
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) failure(error);
    }];
}

// pragma mark - DDLogger

- (void)logMessage:(DDLogMessage *)logMessage {
    NSString *logMsg = logMessage.message;
    
    if (self->_logFormatter)
        logMsg = [self->_logFormatter formatLogMessage:logMessage];
    
    if (logMsg) {
        [self postNotificationToChannel:nil text:logMsg username:nil iconURL:nil iconEmoji:nil progress:nil success:nil failure:nil];
    }
}

@end
