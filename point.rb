# Currently only supports integers. DO NOT use doubles or floats, 
#    or there will be undefined behavior
Point = Struct.new(:x, :y) {
	def ==(other) 
		return (other.x == self.x and other.y == self.y)
	end
}