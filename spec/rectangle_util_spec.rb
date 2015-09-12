require_relative "../rectangle_util.rb"
require_relative "../rectangle.rb"
require 'pry'

describe ("intersect") do 
	util = RectangleUtil.new
	rectA = Rectangle.new(Point.new(0,0), 3, 3)

	context("single overlap") do

		it("takes left overlap") do
			rectB = Rectangle.new(Point.new(-1, 1), 2, 1)

			expect(util.intersect(rectA,rectB)).to eq [Point.new(0,1), Point.new(0,2)]
		end

		it("takes right overlap") do
			rectB = Rectangle.new(Point.new(2, 1), 2, 1)

			expect(util.intersect(rectA,rectB)).to eq [Point.new(3,1), Point.new(3,2)]
		end

		it("takes bottom overlap") do
			rectB = Rectangle.new(Point.new(1, -1), 1, 2)

			expect(util.intersect(rectA,rectB)).to eq [Point.new(1,0), Point.new(2,0)]
		end

		it("takes top overlap") do
			rectB = Rectangle.new(Point.new(1, 2), 1, 2)

			expect(util.intersect(rectA,rectB)).to eq [Point.new(1,3), Point.new(2,3)]
		end
	end

	context("double overlap") do
		it("takes left top overlap") do
			rectB = Rectangle.new(Point.new(-1, 1), 2, 3)

			result = util.intersect(rectA,rectB)
			expect(result).to include(Point.new(0,1))
			expect(result).to include(Point.new(1,3))
		end

		it("takes left bottom overlap") do
			rectB = Rectangle.new(Point.new(-1, -1), 2, 3)

			result = util.intersect(rectA,rectB)
			expect(result).to include(Point.new(0,2))
			expect(result).to include(Point.new(1,0))
		end

		it("takes right top overlap") do
			rectB = Rectangle.new(Point.new(2, 1), 3, 3)

			result = util.intersect(rectA,rectB)
			expect(result).to include(Point.new(3,1))
			expect(result).to include(Point.new(2,3))
		end

		it("takes right bottom overlap") do
			rectB = Rectangle.new(Point.new(2, -1), 3, 3)

			result = util.intersect(rectA,rectB)
			expect(result).to include(Point.new(3,2))
			expect(result).to include(Point.new(2,0))
		end

		it("takes left right overlap") do 
			rectB = Rectangle.new(Point.new(-1, -1), 5, 3)

			result = util.intersect(rectA,rectB)
			expect(result).to include(Point.new(0,2))
			expect(result).to include(Point.new(3,2))
		end

		it ("takes top bottom overlap") do
			rectB = Rectangle.new(Point.new(2, -1), 4, 5)

			result = util.intersect(rectA,rectB)
			expect(result).to include(Point.new(2,3))
			expect(result).to include(Point.new(2,0))
		end
	end
end