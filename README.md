# Usage:
1. Run `pod install`
2. Open `NordstromRack.xcworkspace`
3. Run the app. 

# Note: 
There is a bug in RxDataSources implementation that results in UITableViewAlertForLayoutOutsideViewHierarchy warning when running the app.<br />
According to Rx library maintainers the fix is implemented and merged, and will be released with version 6. <br />
Please follow the link below for more information about this bug. </br>
https://github.com/ReactiveX/RxSwift/pull/2076/commits/2f8b52017a6e7ef4b4be661070440411cb4d171c
