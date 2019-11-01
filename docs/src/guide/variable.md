# Variables
A guide and manual for the definition and use of variables in `InfiniteOpt`.

## Overview
Decision variables are at the very core of `InfiniteOpt` as its name alludes
to mathematical programs that entail infinite decision spaces (i.e., contain
infinite decision variables). Principally, three variable types are employed:
infinite, point, and hold. Infinite variables encompass any decision variable
that is parameterized by an infinite parameter (e.g., space-time variables and
recourse variables). Point variables are infinite variables at a particular
infinite parameter value (point). Finally, hold variables are decisions that
are made irrespective of the infinite domain (e.g., first stage variables and
design variables). Or in other words they hold a particular over the infinite
domain or some sub-domain of it.

## Basic Usage
Infinite, point, and global variables are typically defined via their respective
macros: [`@infinite_variable`](@ref), [`@point_variable`](@ref), and
[`@hold_variable`](@ref).

## Infinite Variable Definition


## Point Variable Definition


## Global Variable Definition


## Manipulation


## Datatypes
```@index
Pages   = ["variable.md"]
Modules = [InfiniteOpt]
Order   = [:type]
```
```@docs
InfOptVariable
InfiniteVariable
PointVariable
ParameterBounds
HoldVariable
InfOptVariableRef
GeneralVariableRef
MeasureFiniteVariableRef
FiniteVariableRef
InfiniteVariableRef
PointVariableRef
HoldVariableRef
```

## Methods/Macros
```@index
Pages   = ["variable.md"]
Modules = [InfiniteOpt, JuMP]
Order   = [:macro, :function]
```
```@docs
JuMP.build_variable(::Function, ::JuMP.VariableInfo, ::Symbol)
JuMP.add_variable(::InfiniteModel, ::InfOptVariable, ::String)
@infinite_variable
@point_variable
@hold_variable
JuMP.owner_model(::GeneralVariableRef)
JuMP.index(::GeneralVariableRef)
used_by_constraint(::InfOptVariableRef)
used_by_measure(::InfOptVariableRef)
used_by_objective(::InfOptVariableRef)
is_used(::InfOptVariableRef)
used_by_point_variable(::InfiniteVariableRef)
used_by_reduced_variable(::InfiniteVariableRef)
is_used(::InfiniteVariableRef)
JuMP.delete(::InfiniteModel, ::InfOptVariableRef)
JuMP.is_valid(::InfiniteModel, ::InfOptVariableRef)
JuMP.num_variables(::InfiniteModel)
JuMP.has_lower_bound(::InfOptVariableRef)
JuMP.lower_bound(::InfOptVariableRef)
JuMP.set_lower_bound(::InfOptVariableRef, ::Number)
JuMP.LowerBoundRef(::InfOptVariableRef)
JuMP.delete_lower_bound(::InfOptVariableRef)
JuMP.has_upper_bound(::InfOptVariableRef)
JuMP.upper_bound(::InfOptVariableRef)
JuMP.set_upper_bound(::InfOptVariableRef, ::Number)
JuMP.UpperBoundRef(::InfOptVariableRef)
JuMP.delete_upper_bound(::InfOptVariableRef)
JuMP.is_fixed(::InfOptVariableRef)
JuMP.fix_value(::InfOptVariableRef)
JuMP.fix(::InfOptVariableRef, ::Number; ::Bool)
JuMP.FixRef(::InfOptVariableRef)
JuMP.unfix(::InfOptVariableRef)
JuMP.start_value(::InfOptVariableRef)
JuMP.set_start_value(::InfOptVariableRef, ::Number)
JuMP.is_binary(::InfOptVariableRef)
JuMP.set_binary(::InfOptVariableRef)
JuMP.BinaryRef(::InfOptVariableRef)
JuMP.unset_binary(::InfOptVariableRef)
JuMP.is_integer(::InfOptVariableRef)
JuMP.set_integer(::InfOptVariableRef)
JuMP.IntegerRef(::InfOptVariableRef)
JuMP.unset_integer(::InfOptVariableRef)
JuMP.name(::InfOptVariableRef)
JuMP.set_name(::InfiniteVariableRef, ::String)
JuMP.set_name(::PointVariableRef, ::String)
JuMP.set_name(::HoldVariableRef, ::String)
parameter_refs(::InfiniteVariableRef)
set_parameter_refs(::InfiniteVariableRef, ::Tuple)
add_parameter_ref(::InfiniteVariableRef,::Union{ParameterRef, AbstractArray{<:ParameterRef}})
@set_parameter_bounds
@add_parameter_bounds
has_parameter_bounds(::HoldVariableRef)
parameter_bounds(::HoldVariableRef)
set_parameter_bounds(::HoldVariableRef, ::ParameterBounds)
add_parameter_bound(::HoldVariableRef, ::ParameterRef, ::Number, ::Number)
delete_parameter_bound(::HoldVariableRef, ::ParameterRef)
delete_parameter_bounds(::HoldVariableRef)
infinite_variable_ref(::PointVariableRef)
parameter_values(::PointVariableRef)
JuMP.variable_by_name(::InfiniteModel, ::String)
JuMP.all_variables(::InfiniteModel)
```