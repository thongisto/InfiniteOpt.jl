## Extend convert to handle JuMP expression types
# GenericAffExpr
function Base.convert(::Type{JuMP.GenericAffExpr{C, V}},
                      x::JuMP.GenericAffExpr{C, W}) where {C, V, W}
    if V != W
        return JuMP.GenericAffExpr{C,V}(x.constant, x.terms)
    else
        return x
    end
end

# GenericQuadExpr
function Base.convert(::Type{JuMP.GenericQuadExpr{C, V}},
                      x::JuMP.GenericQuadExpr{C, W}) where {C, V, W}
    if V != W
        return JuMP.GenericQuadExpr{C, V}(x.aff, x.terms)
    else
        return x
    end
end

# UnorderedPair
function Base.convert(::Type{JuMP.UnorderedPair{V}},
                      x::JuMP.UnorderedPair{W}) where {V, W}
    if V != W
        return JuMP.UnorderedPair{V}(x.a, x.b)
    else
        return x
    end
end

## Extend convert to handle JuMP containers
# Array -> SparseAxisArray
function Base.convert(::Type{JuMPC.SparseAxisArray}, arr::Array)
    data = Dict(Tuple(k) => arr[k] for k in CartesianIndices(arr))
    return JuMPC.SparseAxisArray(data)
end

# DenseAxisArray -> SparseAxisArray
function Base.convert(::Type{JuMPC.SparseAxisArray},
                      arr::JuMPC.DenseAxisArray)
    data = Dict(k.I => arr[k] for k in keys(arr))
    return JuMPC.SparseAxisArray(data)
end

## Extensions for ParameterBounds
# length
Base.length(bounds::ParameterBounds)::Int = length(bounds.intervals)

# equal to
function Base.:(==)(bounds1::ParameterBounds, bounds2::ParameterBounds)::Bool
    return bounds1.intervals == bounds2.intervals
end

# copy
Base.copy(bounds::ParameterBounds) = ParameterBounds(copy(bounds.intervals))

# function Base.convert(::Type{Array}, arr::JuMPC.SparseAxisArray)
#
# end
#
# function Base.convert(::Type{JuMPC.DenseAxisArray},
#                       arr::JuMPC.SparseAxisArray)
#
# end

# Extend to handle InfOptParameters correctly
function Base.:(==)(p1::InfOptParameter, p2::InfOptParameter)
    check1 = p1.set == p2.set
    check2 = isequal(p1.supports, p2.supports)
    check3 = p1.independent == p2.independent
    return (check1 && check2 && check3)
end

# Hack to make the keys function work for sparse arrays
Base.keys(d::JuMPC.SparseAxisArray) = keys(d.data)
# Hacky fix to compare SparseAxisArrays
function Base.isapprox(a::JuMPC.SparseAxisArray, b::JuMPC.SparseAxisArray)::Bool
    return all(isapprox.(a, b))
end

# Attempt to convert variable type of GenericAffExpr if possible
function _possible_convert(type::DataType,
                           aff::JuMP.GenericAffExpr{C, V}) where {C, V}
    valids = [k isa type for k in keys(aff.terms)]
    if all(valids)
        return JuMP.GenericAffExpr{C, type}(aff.constant, aff.terms)
    else
        return aff
    end
end

# Attempt to convert variable type of GenericQuadExpr if possible
function _possible_convert(type::DataType,
                           quad::JuMP.GenericQuadExpr{C, V}) where {C, V}
    valids_a = [k.a isa type for k in keys(quad.terms)]
    valids_b = [k.b isa type for k in keys(quad.terms)]
    valids_aff = [k isa type for k in keys(quad.aff.terms)]
    if all(valids_a) && all(valids_b) && all(valids_aff)
        aff = convert(JuMP.GenericAffExpr{C, type}, quad.aff)
        return JuMP.GenericQuadExpr{C, type}(aff, quad.terms)
    else
        return quad
    end
end

## Define functions to convert a JuMP array into a vector (need for @BDconstraint)
# AbstractArray
function _make_vector(arr::AbstractArray)
    return [arr[i] for i in keys(arr)]
end

# Array (no nothing)
function _make_vector(arr::Array)
    return arr
end

# Something else
function _make_vector(arr)
    return arr
end
