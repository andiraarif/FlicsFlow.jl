using LinearAlgebra
using Statistics


function computegeometriccenter(points)
    x = [points[i][1] for i in 1:length(points)]
    y = [points[i][2] for i in 1:length(points)]
    z = [points[i][3] for i in 1:length(points)]

    return [mean(x), mean(y), mean(z)]
end

function computesurfacenormal(vectors)
    v1 = vectors[2] - vectors[1]
    v2 = vectors[3] - vectors[1]
    return 0.5*cross(v1, v2)
end

function computemagnitude(vector)
    return sqrt(dot(vector, vector))
end
