local class = require 'middleclass'

local Vector3 = class('Vector3')
function Vector3:initialize(x, y, z)
	self.x = x or 0
	self.y = y or 0
  self.z = z or 0
end

function Vector3.isVector3(a)
	return type(a) == "table" and a.class.name == 'Vector3'
end

function Vector3.isVector(a)
	return type(a) == "table" and strsub(a.class.name, 0, strlen(a.class.name)-2) == 'Vector'
end

function Vector3:clone()
	return Vector3:new(self.x, self.y, self.z)
end

-- Copy constructor can be used to explicitly extend smaller vectors to larger ones
function Vector3:copy(other)
  if Vector3.isVector(other) then
    self.x = other.x or 0
    self.y = other.y or 0
    self.z = other.z or 0
  end
end

function Vector3:unpack()
	return self.x, self.y, self.z
end

-- The magnitude of the vector
function Vector3:mag()
	return math.sqrt(Vector3.magSq(self))
end

-- The magnitude squared
function Vector3:magSq()
  return self.x + self.y + self.z
end

-- The direction of the vector in radians
-- TODO: This is probably wrong for anything but 2D
function Vector3:dir()
	return math.atan(self.y / self.x), math.atan(self.z / self.x)
end

-- The unit vector in the direction of the vector
function Vector3:unit()
	return Vector3:new(self.x, self.y, self.z) / self.mag()
end

-- What the index operator would do if we could have one
function Vector3:get(i)
  if i == 1 then
    return self.x
  elseif i == 2 then
    return self.y
  elseif i == 3 then
    return self.z
  end
end

function Vector3:set(i, x)
  if i == 1 then
    self.x = x
  elseif i == 2 then
    self.y = x
  elseif i == 3 then
    self.z = x
  end
end

function Vector3:__tostring()
	return '{' .. tostring(self.x) .. ',' .. tostring(self.y) .. ',' .. tostring(self.z) .. '}'
end

function Vector3:__len()
  return 3
end

function Vector3:__eq(lhs, rhs)
  return lhs.x == rhs.x and lhs.y == rhs.y and lhs.z == rhs.z
end

-- Adding two vectors
function Vector3.__add(lhs, rhs)
	if Vector3.isVector3(lhs) and Vector3.isVector3(rhs) then
		return Vector3:new(lhs.x + rhs.x, lhs.y + rhs.y, lhs.z + rhs.z)
	end
end

-- Subtracting two vectors
function Vector3.__sub(lhs, rhs)
	if Vector3.isVector3(lhs) and Vector3.isVector3(rhs) then
		return Vector3:new(lhs.x - rhs.x, lhs.y - rhs.y, lhs.z - rhs.z)
	end
end

-- Scalar multiply
function Vector3.__mul(lhs, rhs)
  local this
  local other
	if Vector3.isVector3(lhs) then
		this = lhs
		other = rhs
	elseif Vector3.isVector3(rhs) then
		this = rhs
		other = lhs
	else
		return nil
	end

	return Vector3:new(this.x * other, this.y * other, this.z * other)
end

-- Scalar divide
function Vector3.__div(lhs, rhs)
  local this
  local other
	if Vector3.isVector3(lhs) then
    this = lhs
		other = rhs
	elseif Vector3.isVector3(rhs) then
		this = rhs
		other = lhs
	else
    return nil
	end

	return Vector3:new(this.x / other, this.y / other, this.z / other)
end

-- Scalar pow
function Vector3.__pow(lhs, rhs)
  local this
  local other
	if Vector3.isVector3(lhs) then
		this = lhs
		other = rhs
	elseif Vector3.isVector3(rhs) then
		this = rhs
		other = lhs
	else
		return nil
	end

	return Vector3:new(this.x ^ other, this.y ^ other, this.z ^ other)
end

-- Dot product
function Vector3:dot(other)
	if not Vector3.isVector3(other) then
		return nil
	end

	return self.x * other.x + self.y * other.y + self.z * other.z
end

-- unary minus
function Vector3:__unm()
  return Vector3:new(-self.x, -self.y, -self.z)
end

return Vector3