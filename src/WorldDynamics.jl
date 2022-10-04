module WorldDynamics

include("plotvariables.jl")
include("solvesystems.jl")
include("functions.jl")

export plotvariables
export solve
export interpolate, clip, switch, step

using ModelingToolkit

@register interpolate(x, y::Tuple{Vararg{Float64}}, xs::Tuple{Float64, Float64})
@register clip(f1, f2, va, th)
@register switch(v1, v2, z)
@register step(t, hght, sttm)

include("World2/World2.jl")
include("World3/World3.jl")

export World2
export World3

end
