
local vector = require 'vector'

local luaunit = require('luaunit')

TestConstruct = {}
  function TestConstruct:testEmptyVector()
    luaunit.assertEquals(tostring(vector:new()), "{nil}")
  end
  function TestConstruct:test1LengthVector()
    luaunit.assertEquals(tostring(vector:new(1)), "{1}")
  end
  function TestConstruct:test2LengthVector()
    luaunit.assertEquals(tostring(vector:new(1, 2)), "{1,2}")
  end
  function TestConstruct:test3LengthVector()
    luaunit.assertEquals(tostring(vector:new(1, 2, 3)), "{1,2,3}")
  end
  function TestConstruct:test4LengthVector()
    luaunit.assertEquals(tostring(vector:new(1, 2, 3, 4)), "{1,2,3,4}")
  end

TestAdd = {}
  function TestAdd:testNil()
    luaunit.assertEquals(tostring(vector:new() + vector:new()), "{nil}")
  end
  function TestAdd:testFull()
    luaunit.assertEquals(tostring(vector:new(1,1,1,1) + vector:new(1,2,3,4)), tostring(vector:new(2,3,4,5)))
  end
  function TestAdd:testMixed()
    luaunit.assertEquals(tostring(vector:new(1,1) + vector:new(1,2,3,4)), tostring(vector:new(2,3,3,4)))
  end
  function TestAdd:testShort()
    luaunit.assertEquals(tostring(vector:new(1,1) + vector:new(1)), tostring(vector:new(2,1)))
  end

TestSub = {}
  function TestSub:testNil()
    luaunit.assertEquals(tostring(vector:new() - vector:new()), "{nil}")
  end
  function TestSub:testFull()
    luaunit.assertEquals(tostring(vector:new(1,1,1,1) - vector:new(1,2,3,4)), tostring(vector:new(0,-1,-2,-3)))
  end
  function TestSub:testMixed()
    luaunit.assertEquals(tostring(vector:new(1,1) - vector:new(1,2,3,4)), tostring(vector:new(0,-1,3,4)))
  end
  function TestSub:testShort()
    luaunit.assertEquals(tostring(vector:new(1,1) - vector:new(1)), tostring(vector:new(0,1)))
  end

TestMult = {}
  function TestMult:testNil()
    luaunit.assertEquals(tostring(vector:new() * 7), "{nil}")
  end
  function TestMult:testFull()
    luaunit.assertEquals(tostring(2 * vector:new(1,2,3,4)), tostring(vector:new(2,4,6,8)))
  end
  
os.exit( luaunit.LuaUnit.run() )