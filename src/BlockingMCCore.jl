using Statistics

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
