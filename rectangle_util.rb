require_relative "rectangle.rb"

class RectangleUtil

	# Finds all points where two rectangles have intersecting edges
  	#
  	# ==== Parameters
 	#
 	# * +rect_a+ - the first rectangle
 	# * +rect_b+ - the second rectangle
	def intersect(rect_a, rect_b)
		ret = []

		split_into_lines(rect_a).each do |a_line|
			split_into_lines(rect_b).each do |b_line|
				intersection = line_intersect(a_line, b_line)
				ret.push intersection if intersection
			end
		end

		return ret
	end

	# Returns true if rect_b is contained in rect_a
  	#
  	# ==== Parameters
 	#
 	# * +rect_a+ - the first rectangle
 	# * +rect_b+ - the second rectangle
	def contains(rect_a, rect_b) 
		return (rect_b.location.x.between?(rect_a.location.x, rect_a.location.x + rect_a.width) and
				rect_b.location.y.between?(rect_a.location.y, rect_a.location.y + rect_a.height) and
				rect_b.location.x + rect_b.width <= rect_a.location.x + rect_a.width and
				rect_b.location.y + rect_b.height <= rect_a.location.y + rect_a.height)
	end

	# Returns true if rect_a is adjacent to rect_b
  	#
  	# ==== Parameters
 	#
 	# * +rect_a+ - the first rectangle
 	# * +rect_b+ - the second rectangle
	def adjacent(rect_a, rect_b)
		split_into_lines(rect_a).each do |a_line|
			split_into_lines(rect_b).each do |b_line|
				adjacency = line_adjacent(a_line, b_line)
				return true if adjacency
			end
		end

		return false
	end

	private

	# The dot product of two points (treating them as vectors)
  	#
  	# ==== Parameters
 	#
 	# * +a+ - point a
 	# * +b+ - point b 
	def dot(a, b)
		return (a.x * b.x) + (a.y * b.y)
	end

	# The cross product of two points (treating them as vectors)
  	#
  	# ==== Parameters
 	#
 	# * +a+ - point a
 	# * +b+ - point b 
	def cross(a, b) 
		return a.x * b.y - a.y * b.x
	end

	# The addition of two points (treating them as vectors)
  	#
  	# ==== Parameters
 	#
 	# * +a+ - point a
 	# * +b+ - point b 
	def add(a, b) 
		return Point.new(a.x + b.x, a.y + b.y)
	end

	# The subtraction of two points (treating them as vectors)
  	#
  	# ==== Parameters
 	#
 	# * +a+ - point a
 	# * +b+ - point b 
	def subtract(a, b) 
		return Point.new(a.x - b.x, a.y - b.y)
	end

	# The scalar multiple of a point a by scalar r
  	#
  	# ==== Parameters
 	#
 	# * +a+ - point a
 	# * +r+ - scalar r
	def multiply(a, r)
		return Point.new((a.x * r).to_i, (a.y * r).to_i)
	end

	# Splits a rectangle into it's corresponding line segments, a segment being an array
  	#   [point1, point2] representing the segment between those two points. 
  	#    This will return an array of four segments for each side of the rectangle
  	#
  	# ==== Parameters
 	#
 	# * +rect+ - the rectangle to split into segments
	def split_into_lines(rect) 
		bottom_right = Point.new(rect.location.x + rect.width, rect.location.y)
		top_right = Point.new(rect.location.x + rect.width, rect.location.y + rect.height)
		top_left = Point.new(rect.location.x, rect.location.y + rect.height)

		return [[rect.location, top_left],
				[rect.location, bottom_right],
				[top_left, top_right],
				[bottom_right, top_right]]
	end

	# Returns the point at which the lines intersect, or nil if they do not intersect
  	#
  	# ==== Parameters
 	#
 	# * +a_line+ - the first line
 	# * +b_line+ - the second line
	def line_intersect(a_line, b_line) 
		# see http://stackoverflow.com/questions/563198/how-do-you-detect-where-two-line-segments-intersect
		q = a_line[0]
		p = b_line[0]
		s = subtract(a_line[1], a_line[0])
		r = subtract(b_line[1], b_line[0])

		# The lines are parallel or colinear, either way we didn't find an intersection. 
		return nil if cross(r,s) == 0

		q_sub_p = subtract(q, p)

		t = cross(q_sub_p, s).to_f / cross(r, s)
		u = cross(q_sub_p, r).to_f / cross(r, s)

		# The lines are perpendicular but don't intersect
		# We also only want to include intersections midway through lines, not on the ends
		#    (on the ends implies they're adjacent, not intersecting)
		return nil if (t <= 0 || t >= 1) || (u <= 0 || u >= 1)

		return add(p, multiply(r,t))
	end

	# Returns true if the two lines passed in are adjacent
  	#
  	# ==== Parameters
 	#
 	# * +a_line+ - the first line
 	# * +b_line+ - the second line
	def line_adjacent(a_line, b_line) 
		# see http://stackoverflow.com/questions/563198/how-do-you-detect-where-two-line-segments-intersect
		q = a_line[0]
		p = b_line[0]
		s = subtract(a_line[1], a_line[0])
		r = subtract(b_line[1], b_line[0])

		# The lines must be parallel or colinear
		return nil unless cross(r,s) == 0 and cross(subtract(q,p), r) == 0 

		t_0 = dot(subtract(q, p), r) / dot(r, r)
		t_1 = dot(subtract(add(q, s), p), r) / dot(r, r)

		if dot(s, r) < 0
			return ((t_1..t_0).cover?(0) and (t_1..t_0).cover?(1))
		else
			return ((t_0..t_1).cover?(0) and (t_0..t_1).cover?(1))
		end
	end
end