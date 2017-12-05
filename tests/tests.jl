rn = randn(1000)
bi = binindex(rn, equaldistancelimits(rn, 10))
support = binsupport(rn, 1:10)
xvals = map(x->first(x), support)
yvals = map(x->last(x), support)