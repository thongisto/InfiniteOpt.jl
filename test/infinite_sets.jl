# Test supports_in_set functions
@testset "supports_in_set" begin
    # supports_in_set (IntervalSet)
    @testset "IntervalSet" begin
        set = IntervalSet(0, 1)
        @test supports_in_set(0, set)
        @test !supports_in_set(-1, set)
        @test !supports_in_set(2, set)
    end
    # supports_in_bounds (UnivariateDistribution set)
    @testset "Univariate Distribution" begin
        set = DistributionSet(Uniform())
        @test supports_in_set(0, set)
        @test !supports_in_set(-1, set)
        @test !supports_in_set(2, set)
    end
    # supports_in_set (Fallback)
    @testset "Fallback" begin
        @test supports_in_set(0, BadSet())
    end
end

# Test lower bound functions
@testset "Lower Bound" begin
    set1 = IntervalSet(0, 1)
    set2 = DistributionSet(Uniform())
    set3 = BadSet()
    # JuMP.has_lower_bound
    @testset "JuMP.has_lower_bound" begin
        @test has_lower_bound(set1)
        @test has_lower_bound(set2)
        @test !has_lower_bound(set3)
    end
    # JuMP.lower_bound
    @testset "JuMP.lower_bound" begin
        @test lower_bound(set1) == 0.0
        @test lower_bound(set2) == 0.0
        @test_throws ErrorException lower_bound(set3)
    end
    # JuMP.set_lower_bound
    @testset "JuMP.set_lower_bound" begin
        @test set_lower_bound(set1, 0.5) == IntervalSet(0.5, 1)
        @test_throws ErrorException set_lower_bound(set2, 2)
        @test_throws ErrorException set_lower_bound(set3, 2)
    end
end

# Test upper bound functions
@testset "Upper Bound" begin
    set1 = IntervalSet(0, 1)
    set2 = DistributionSet(Uniform())
    set3 = BadSet()
    # JuMP.has_upper_bound
    @testset "JuMP.has_upper_bound" begin
        @test has_upper_bound(set1)
        @test has_upper_bound(set2)
        @test !has_upper_bound(set3)
    end
    # JuMP.upper_bound
    @testset "JuMP.upper_bound" begin
        @test upper_bound(set1) == 1.0
        @test upper_bound(set2) == 1.0
        @test_throws ErrorException upper_bound(set3)
    end
    # JuMP.set_upper_bound
    @testset "JuMP.set_upper_bound" begin
        @test set_upper_bound(set1, 0.5) == IntervalSet(0, 0.5)
        @test_throws ErrorException set_upper_bound(set2, 2)
        @test_throws ErrorException set_upper_bound(set3, 2)
    end
end

# Test support generation
@testset "generate_support_values" begin
    @testset "IntervalSet" begin
        set = IntervalSet(0., 1.)
        @test generate_support_values(set, num_supports = 10, sig_fig = 3) isa Vector{<:Number}
        @test generate_support_values(set, num_supports = 10, sig_fig = 3)[2] == 0.111
        @test generate_support_values(set, num_supports = 10, sig_fig = 3)[2] != 1/11
        @test length(generate_support_values(set, num_supports = 10, sig_fig = 3)) == 10
    end
    @testset "DistributionSet" begin
        dist1 = Normal(0., 1.)
        dist2 = MvNormal([0.; 0.], [1. 0.; 0. 2.])
        set1 = DistributionSet(dist1)
        set2 = DistributionSet(dist2)
        @test generate_support_values(set1, num_supports = 10) isa Vector{<:Number}
        @test generate_support_values(set2, num_supports = 10) isa Array{<:Number, 2}
        @test length(generate_support_values(set1, num_supports = 10)) == 10
        @test size(generate_support_values(set2, num_supports = 10)) == (2, 10)
    end
    @testset "Fallback" begin
        @test_throws ErrorException generate_support_values(BadSet())
    end
end
