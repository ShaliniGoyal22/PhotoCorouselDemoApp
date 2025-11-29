Approach I used for this problem statement

- I used a ZStack for the images so that the side images appear behind the focused (center) image.

- To position the images correctly, I calculated the x-offset to make the side images partially visible.

- I applied a scaleEffect to enlarge the focused image without changing its actual dimensions.

- For moving between images, I implemented a DragGesture to detect user interaction and determine which image should come into focus.

- I created a custom page control using circles, allowing it to be easily modified based on the requirements.

- Currently, I am using static images for the carousel.

- The focused index updates when the user lifts their finger after dragging.

- I have set the width and height dynamically based on the device’s screen width.

- Additional views can be added above or below the carousel using a VStack.
