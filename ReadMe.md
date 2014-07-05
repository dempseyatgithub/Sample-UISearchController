Sample-UISearchController Read Me
=================================

This example demonstrates the use of the UISearchController class, introduced in iOS 8.

The project is based on the 'TableSearch' sample code from Apple.  The original example used UISearchDisplayController which is deprecated in iOS 8.

**Version 1.0**
*July 5, 2014*

This project was created with Xcode 6, Beta 2.

The initial version is essentially the original sample project, redone from scratch as an iOS 8 project, with as few changes in implementation as possible from the original sample project.

*Version 1.0 Notes:*
- There is a build warning that the scrollable content size of the table view has ambiguous constraints. Choosing to 'Add Missing Constraints' in Interface Builder has no effect, and so this warning remains. 

- The TableSearch sample project used a UISearchBar and UISearchDisplayController, configured in the storyboard. It does not appear that UISearchController can be configured in the similar way in Interface Builder at the moment. Therefore, it is created and configured in code. rdar://17563885

- The search results controller of the UISearchController does not seem to receive all of the appropriate view controller method calls. rdar://17566947
