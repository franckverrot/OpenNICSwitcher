#include <SystemConfiguration/SystemConfiguration.h>

@interface DynamicStore : NSObject
+ (bool)switchDNS:(NSArray*)listOfAddresses;
+ (NSArray*)getDNS;
@end
