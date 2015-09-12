## Apprenda Coding Challenge

#### Implementation

The interface is as follows:

To create a new rectangle with bottom left corner at point (0,0) with width 1 and height 2

    Rectangle.new(Point.new(0,0), 1, 2)

To see where two rectangles intersect:
	
	rect_a = Rectangle.new(Point.new(0,0), 3, 3)
	rect_b = Rectangle.new(Point.new(-1, 1), 2, 1)

	RectangleUtil.new.intersect(rect_a, rect_b)

Similarly, to see if two rectangles are adjacent: 

	RectangleUtil.new.adjacent(rect_a, rect_b)

And to see if rectangle A contains rectangle B:

    RectangleUtil.new.contains(rect_a, rect_b)

More specific implementation details, assumptions about what constitutes intersections, adjacency, and containment can be found in the unit tests. 
    
#### Testing

To run the rspec unit tests:
	
    bundle install
    bundle exec rspec

These tests should cover a sufficent amount of edge cases to see that the utility is functioning to spec. 