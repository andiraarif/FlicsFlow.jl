include("../IO/PolymeshReader.jl")
include("MeshProcessor.jl")


function readopenfoammesh(casedir)
    polymeshdir = joinpath(casedir, "constant/polyMesh")
    polymeshfiles = getpolymeshfiles(polymeshdir)
    polymesh = readpolymesh(polymeshfiles)
    return processopenfoammesh(polymesh)
end
