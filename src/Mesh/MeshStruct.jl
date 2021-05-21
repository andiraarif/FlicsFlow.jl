mutable struct Node
    index::Int64
    centroid::Vector{Float64}
    ifaces::Vector{Int64}
    icells::Vector{Int64}
    print::Function
    function Node()
        this = new()
        this.print = function() printnode(this) end
        this
    end
end

mutable struct Face
    index::Int64
    centroid::Vector{Float64}
    inodes::Vector{Int64}
    iowner::Int64
    ineighbour::Int64
    area::Float64
    sf::Vector{Float64}
    cn::Vector{Float64}
    geodiff::Float64
    T::Vector{Float64}
    gf::Float64
    walldist::Float64
    iownerneighbourcoeff::Int64
    ineighbourownercoeff::Int64
    print::Function
    function Face()
        this = new()
        this.print = function() printface(this) end
        this
    end
end

mutable struct Boundary
    index::Int64
    name::String
    type::String
    nfaces::Int64
    startface::Int64
    print::Function
    function Boundary()
        this = new()
        this.print = function() printboundary(this) end
        this
    end
end

mutable struct Cell
    index::Int64
    centroid::Vector{Float64}
    inodes::Vector{Int64}
    ifaces::Vector{Int64}
    ineighbours::Vector{Int64}
    volume::Float64
    facesign::Vector{Int64}
    nneighbours::Int64
    print::Function
    function Cell()
        this = new()
        this.print = function() printcell(this) end
        this
    end
end

mutable struct Mesh
    nodes::Vector{Node}
    faces::Vector{Face}
    boundaries::Vector{Boundary}
    cells::Vector{Cell}
    print::Function
    function Mesh(nodes, faces, boundaries, cells)
        this = new()
        this.nodes = nodes
        this.faces = faces
        this.boundaries = boundaries
        this.cells = cells
        this.print = function() printmesh(this) end
        this
    end
end

function printnode(node::Node)
    print("\n")
    println("        index: ", node.index)
    println("     centroid: ", node.centroid)
    println("       iFaces: ", node.ifaces)
    println("       iCells: ", node.icells)
    print("\n")
end

function printface(face::Face)
    print("\n")
    println("                   index: ", face.index)
    println("                centroid: ", face.centroid)
    println("                  iNodes: ", face.inodes)
    println("                  iOwner: ", face.iowner)
    println("              iNeighbour: ", face.ineighbour)
    println("                    area: ", face.area)
    println("                      Sf: ", face.sf)
    println("                      CN: ", face.cn)
    println("                 geodiff: ", face.geodiff)
    println("                       T: ", face.T)
    println("                      gf: ", face.gf)
    println("                walldist: ", face.walldist)
    println("    iOwnerNeighbourCoeff: ", face.iownerneighbourcoeff)
    println("    iNeighbourOwnerCoeff: ", face.ineighbourownercoeff)
    print("\n")
end

function printboundary(boundary::Boundary)
    print("\n")
    println("             index: ", boundary.index)
    println("              name: ", boundary.name)
    println("              type: ", boundary.type)
    println("    numberOfBFaces: ", boundary.nfaces)
    println("         startFace: ", boundary.startface)
    print("\n")
end

function printcell(cell::Cell)
    print("\n")
    println("                 index: ", cell.index)
    println("              centroid: ", cell.centroid)
    println("                iNodes: ", cell.inodes)
    println("                iFaces: ", cell.ifaces)
    println("           iNeighbours: ", cell.ineighbours)
    println("                volume: ", cell.volume)
    println("              faceSign: ", cell.facesign)
    println("    numberOfNeighbours: ", cell.nneighbours)
    print("\n")
end

function printmesh(mesh::Mesh)
    print("\n")
    println("                    nodes: ", typeof(mesh.nodes))
    println("            numberOfNodes: ", length(mesh.nodes))
    println("                    faces: ", typeof(mesh.faces))
    println("            numberOfFaces: ", length(mesh.faces))
    println("                 elements: ", typeof(mesh.cells))
    println("         numberOfElements: ", length(mesh.cells))
    println("               boundaries: ", typeof(mesh.boundaries))
    println("       numberOfBoundaries: ", length(mesh.boundaries))
    println("    numberOfInteriorFaces: ")
    print("\n")
end
