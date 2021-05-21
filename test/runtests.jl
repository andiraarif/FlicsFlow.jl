using FlicsFlow
using Test

@testset "FlicsFlow.jl" begin
    # Write your tests here.
	casedir = "../examples/elbow"
	@test readopenfoammesh(casedir).nodes[1].index == 1
end
