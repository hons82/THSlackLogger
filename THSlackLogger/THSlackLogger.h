//
//  THSlackLogger.h
//  Pods
//
//  Created by Hannes Tribus on 12/02/16.
//
//

#import <CocoaLumberjack/CocoaLumberjack.h>

@interface THSlackLogger : DDAbstractLogger <DDLogger>

/**
 * Initialize THSlackLogger. 
 * Call this method within your App Delegate's `application:didFinishLaunchingWithOptions:` and provide the slack incoming webhook url
 *
 * @param webhookURL the incoming webhook url from your Slack
 *
 * @return Returns the shared instance. In most cases this can be ignored.
 */
+ (instancetype)initWithWebhookURL:(NSURL *)webhookURL;

/**
 *  Singleton method
 *
 *  @return the shared instance
 */
+ (instancetype)sharedInstance;

/**
 *  Post notification to Slack Channel or a Direct Message to someone
 *
 *  @param channel   channel name or user id. example: #general or @61
 *  @param text      (required) notification content
 *  @param username  displayed name
 *  @param iconURL   bot icon url
 *  @param iconEmoji bot icon emoji
 *  @param progress  progress callback
 *  @param success   success callback
 *  @param failure   failure callback
 */
- (void)postNotificationToChannel:(NSString *)channel
                             text:(NSString *)text
                         username:(NSString *)username
                          iconURL:(NSURL *)iconURL
                        iconEmoji:(NSString *)iconEmoji
                         progress:(void (^)(NSProgress *progress))progress
                          success:(void (^)())success
                          failure:(void (^)(NSError *error))failure;

@end
