require_relative "rectangle.rb"

class RectangleUtil
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

	def contains(rect_a, rect_b) 
		return (rect_b.location.x.between?(rect_a.location.x, rect_a.location.x + rect_a.width) and
				rect_b.location.y.between?(rect_a.location.y, rect_a.location.y + rect_a.height) and
				rect_b.location.x + rect_b.width <= rect_a.location.x + rect_a.width and
				rect_b.location.y + rect_b.height <= rect_a.location.y + rect_a.height)
	end

	private

	def dot(a, b)
		return (a.x * b.x) + (a.y * b.y)
	end

	def cross(a, b) 
		return a.x * b.y - a.y * b.x
	end

	def add(a, b) 
		return Point.new(a.x + b.x, a.y + b.y)
	end

	def subtract(a, b) 
		return Point.new(a.x - b.x, a.y - b.y)
	end

	def multiply(a, r)
		return Point.new((a.x * r).to_i, (a.y * r).to_i)
	end

	def split_into_lines(rect) 
		bottom_right = Point.new(rect.location.x + rect.width, rect.location.y)
		top_right = Point.new(rect.location.x + rect.width, rect.location.y + rect.height)
		top_left = Point.new(rect.location.x, rect.location.y + rect.height)

		return [[rect.location, top_left],
				[rect.location, bottom_right],
				[top_left, top_right],
				[bottom_right, top_right]]
	end

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
end