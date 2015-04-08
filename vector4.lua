local class = require 'middleclass'

local Vector4 = class('Vector4')
function Vector4:initialize(x, y, z, w)
	self.x = x or 0
	self.y = y or 0
  self.z = z or 0
  self.w = w or 0
end

function Vector4.isVector4(a)
	return type(a) == "table" and a.class.name == 'Vector4'
end

function Vector4.isVector(a)
	return type(a) == "table" and strsub(a.class.name, 0, strlen(a.class.name)-2) == 'Vector'
end

function Vector4:clone()
	return Vector4:new(self.x, self.y, self.z, self.w)
end

-- Copy constructor can be used to explicitly extend smaller vectors to larger ones
function Vector4:copy(other)
  if Vector4.isVector(other) then
    self.x = other.x or 0
    self.y = other.y or 0
    self.z = other.z or 0
    self.w = other.w or 0
  end
end

function Vector4:unpack()
	return self.x, self.y, self.z, self.w
end

-- The magnitude of the vector
function Vector4:mag()
	return math.sqrt(Vector4.magSq(self))
end

-- The magnitude squared
function Vector4:magSq()
  return self.x + self.y + self.z + self.w
end

-- The direction of the vector in radians
-- TODO: This is probably wrong for anything but 2D
function Vector4:dir()
	return math.atan(self.y / self.x), math.atan(self.z / self.x), math.atan(self.w / self.x)
end

-- The unit vector in the direction of the vector
function Vector4:unit()
	return Vector4:new(self.x, self.y, self.z, self.w) / self.mag()
end

-- What the index operator would do if we could have one
function Vector4:get(i)
  if i == 1 then
    return self.x
  elseif i == 2 then
    return self.y
  elseif i == 3 then
    return self.z
  elseif i == 4 then
    return self.w
  end
end

function Vector4:set(i, x)
  if i == 1 then
    self.x = x
  elseif i == 2 then
    self.y = x
  elseif i == 3 then
    self.z = x
  elseif i == 4 then
    self.w = x
  end
end

function Vector4:__tostring()
	return '{' .. tostring(self.x) .. ',' .. tostring(self.y) .. ',' .. tostring(self.z) .. ',' .. tostring(self.w) .. '}'
end

function Vector4:__len()
  return 4
end

function Vector4:__eq(lhs, rhs)
  return lhs.x == rhs.x and lhs.y == rhs.y and lhs.z == rhs.z and lhs.w == rhs.w
end

-- Adding two vectors
function Vector4.__add(lhs, rhs)
	if Vector4.isVector4(lhs) and Vector4.isVector4(rhs) then
		return Vector4:new(lhs.x + rhs.x, lhs.y + rhs.y, lhs.z + rhs.z, lhs.w + rhs.w)
	end
end

-- Subtracting two vectors
function Vector4.__sub(lhs, rhs)
	if Vector4.isVector4(lhs) and Vector4.isVector4(rhs) then
		return Vector4:new(lhs.x - rhs.x, lhs.y - rhs.y, lhs.z - rhs.z, lhs.w - rhs.w)
	end
end

-- Scalar multiply
function Vector4.__mul(lhs, rhs)
  local this
  local other
	if Vector4.isVector4(lhs) then
		this = lhs
		other = rhs
	elseif Vector4.isVector4(rhs) then
		this = rhs
		other = lhs
	else
		return nil
	end

	return Vector4:new(this.x * other, this.y * other, this.z * other, this.w * other)
end

-- Scalar divide
function Vector4.__div(lhs, rhs)
  local this
  local other
	if Vector4.isVector4(lhs) then
    this = lhs
		other = rhs
	elseif Vector4.isVector4(rhs) then
		this = rhs
		other = lhs
	else
    return nil
	end

	return Vector4:new(this.x / other, this.y / other, this.z / other, this.w / other)
end

-- Scalar pow
function Vector4.__pow(lhs, rhs)
  local this
  local other
	if Vector4.isVector4(lhs) then
		this = lhs
		other = rhs
	elseif Vector4.isVector4(rhs) then
		this = rhs
		other = lhs
	else
		return nil
	end

	return Vector4:new(this.x ^ other, this.y ^ other, this.z ^ other, this.w ^ other)
end

-- Dot product
function Vector4:dot(other)
	if not Vector4.isVector4(other) then
		return nil
	end

	return self.x * other.x + self.y * other.y + self.z * other.z + self.w * other.w
end

-- unary minus
function Vector4:__unm()
  return Vector4:new(-self.x, -self.y, -self.z, -self.w)
end

return Vector4