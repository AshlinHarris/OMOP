#!/usr/bin/env julia

include("src/OMOP.jl")
using .OMOP

function main()
	x=test_function(4)
	println(x)
end

main()

