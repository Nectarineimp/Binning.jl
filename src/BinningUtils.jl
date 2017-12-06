### Binning
# A bin is a range of values between which values are grouped. Bins range from
# 1 to however many bins are selected. This allows for continuous data to be used
# for classification or histograms or other analysis.

SampleSpaceTooSmall = AssertionError("equalfrequencylimits(dv, bins) -> bins is not less than the length of dv. Reduce bins.")
BinsTooSmall = AssertionError("equalfrequencylimits(dv, bins) -> bins must be at least 2.")
BinWidthTooSmall = AssertionError("equalfrequencylimits(dv, bins) -> The calculated width of the bins is too small for sample space. Add more data or reduce bins.")

"equaldistancelimits(dv::Vector{<:AbstractFloat}, bins::Signed)

Produces a StepRangeLen of floats used to create bins, based on a spread
from the minimum to the maximum value of elements given."
function equaldistancelimits(dv::Vector{<:AbstractFloat}, bins::Signed)
    min = minimum(dv)
    max = maximum(dv)
    binwidth = (max-min)/(bins-1)
    return(min:binwidth:max)
end

"equalfrequencylimits(dv::Vector{<:AbstractFloat}, bins::Signed)

Produces a vector of floats used to create bins, based upon an equal frequency
division of the number of given elements after the range has been sorted.
If the number of elements is not evenly divided by the number of bins, the extra
elements are added to the last bin.

For example: 100 elements, 9 bins, produces 8 bins of 11 elements and 1 bin of 12."
function equalfrequencylimits(dv::Vector{<:AbstractFloat}, bins::Signed)
    if bins > length(dv)
        throw(SampleSpaceTooSmall)
    end
    if bins < 2
        throw(BinsTooSmall)
    end
    dv = sort(dv)
    elements = length(dv)
    binwidth = elements/bins

    if binwidth < 1.0
        throw(BinWidthTooSmall)
    end

    binrange = zeros(Float64, bins)
    for i in 1:bins
        binrange[i] = dv[Int(floor(i*binwidth))]
    end
    binrange[end] = dv[end]
    return sort(binrange)
end

"find_bin(x::AbstractFloat, limits::Vector{<:AbstractFloat})

This function finds which of the given bins the value belongs to."
function find_bin(x::AbstractFloat, limits::Vector{<:AbstractFloat})
    bin = Union{Missing, Int16}(missing)
    for i in 1:length(limits)
        if x <= limits[i]
            bin = i
            break
        end
    end
    bin
end

"find_bin(x::AbstractFloat, limits::StepRangeLen{<:AbstractFloat}=equaldistancelimits(x, 10))

This function finds which of the given bins the value belongs to."
function find_bin(x::AbstractFloat, limits::StepRangeLen{<:AbstractFloat}=equaldistancelimits(x, 10))
    bin = Union{Missing, Int16}(missing)
    for i in 1:length(limits)
        if x <= limits[i]
            bin = i
            break
        end
    end
    bin
end

"binindex(dv::Vector{<:AbstractFloat}, limits::Vector{<:AbstractFloat})

This produces a vector, the same length as the data, containing the bin values."
function binindex(dv::Vector{<:AbstractFloat}, limits::Vector{<:AbstractFloat})
    vbins = zeros(Int16, length(dv))
    for i in 1:length(dv)
        vbins[i] = find_bin(dv[i], limits)
    end
    vbins
end

"binindex(dv::Vector{<:AbstractFloat}, limits::StepRangeLen{<:AbstractFloat}=equaldistancelimits(dv, 10))

This produces a vector, the same length as the data, containing the bin values."
function binindex(dv::Vector{<:AbstractFloat}, limits::StepRangeLen{<:AbstractFloat}=equaldistancelimits(dv, 10))
    vbins = zeros(Int16, length(dv))
    for i in 1:length(dv)
        vbins[i] = find_bin(dv[i], limits)
    end
    vbins
end

"binsupport(dv::Vector{Int16}, limits::Vector{<:Signed})

This produces a vector of tuples that contains the bin and the support, or number of samples seen, for that bin."
function binsupport(dv::Vector{Int16}, limits::Vector{<:Signed})
    map(λ -> (λ, sum(dv .== λ)), limits)
end

"binsupport(dv::Vector{Int16}, limits::UnitRange{<:Signed})

This produces a vector of tuples that contains the bin and the support, or number of samples seen, for that bin."
function binsupport(dv::Vector{Int16}, limits::UnitRange{<:Signed})
    map(λ -> (λ, sum(dv .== λ)), limits)
end

# TODO: Missings support
# TODO: Group binning
