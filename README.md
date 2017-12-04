Binning.jl
Helper functions to pre-process continuous data by quantizing it into discrete bins.

With binning, continuous data is fit to finite sized ranges, we call bins, that allow for groups of points to be handled discretely. There is some data loss, but we accept that data loss by gaining the ability to do further analysis. How the bins are set is important. If bins are set up incorrectly it may be very difficult to get useful results. For example, if your data has a strong left or right bias, the majority of the data may end up in one or two bins. This library has flexible bin widths. You can set your own exactly as you like, or you can use the included methods to set equal distance bins, equal frequency bins, as well as left tailed and right tailed bins.

```julia
da = DataArray(rand(10000000))
group_bins(da, :X, range(0.0, 0.5, 20))
```
