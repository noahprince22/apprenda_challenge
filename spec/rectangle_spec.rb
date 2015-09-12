require_relative "../point.rb"
require_relative "../rectangle.rb"

RSpec::Expectations.configuration.warn_about_potential_false_positives = false

describe ("a rectangle") do
	it ("does not take negative width") do 
		expect{Rectangle.new(Point.new(0,0), -1, 1)}.to raise_error
	end

	it ("does not take negative height") do
		expect{Rectangle.new(Point.new(0,0), 1, -1)}.to raise_error
	end

	it ("does not take 0 width") do
		expect{Rectangle.new(Point.new(0,0), 0, 1)}.to raise_error
	end	

	it ("does not take 0 height") do
		expect{Rectangle.new(Point.new(0,0), 1, 0)}.to raise_error
	end	

	it ("does not take a nil point") do 
		expect{Rectangle.new(nil, 1, 1)}.to raise_error
	end


	context("accessors") do 
		point = Point.new(-1,-20)
		width = 12
		height = 15
		rect = Rectangle.new(point, width, height)

		it ("allows access to the point") do
			expect(rect.location).to eq(point)
		end

		it ("allows access to the width") do
			expect(rect.width).to eq(width)
		end

		it ("allows access to the height") do
			expect(rect.height).to eq(height)
		end
	end
end