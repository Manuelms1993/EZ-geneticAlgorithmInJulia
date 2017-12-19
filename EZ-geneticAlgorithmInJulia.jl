function fitness(pop)
    for i = 1:size(pop)[1]
        
        sum = 0
        for j = 1:size(pop)[2]-1
            if pop[i,j] == 1
                sum += 1
            end
        end
        
        pop[i,size(pop)[2]] = sum
        
    end
    
    return(sortrows(pop, by=x->(x[size(pop)[2]]), rev=true))
end

initializePopulation(n_pop) = return (rand(0:1,n_pop,50))

function selection(pop)
    a = Int64(size(pop)[1]/2)
    newPop = rand(0:1,a,50)
    newPop[1,:] = pop[1,:]
    newPop[2,:] = pop[2,:]
    for i = 1:(a)-2
        r = rand(1:size(pop)[1])
        newPop[i+2,:] = pop[r,:]
    end
    return(newPop)
end

function crossover(popSelected)
    
    newPop = rand(0:1,size(popSelected)[1]*2,50)
    newPop[1:50,:] = popSelected[1:50,:]
	
    for i = 1:size(popSelected)[1]
        r1 = rand(1:size(popSelected)[1])
        r2 = rand(1:size(popSelected)[1])
        ind1 = popSelected[r1,:]
        ind2 = popSelected[r2,:]
        ind3 = popSelected[r2,:]
        
        for j = 1:size(ind1)[1]
            ind3[j] = rand(1:2) == 1 ? ind1[j] : ind2[j]
        end
        
        newPop[i+50,:] = ind3
    end
    
    return(newPop)
end

function mutate(popCross)
	
    for i = 1:size(popCross)[1]
        r1 = rand(1:100)
	if r1 < 6
	    r = rand(1:49)
	    popCross[i,r] = popCross[i,r] == 1 ? 0 : 1
	end
    end

    return(popCross)

end

n_pop = 100
epochs = 100
pop = initializePopulation(n_pop)
pop = fitness(pop)


for i = 1:epochs
    
    println("Iteration: ",i)
    popSelected = selection(pop)
    popCross = crossover(popSelected)
    pop = mutate(popCross)
    pop = fitness(pop)
    
end

println(pop[1,:])

