local class = require 'middleclass'

local Vector2 = class('Vector2')
function Vector2:initialize(x, y)
	self.x = x or 0
	self.y = y or 0
end

function Vector2.isVector2(a)
	return type(a) == "table" and a.class.name == 'Vector2'
end

function Vector2.isVector(a)
	return type(a) == "table" and strsub(a.class.name, 0, strlen(a.class.name)-2) == 'Vector'
end

function Vector2:clone()
	return Vector2:new(self.x, self.y)
end

function Vector2:copy(other)
  if Vector2.isVector(other) then
    self.x = other.x or 0
    self.y = other.y or 0
  end
end

function Vector2:unpack()
	return self.x, self.y
end

-- The magnitude of the vector
function Vector2:mag()
	return math.sqrt(Vector2.magSq(self))
end

-- The magnitude squared
function Vector2:magSq()
  return self.x + self.y
end

-- The direction of the vector in radians
-- TODO: This is probably wrong for anything but 2D
function Vector2:dir()
	return math.atan(self.y / self.x)
end

-- The unit vector in the direction of the vector
function Vector2:unit()
	return Vector2:new(self.x, self.y) / self.mag()
end

-- What the index operator would do if we could have one
function Vector2:get(i)
  if i == 1 then
    return self.x
  elseif i == 2 then
    return self.y
  end
end

function Vector2:set(i, x)
  if i == 1 then
    self.x = x
  elseif i == 2 then
    self.y = x
  end
end

function Vector2:__tostring()
	return '{' .. tostring(self.x) .. ',' .. tostring(self.y) .. '}'
end

function Vector2:__len()
  return 2
end

function Vector2:__eq(lhs, rhs)
  return lhs.x == rhs.x and lhs.y == rhs.y
end

-- Adding two vectors
function Vector2.__add(lhs, rhs)
	if Vector2.isVector2(lhs) and Vector2.isVector2(rhs) then
		return Vector2:new(lhs.x + rhs.x, lhs.y + rhs.y)
	end
end

-- Subtracting two vectors
function Vector2.__sub(lhs, rhs)
	if Vector2.isVector2(lhs) and Vector2.isVector2(rhs) then
		return Vector2:new(lhs.x - rhs.x, lhs.y - rhs.y)
	end
end

-- Scalar multiply
function Vector2.__mul(lhs, rhs)
  local this
  local other
	if Vector2.isVector2(lhs) then
		this = lhs
		other = rhs
	elseif Vector2.isVector2(rhs) then
		this = rhs
		other = lhs
	else
		return nil
	end

	return Vector2:new(this.x * other, this.y * other)
end

-- Scalar divide
function Vector2.__div(lhs, rhs)
  local this
  local other
	if Vector2.isVector2(lhs) then
    this = lhs
		other = rhs
	elseif Vector2.isVector2(rhs) then
		this = rhs
		other = lhs
	else
    return nil
	end

	return Vector2:new(this.x / other, this.y / other)
end

-- Scalar pow
function Vector2.__pow(lhs, rhs)
  local this
  local other
	if Vector2.isVector2(lhs) then
		this = lhs
		other = rhs
	elseif Vector2.isVector2(rhs) then
		this = rhs
		other = lhs
	else
		return nil
	end

	return Vector2:new(this.x ^ other, this.y ^ other)
end

-- Dot product
function Vector2:dot(other)
	if not Vector2.isVector2(other) then
		return nil
	end

	return self.x * other.x + self.y * other.y
end

-- unary minus
function Vector2:__unm()
  return Vector2:new(-self.x, -self.y)
end

return Vector2