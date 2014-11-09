Sample-UISearchController Read Me
=================================

This example demonstrates the use of the UISearchController class, introduced in iOS 8.

The project is based on the 'TableSearch' sample code from Apple.  The original example used UISearchDisplayController which is deprecated in iOS 8.

Each tab uses a UISearchController to display search results in a different way:
- In a table view, very similar to using UISearchDisplayController

- In a collection view

- In place, essentially filtering the original table view

**Known Issues**

- The TableSearch sample project used a UISearchBar and UISearchDisplayController, configured in the storyboard. It does not appear that UISearchController can be configured in Interface Builder at the moment. Therefore, it is created and configured in code in each example. rdar://17563885

- The search results controller of the UISearchController does not seem to receive all of the appropriate view controller method calls. rdar://17566947

- The UISearchBar returned by UISearchController has a size of 0 x 0. The height needs to be set manually, otherwise the search bar will not be visible.  Note this is when using the search bar without scope buttons. rdar://17315477

*Version 2.0*  
*November 9, 2014*

Updated for Xcode 6.1, iOS 8.1 SDK.

Added a tab controller, to show three different UISearchController examples.


*Version 1.0*  
*July 5, 2014*

This project was created with Xcode 6, Beta 2.

The initial version is essentially the original sample project, redone from scratch as an iOS 8 project, with as few changes in implementation as possible from the original sample project.

*Version 1.0 Notes:*
- There is a build warning that the scrollable content size of the table view has ambiguous constraints. Choosing to 'Add Missing Constraints' in Interface Builder has no effect, and so this warning remains. 


