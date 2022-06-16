using ModelingToolkit, DifferentialEquations

include("../common_pop/CommonPop.jl")
include("Pop4.jl")


@named pop = Pop4.population()

@named dr = CommonPop.death_rate()
@named br = CommonPop.birth_rate()

@named io = CommonPop.industrial_output()
@named so = CommonPop.service_output()
@named pp = CommonPop.persistent_pollution()
@named f  = CommonPop.food()


connection_eqs = [
    # pop4    
    pop.le ~ dr.le
    pop.tf ~ br.tf
    # common pop
    dr.fpc ~ f.fpc
    dr.sopc ~ so.sopc
    dr.iopc ~ io.iopc
    dr.ppolx ~ pp.ppolx
    br.le ~ dr.le
    br.iopc ~ io.iopc
    br.sopc ~ so.sopc
    # pop4 + common pop
    dr.dr ~ pop.dr
    dr.pop ~ pop.pop
    br.br ~ pop.br
    br.pop ~ pop.pop
    io.pop ~ pop.pop
    so.pop ~ pop.pop
    f.pop ~ pop.pop
]


@variables t

@named _pop_model = ODESystem(connection_eqs, t)
@named pop_model = compose(_pop_model, [pop, dr, br, io, so, pp, f])

pop_sys = structural_simplify(pop_model)

prob = ODEProblem(pop_sys, [], (1900, 1970.0))
sol = solve(prob, Tsit5())


using PlotlyJS

function plot_sol_2_84(sol)
    traces = GenericTrace[]
    push!(traces, scatter(x=sol[t], y=sol[pop.pop], name="pop",  yaxis="y1"))
    push!(traces, scatter(x=sol[t], y=sol[br.cbr],  name="cbr",  yaxis="y2"))
    push!(traces, scatter(x=sol[t], y=sol[dr.cdr],  name="cdr",  yaxis="y3"))
    push!(traces, scatter(x=sol[t], y=sol[so.sopc], name="sopc", yaxis="y4"))
    push!(traces, scatter(x=sol[t], y=sol[dr.fpu],  name="fpu",  yaxis="y5"))
    push!(traces, scatter(x=sol[t], y=sol[f.fpc],   name="fpc",  yaxis="y6"))
    push!(traces, scatter(x=sol[t], y=sol[dr.le],   name="le",   yaxis="y7"))
    push!(traces, scatter(x=sol[t], y=sol[br.fce],  name="fce",  yaxis="y8"))
    push!(traces, scatter(x=sol[t], y=sol[io.iopc], name="iopc", yaxis="y9"))
    plot(traces,
        Layout(xaxis_domain=[0.3, 0.7],
            yaxis  = attr(title="pop", range=[0, 1.6e10]),
            yaxis2 = attr(title="cbr",  overlaying="y", side="right", position=0.70, range=[0, 50]),
            yaxis3 = attr(title="cdr",  overlaying="y", side="right", position=0.74, range=[0, 50]),
            yaxis4 = attr(title="sopc", overlaying="y", side="right", position=0.78, range=[0, 1000]),
            yaxis5 = attr(title="fpu",  overlaying="y", side="right", position=0.82, range=[0, 1]),
            yaxis6 = attr(title="fpc",  overlaying="y", side="right", position=0.86, range=[0, 1000]),
            yaxis7 = attr(title="le",   overlaying="y", side="right", position=0.9,  range=[0, 80]),
            yaxis8 = attr(title="fce",  overlaying="y", side="right", position=0.94, range=[0.5, 1]),
            yaxis9 = attr(title="iopc", overlaying="y", side="right", position=0.98, range=[0, 1000])
        )
    )
end

function plot_sol_2_85(sol)
    popsum = sol[pop.p1] + sol[pop.p2] + sol[pop.p3] + sol[pop.p4]
    traces = GenericTrace[]
    push!(traces, scatter(x=sol[t], y=sol[pop.p1] ./ popsum, name="p1", yaxis="y1"))
    push!(traces, scatter(x=sol[t], y=sol[pop.p2] ./ popsum, name="p2", yaxis="y2"))
    push!(traces, scatter(x=sol[t], y=sol[pop.p3] ./ popsum, name="p3", yaxis="y3"))
    push!(traces, scatter(x=sol[t], y=sol[pop.p4] ./ popsum, name="p4", yaxis="y4"))
    plot(traces,
        Layout(xaxis_domain=[0.3, 0.7],
            yaxis  = attr(title="p1", range=[0, 1]),
            yaxis2 = attr(title="p2", overlaying="y", side="right", position=0.70, range=[0, 1]),
            yaxis3 = attr(title="p3", overlaying="y", side="right", position=0.74, range=[0, 1]),
            yaxis4 = attr(title="p4", overlaying="y", side="right", position=0.78, range=[0, 1])
        )
    )
end
