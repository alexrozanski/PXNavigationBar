PXNavigationBar
===============

An iTunes-style navigation bar for Mac OS X 10.5 or above, created by Alex Rozanski.

`PXNavigationBar` is licensed under the New BSD License

What is this?
-------------

PXNavigationBar is a control used for navigating through hierarchical content, and is modelled on the iTunes navigation bar, as seen below:

![iTunes navigation bar][1]

(The screenshot was taken from the podcasts window in iTunes)

As you can see, the control is comprised of three parts: the title of the current item in the center, a back button on the left, and two navigation buttons on the right.

How the control works
---------------------

`PXNavigationBar` works as follows:

- Each level in the navigation hierarchy is represented by a `PXNavigationLevel` instance.
- Each `PXNavigationLevel` instance holds an array of `PXNavigationItem`s which represent individual items in that level.
- `PXNavigationLevel`s are pushed and popped off the navigation bar's stack when needed to be.
- Each navigation level has a pointer to the "currently selected" navigation item; this is the item which is displayed by the navigation bar.
- Pressing the back button pops the current navigation level off the stack
- Pressing the left or right navigation buttons navigates either left or right in the array of items in the currently displayed level.

Using the code
--------------

There are only a few steps involved.

 1. Download the source, and copy the following files into your Xcode project:
- `PXNavigationBar.h` and `PXNavigationBar.m`
- `PXNavigationLevel.h` and `PXNavigationLevel.m`
- `PXNavigationItem.h` and `PXNavigationItem.m`
- `PXBackButtonCell.h` and `PXBackButtonCell.m`
- `PXNavigationButtonCell.h` and `PXNavigationButtonCell.m`
- The images in the `Resources/images` directory

 2. To create the control in Interface Builder, drag a custom `NSView` object from the Library to your window/view. In the Identity Inspector change the class name from `NSView` to `PXNavigationBar`. The bar can take any width but ensure that the height is 28 pixels.
 3. Make sure to `#import "PXNavigationBar.h"` for files that require it (the other header files are imported from this main header), and ensure that the object which is the delegate for the navigation bar conforms to the `PXNavigationBarDelegate` protocol.

There is also an example project bundled with the source to see how the control is used.

Documentation
-------------

Documentation is available for `PXNavigationBar`, downloadable from the downloads page. Provided in the ZIP file is a folder containing HTML documentation, or a docset which can be opened in Xcode and which is then searchable from the Xcode Developer Documentation.

If you feel that any areas of the documentation are lacking or missing, please feel free to [let me know][2], which will be much appreciated.

Attribution
-----------

The documentation was created using [Doxygen][3] and [appledoc][4], thanks of which go to the developers of both.


  [1]: http://perspx.com/screenshots/PXNavigationBar/iTunes_NavigationBar.jpg
  [2]: http://perspx.com/contact
  [3]: http://www.doxygen.org/
  [4]: http://www.gentlebytes.com/freeware/appledoc/