module BlockingMC

# Write your package code here.

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

function cf(x,y,Nlist,t,mean)
    return((x-mean) * (y-mean)/(Nlist-t))
end

function varblock(x,y,Nlist,t,mean)
    c0 = cf(x,y,Nlist,t,mean);
    return(sqrt(c0/(Nlist-1)))
end

function block_list!(nb,valslist,blockvalslist)
    dimlist = size(valslist,1)
    for ib in 1:nb
        idx=1
        if ib == 1
            for ik in 2:2:dimlist
                blockvalslist[idx,ib] =
                    (valslist[ik-1]+valslist[ik])/2
                idx += 1;
            end
        else
            for ik in 2:2:dimlist
                blockvalslist[idx,ib] =
                    (blockvalslist[ik-1,ib-1]+blockvalslist[ik,ib-1])/2
                idx += 1;
            end
        end
        dimlist = dimlist >> 1;
    end
end

end
