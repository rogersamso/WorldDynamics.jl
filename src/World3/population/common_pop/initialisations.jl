inits = Dict{Symbol, Number}()

inits[:t0] = 1900
inits[:pop0] = 1.61e9
inits[:sopc0] = 1.5e11 / inits[:pop0]
inits[:hsapc0] = interpolate(inits[:sopc0], tables[:hsapc], ranges[:hsapc])
inits[:ehspc0] = inits[:hsapc0]
inits[:fpc0] = 4e11 / inits[:pop0]
inits[:lmf0] = interpolate(inits[:fpc0] / params[:sfpc], tables[:lmf], ranges[:lmf])
inits[:lmhs0] = interpolate(inits[:ehspc0], tables[:lmhs1], ranges[:lmhs1])
inits[:ppolx0] = 1.0
inits[:lmp0] = interpolate(inits[:ppolx0], tables[:lmp], ranges[:lmp])
inits[:iopc0] = 0.7e11 / inits[:pop0]
inits[:cmi0] = interpolate(inits[:iopc0], tables[:cmi], ranges[:cmi])
inits[:fpu0] = interpolate(inits[:pop0], tables[:fpu], ranges[:fpu])
inits[:lmc0] = 1 - inits[:cmi0] * inits[:fpu0]
inits[:le0] = params[:len] * inits[:lmf0] * inits[:lmhs0] * inits[:lmp0] * inits[:lmc0]
inits[:fm0] = interpolate(inits[:le0], tables[:fm], ranges[:fm])
inits[:mtf0] = params[:mtfn] * inits[:fm0]
inits[:frsn0] = 0.82
inits[:sfsn0] = interpolate(inits[:iopc0], tables[:sfsn], ranges[:sfsn])
inits[:dcfs0] = params[:dcfsn] * inits[:frsn0] * inits[:sfsn0]
inits[:ple0] = inits[:le0]
inits[:cmple0] = interpolate(inits[:ple0], tables[:cmple], ranges[:cmple])
inits[:dtf0] = inits[:dcfs0] * inits[:cmple0]
inits[:nfc0] = inits[:mtf0] / inits[:dtf0] - 1.0
inits[:fsafc0] = interpolate(inits[:nfc0], tables[:fsafc], ranges[:fsafc])
inits[:fcapc0] = inits[:fsafc0] * inits[:sopc0]
inits[:fcfpc0] = inits[:fcapc0]
inits[:fce0] = interpolate(inits[:fcfpc0], tables[:fce], ranges[:fce])
inits[:tf0] = min(inits[:mtf0], inits[:mtf0] * (1 - inits[:fce0]) + inits[:dtf0] * inits[:fce0])
inits[:br0] = inits[:tf0] * inits[:pop0] * params[:ffw] / params[:rlt]
inits[:cbr0] = 1000 * inits[:br0] / inits[:pop0]
