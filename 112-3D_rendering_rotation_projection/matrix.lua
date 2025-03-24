local matrix = {}

function matrix.vecToMatrix(v)
    local m = {}
    for i = 1, 3 do
        m[i] = {}
    end
    m[1][1] = v.x
    m[2][1] = v.y
    m[3][1] = v.z
    return m
end

function matrix.matrixToVec(m)
    return { x = m[1][1], y = m[2][1], z = #m > 2 and m[3][1] or 0 }
end

function matrix.logMatrix(m)
    local cols = #m[1]
    local rows = #m
    print(rows .. "x" .. cols)
    print("----------------")
    local s = ''
    for i = 1, rows do
        for j = 1, cols do
            s = s .. (m[i][j] .. " ")
        end
        print(s)
    end
    print()
end

function matrix.matmulvec(a, vec)
    local m = matrix.vecToMatrix(vec)
    local r = matrix.matmul(a, m)
    return matrix.matrixToVec(r)
end

function matrix.matmul(a, b)
    if type(b) == "table" and b.x ~= nil then
        return matrix.matmulvec(a, b)
    end

    local colsA = #a[1]
    local rowsA = #a
    local colsB = #b[1]
    local rowsB = #b

    if colsA ~= rowsB then
        error("Columns of A must match rows of B")
        return nil
    end

    local result = {}
    for j = 1, rowsA do
        result[j] = {}
        for i = 1, colsB do
            local sum = 0
            for n = 1, colsA do
                sum = sum + a[j][n] * b[n][i]
            end
            result[j][i] = sum
        end
    end
    return result
end

return matrix
