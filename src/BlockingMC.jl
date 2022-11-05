module BlockingMC

# Write your package code here.
using Statistics: mean
include("BlockingMCCore.jl")

function applyBlocking(npoints, nb, etlist)
    blockvalslist = zeros(Float64, (npoints, nb));
    block_list!(nb, etlist[end-npoints+1:end], blockvalslist)
    meanet = mean(etlist[end-npoints+1:end])

    # Variance list
    varlist=map(y->(
        (view(blockvalslist,1:(npoints>>y),y).|>
            x->cf(x,x,npoints >> y,0,meanet))
        |> sum ) |> z-> sqrt(z/(npoints>>y)), 1:nb-1)

    # Confidence of the variance list
    varlisterror=map(y->(
        (view(blockvalslist,1:(npoints>>y),y).|>
            x->cf(x,x,npoints >> y,0,meanet))
        |> sum ) |>
            z-> sqrt(z/(npoints>>y)) * sqrt(1/(2*((npoints>>y)-1)))
                     , 1:nb-1)

    return(varlist, varlisterror)
end

end
