rn = randn(1000)
bi = Binning.binindex(rn, equaldistancelimits(rn, 11))
support = binsupport(bi, 1:11)
xvals = map(x->first(x), support)
yvals = map(x->last(x), support)

sinv = sin.(0:(pi*2/999):pi*2)
bi_sinv = Binning.binindex(sinv, equaldistancelimits(sinv,11))
plot(equaldistancelimits(sinv,11), last.(binsupport(bi_sinv, 1:11)))
