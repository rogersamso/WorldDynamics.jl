tables = Dict{Symbol,Tuple{Vararg{Number}}}(
    :brmm => (1.2, 1.0, 0.85, 0.75, 0.7, 0.7),
    :brcm => (1.05, 1.0, 0.9, 0.7, 0.6, 0.55),
    :brfm => (0.0, 1.0, 1.6, 1.9, 2.0),
    :brpm => (1.02, 0.9, 0.7, 0.4, 0.25, 0.15, 0.1),
    :drmm => (3.0, 1.8, 1.0, 0.8, 0.7, 0.6, 0.53, 0.5, 0.5, 0.5, 0.5),
    :drpm => (0.92, 1.3, 2.0, 3.2, 4.8, 6.8, 9.2),
    :drfm => (30.0, 3.0, 2.0, 1.4, 1.0, 0.7, 0.6, 0.5, 0.5),
    :drcm => (0.9, 1.0, 1.2, 1.5, 1.9, 3.0),
)

ranges = Dict{Symbol,Tuple{Number,Number}}(
    :brmm => (0, 5),
    :brcm => (0, 5),
    :brfm => (0, 4),
    :brpm => (0, 60),
    :drmm => (0, 5),
    :drpm => (0, 60),
    :drfm => (0, 2),
    :drcm => (0, 5),
)