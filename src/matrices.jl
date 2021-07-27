# degree matrix
degree_matrix(x::T) where {T<:AbstractHyperGraph} = Diagonal(degrees(x))

# incidence matrix (oriented case)
@traitfn function incidence_matrix(x::T::IsOriented) where {T<:AbstractHyperGraph}
    idx = vertices_to_indices(x)
    I = zeros(Int, nv(x), nhe(x))
    @inbounds for (i, e) in enumerate(hyperedges(x))
        [I[idx[v], i] -= s for (v, s) in zip(objects(e.src), src_multiplicities(e))]
        [I[idx[v], i] += s for (v, s) in zip(objects(e.tgt), tgt_multiplicities(e))]
    end
    I
end
