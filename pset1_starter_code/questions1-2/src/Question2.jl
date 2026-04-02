
using Random

function lastKDigits(n, k)
    # returns the last k digits of n, as a string
    # pads with 0s if necessary
    s = string(n)
    if length(s) < k
        s = "0"^(k - length(s)) * s
    end
    return s[end-k+1:end]
end

struct LKDTerm
    k::Int64
    augend::Int64
end

LKDProgram = Tuple{LKDTerm,LKDTerm,LKDTerm,LKDTerm}

function interpretLKDTerm(term::LKDTerm, x::Int64)
    return lastKDigits(term.augend + x, term.k)
end

function interpretLKDProgram(program::LKDProgram, x::Int64)
    return interpretLKDTerm(program[1], x) *
           interpretLKDTerm(program[2], x) *
           interpretLKDTerm(program[3], x) *
           interpretLKDTerm(program[4], x)
end

example_lkd = (Pset1.LKDTerm(2, 3), Pset1.LKDTerm(3, 537), Pset1.LKDTerm(4, 82), Pset1.LKDTerm(5, 87))

function sampleLKDProgram(seed)
    Random.seed!(seed)
    terms = []
    for i in 1:4
        k = rand(2:5)
        augend = rand(1:100_000)
        push!(terms, LKDTerm(k, augend % 10^k))
    end
    return tuple(terms...)
end

function positive_modulus(x, y)
    # returns x % y, but always positive
    return (x % y + y) % y
end


function structured(inputoutputs::Vector{Tuple{Int64,String}})::LKDProgram
    first_input, first_output = inputoutputs[1]
    L = length(first_output)

    # Enumerate all (k1,k2,k3,k4) with each ki in {2..5} that sum to L
    for k1 in 2:5, k2 in 2:5, k3 in 2:5
        k4 = L - k1 - k2 - k3
        (k4 < 2 || k4 > 5) && continue

        # Deduce augend values from the first example using this split
        splits = (0, k1, k1+k2, k1+k2+k3, L)
        ks = (k1, k2, k3, k4)
        augs = ntuple(i -> positive_modulus(
            parse(Int64, first_output[splits[i]+1:splits[i+1]]) - first_input,
            10^ks[i]), 4)

        candidate = (LKDTerm(k1, augs[1]), LKDTerm(k2, augs[2]),
                     LKDTerm(k3, augs[3]), LKDTerm(k4, augs[4]))

        # Verify against all examples
        if all(interpretLKDProgram(candidate, x) == y for (x, y) in inputoutputs)
            return candidate
        end
    end

    error("No solution exists")
end
