//-------------------网络状态
Reachability * hostReach;//网络状态
NetworkStatus netstatus;
BOOL isConnected;//判断是否已经连接


//----------------------------------------------

[[NSNotificationCenter defaultCenter] addObserver:self
                                         selector:@selector(reachabilityChanged:)
                                             name: kReachabilityChangedNotification
                                           object: nil];
 
 hostReach = [[Reachability reachabilityWithHostName:@"www.baidu.com"] retain];
 [hostReach startNotifier];

// --------------------------------------------------

 //启用网络监视
 -(void)reachabilityChanged:(NSNotification *)note{
     
     NSString * connectionKind = nil;
     
     Reachability * curReach = [note object];
     NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
     netstatus = [curReach currentReachabilityStatus];
     switch (netstatus) {
         case NotReachable:
             connectionKind = @"当前没有网络链接\n请检查你的网络设置";
             isConnected =NO;
             break;
             
         case ReachableViaWiFi:
             connectionKind = @"当前使用的网络类型是WIFI";
             isConnected =YES;
             break;
             
         case ReachableViaWWAN:
             connectionKind = @"您现在使用的是2G/3G网络\n可能会产生流量费用";
             isConnected =YES;
             break;
             
         default:
             break;
     }

 }
