# Define the new measure data type with <: AbstractMeasureData
struct NewMeasureData <: AbstractMeasureData
    attr1::String # REPLACE WITH ACTUAL ATTRIBUTE
    attr2::DiscreteMeasureData # REPLACE WITH ACTUAL ATTRIBUTE
    # ADD MORE ATTRIBUTES AS NEEDED
    # constructor
    function NewMeasureData(attr1::String, attr2::DiscreteMeasureData)
        # INSERT CHECKS AND OTHER CONSTRUCTOR METHODS HERE
        return new(attr1, attr2) # REPLACE WITH ACTUAL ATTRIBUTES
    end
end

# Extend parameter_refs to return the parameter(s) being measured by a measure using NewMeasureData
function InfiniteOpt.parameter_refs(data::NewMeasureData)::Union{ParameterRef, AbstractArray{<:ParameterRef}}
    return data.attr2.parameter_ref # REPLACE WITH ACTUAL PARAMETER LOCATION
end

# Extend expand_measure to return the finite reformulation of a measure using NewMeasureData
function InfiniteOpt.expand_measure(expr::JuMP.AbstractJuMPScalar,
                                    data::NewMeasureData,
                                    write_model::JuMP.AbstractModel,
                                    point_mapper::Function)::JuMP.AbstractJuMPScalar
    # INSERT APPROPRIATE METHODS HERE USING point_mapper AS APPROPRIATE
    # USING make_point_variable_ref AND make_reduced_variable_ref MAY BE USEFUL
    return expand_measure(expr, data.attr2, write_model, point_mapper) # REPLACE ACTUAL RESULT
end

# Extend supports to return any infinite parameter supports employed by NewMeasureData
# This is only optional if the new abstraction doesn't use supports at all
function InfiniteOpt.supports(data::NewMeasureData)::Vector
    return data.attr2.supports # REPLACE WITH ACTUAL LOCATION
end

# Extend measure_data_in_hold_bounds to determine if NewMeasureData is in the
# domain of hold variable bounds. (Enables hold variable error checking)
function InfiniteOpt.measure_data_in_hold_bounds(data::NewMeasureData,
                                                 bounds::ParameterBounds)::Bool
    # INSERT ACTUAL CHECK HERE
    in_bounds = measure_data_in_hold_bounds(data.attr2, bounds) # REPLACE WITH ACTUAL RESULT
    return in_bounds
end

# Extend measure_name to return the name of a measure using NewMeasureData
# This is optional (uses "measure" otherwise)
function InfiniteOpt.measure_name(data::NewMeasureData)::String
    return data.attr1 # REPLACE WITH ACTUAL NAME LOCATION
end

# Make a convenient measure constructor function for our new measure type
# This should employ measure(expr, data)
function new_measure(expr::JuMP.AbstractJuMPScalar, param::ParameterRef,
                     lb::Number, ub::Number; name::String = "NewMeas",
                     num_supports::Int = 10)::MeasureRef # REPLACE ARGS WITH ACTUAL DESIRED
    # INSERT RELAVENT CHECKS AND OPERATIONS HERE
    # REPLACE BELOW WITH ACTUAL CONSTRUCTION
    attr2 = generate_measure_data(param, num_supports, lb, ub) # just an example
    data = NewMeasureData(name, attr2) # REPLACE WITH ACTUAL
    # built the measure using the built-in constructor
    return measure(expr, data)
end
