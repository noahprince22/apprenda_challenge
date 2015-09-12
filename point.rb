Point = Struct.new(:x, :y) {
	def ==(other) 
		return (other.x == self.x and other.y == self.y)
	end
}