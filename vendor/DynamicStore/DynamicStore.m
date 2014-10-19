#include "DynamicStore.h"

@implementation DynamicStore
+ (NSArray*)getDNS {
  NSMutableArray *ary = [NSMutableArray new];
  SCDynamicStoreRef ds = SCDynamicStoreCreate(NULL, CFSTR("DynamicStore.switchDNS"), NULL, NULL);

  CFArrayRef list = SCDynamicStoreCopyKeyList(ds,
      CFSTR("State:/Network/Global/DNS"));
      //CFSTR("State:/Network/(Service/.+|Global)/DNS"));

  CFIndex i = 0, j = CFArrayGetCount(list);

  while (i < j) {
    CFStringRef k = CFArrayGetValueAtIndex(list, i);
    NSDictionary * v = SCDynamicStoreCopyValue(ds, k);
    NSEnumerator *enumerator = [v keyEnumerator];
    id key;
    while((key = [enumerator nextObject])) {
        CFArrayRef s = [v objectForKey:key];
        ary = s;
    }
    i++;
  }
  return ary;
}
+ (bool)switchDNS:(NSArray*)listOfAddresses {
  CFIndex dns_addresses_count = (CFIndex)[listOfAddresses count];
  CFStringRef * dns_addresses = (CFStringRef*)malloc(dns_addresses_count * sizeof(CFStringRef));

  for(int x = 0; x < dns_addresses_count; ++x) {
    dns_addresses[x] = (__bridge CFStringRef)([listOfAddresses objectAtIndex:x]);
  }

  SCDynamicStoreRef ds = SCDynamicStoreCreate(NULL, CFSTR("DynamicStore_switchDNS"), NULL, NULL);

  CFArrayRef array = CFArrayCreate(NULL, (const void **) dns_addresses,
      dns_addresses_count, &kCFTypeArrayCallBacks);

  CFDictionaryRef dict = CFDictionaryCreate(NULL,
      (const void **) (CFStringRef []) { CFSTR("ServerAddresses") },
      (const void **) &array, 1, &kCFTypeDictionaryKeyCallBacks,
      &kCFTypeDictionaryValueCallBacks);

  CFArrayRef list = SCDynamicStoreCopyKeyList(ds,
      CFSTR("State:/Network/(Service/.+|Global)/DNS"));

  CFIndex i = 0, j = CFArrayGetCount(list);

  bool ret = TRUE;

  if (j <= 0) {
    ret = FALSE;
  } else {
    ret = TRUE;
    while (i < j) {
      ret &= SCDynamicStoreSetValue(ds, CFArrayGetValueAtIndex(list, i), dict);
      i++;
    }
  }
  return ret;
}
@end
