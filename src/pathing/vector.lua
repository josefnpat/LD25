vector = {}

function vector.new(x, y)
  local vec = {}
  vec.x = x
  vec.y = y

  function vec.toString()
    return "{X: " .. vec.x .. ", Y: " .. vec.y .. "}"
  end

  function vec.getLength()
    return math.sqrt(vec.x*vec.x+vec.y*vec.y)
  end

  function vec.getLengthSq()
    return vec.x*vec.x+vec.y*vec.y
  end

  function vec.equals(v)
    return (vec.x == v.x and vec.y == v.y)
  end

  return vec

end

function vector.add(v1, v2)
  return vector.new(v1.x+v2.x, v1.y+v2.y)
end

function vector.sdist(v1, v2)
  return (math.abs(v1.x - v2.x) + math.abs(v1.y - v2.y))
end

function vector.sub(v1, v2)
  return vector.new(v1.x-v2.x, v1.y-v2.y)
end

function vector.mul(v1, v2)
  return vector.new(v.x*s, v.y*s)
end

function vector.div(v, s)
  return vector.new(v.x/s, v.y/s)
end