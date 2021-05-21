include("MeshCreator.jl")
include("MeshTopology.jl")
include("MeshGeometry.jl")


function processopenfoammesh(polymesh)
    println("Generating mesh ...")
    # Create mesh
    nodes = createnodes(polymesh["points"])
    faces = createfaces(polymesh["faces"], polymesh["owner"], polymesh["neighbour"])
    boundaries = createboundaries(polymesh["boundary"])
    cells = createcells(polymesh["owner"])

    # Get mesh topology
    getnodestopology(nodes, faces)
    getfacestopology(nodes, faces)
    getcellstopology(nodes, faces, cells)

    # Get mesh geometrical properties
    getnodesgeometricalquantities(nodes, faces)
    getfacesgeometricalquantities(nodes, faces)
    getcellsgeometricalquantities(nodes, faces, cells)

    # Get faces remaining properties
    getfacesremainingproperties(nodes, faces, cells)

    # Create FlicsMesh object
    mesh = Mesh(nodes, faces, boundaries, cells)
    println("FlicsMesh is successfully generated")

    return mesh
end
