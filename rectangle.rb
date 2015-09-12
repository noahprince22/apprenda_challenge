require_relative "point.rb"

class Rectangle
	attr_accessor :location, :width, :height

	# initializes a rectangle
  	#
  	# ==== Parameters
 	#
 	# * +location+ - the point location of the bottom left corner
 	# * +width+ - the width of the rectangle
 	# * +height+ - the height of the rectangle
	def initialize(location, width, height)
		throw "NillLocationError" unless location
		throw "WidthError" unless width > 0
		throw "HeightError" unless height > 0

		self.location = location
		self.width = width
		self.height = height
	end
end
