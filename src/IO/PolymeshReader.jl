include("../Utils/PolymeshReaderUtils.jl")


function getpolymeshfiles(polymeshdir)
    polymeshfiles = Dict()
    polymeshfiles["points"] = joinpath(polymeshdir, "points")
    polymeshfiles["faces"] = joinpath(polymeshdir, "faces")
    polymeshfiles["boundary"] = joinpath(polymeshdir, "boundary")
    polymeshfiles["owner"] = joinpath(polymeshdir, "owner")
    polymeshfiles["neighbour"] = joinpath(polymeshdir, "neighbour")
    return polymeshfiles
end

function readpoints(pointsfile)
    points = []
    lines, npoints, linestart = getfileitems(pointsfile)
    for i in 1:npoints
        push!(points, stringtofloatlist(lines[i + linestart - 1]))
    end
    return points
end

function readfaces(facesfile)
    faces = []
    lines, nfaces, linestart = getfileitems(facesfile)
    for i in 1:nfaces
        push!(faces, stringtointlist(lines[i + linestart - 1][2:end]))
        faces[i] = faces[i] .+ 1
    end
    return faces
end

function readboundary(boundaryfile)
    boundary = []
    lines, nboundaries, linestart = getfileitems(boundaryfile)
    j = linestart
    i = 0
    while true
        if lines[j] == ")"
            break
        else
            if lines[j + 1] == "{" # face detected
                i += 1
                push!(boundary, Dict())
                boundary[i]["name"] = lines[j]
                k = j + 2
                while true
                    if lines[k] == "}" # end of a particular face
                        break
                    else
                        key, value = linetokeyvalue(lines[k])
                        if key == "nFaces"
                            value = parse(Int64, value)
                        elseif key == "startFace"
                            value = parse(Int64, value) + 1
                        end
                        boundary[i][key] = value
                    k += 1
                    end
                end
            end
        end
        j += 1
    end
    return boundary
end

function readowner(ownerfile)
    owner = []
    lines, nfaces, linestart = getfileitems(ownerfile)
    for i in 1:nfaces
        push!(owner, parse(Int64, lines[i + linestart - 1]))
        owner[i] = owner[i] .+ 1
    end
    return owner
end

function readneighbour(neighbourfile)
    neighbour = []
    lines, nifaces, linestart = getfileitems(neighbourfile)
    for i in 1:nifaces
        push!(neighbour, parse(Int64, lines[i + linestart - 1]))
        neighbour[i] = neighbour[i] .+ 1
    end
    return neighbour
end

function readpolymesh(polymeshfiles)
    polymesh = Dict()
    polymesh["points"] = readpoints(polymeshfiles["points"])
    polymesh["faces"] = readfaces(polymeshfiles["faces"])
    polymesh["boundary"] = readboundary(polymeshfiles["boundary"])
    polymesh["owner"] = readowner(polymeshfiles["owner"])
    polymesh["neighbour"] = readneighbour(polymeshfiles["neighbour"])
    return polymesh
end
