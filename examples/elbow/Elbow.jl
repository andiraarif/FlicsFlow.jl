# ------------------------------------------------------------------- #
#                          FlicsFlow.jl                               #
#                       -----------------                             #
#     A General Three-dimensional Unstructured Finite Volume Solver   #
#                                                                     #
#                    Copyright(c) 2021 NUMFLICS                       #
# ------------------------------------------------------------------- #
using Pkg
Pkg.activate("C:\\Users\\arifa\\.julia\\dev\\FlicsFlow")

using FlicsFlow


# Get the current case directory
casedir = @__DIR__

# Read the OpenFOAM Mesh
mesh = readopenfoammesh(casedir)
