include("MeshStruct.jl")


function createnodes(points)
    nodes = []
    for i in 1:length(points)
        node = Node()
        node.index = i
        node.centroid = points[i]
        node.ifaces = []
        node.icells = []
        push!(nodes, node)
    end
    return nodes
end

function createfaces(faces, owner, neighbour)
    faces_ = []
    for i in 1:length(faces)
        face = Face()
        face.index = i
        face.centroid = []
        face.inodes = faces[i]
        face.iowner = owner[i]
        if i <= length(neighbour)
            face.ineighbour = neighbour[i]
        else
            face.ineighbour = -1
        end
        face.area = 0
        face.sf = []
        face.cn = []
        face.geodiff = 0
        face.T = []
        face.gf = 0
        face.walldist = 0
        face.iownerneighbourcoeff = 1
        face.ineighbourownercoeff = 1
        push!(faces_, face)
    end
    return faces_
end

function createboundaries(boundary)
    boundaries = []
    for i in 1:length(boundary)
        boundarydict = Boundary()
        boundarydict.name = boundary[i]["name"]
        boundarydict.index = i
        boundarydict.type = boundary[i]["type"]
        boundarydict.nfaces = boundary[i]["nFaces"]
        boundarydict.startface = boundary[i]["startFace"]
        push!(boundaries, boundarydict)
    end
    return boundaries
end

function createcells(owner)
    cells = []
    current_owner = 0
    for i in 1:length(owner)
        if owner[i] == current_owner + 1
            current_owner = owner[i]
            cell = Cell()
            cell.index = current_owner
            cell.ineighbours = []
            cell.ifaces = []
            cell.inodes = []
            cell.volume = 0
            cell.facesign = []
            cell.nneighbours = 0
            cell.centroid = []
            push!(cells, cell)
        end
    end
    return cells
end
