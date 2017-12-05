__precompile__()

module Binning
    using Missings

    # import Base: ==, !=, >, <, >=, <=, +, -, *, !, &, |, ⊻, ^, /

    export equaldistancelimits, find_bin, binindex, binsupport

    include("BinningUtils.jl")
end
