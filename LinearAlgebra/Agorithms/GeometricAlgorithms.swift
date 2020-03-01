//
//  GeometricAlgorithms.swift
//  LinearAlgebra
//
//  Created by Nikita on 28.02.2020.
//  Copyright © 2020 Nikita Kiselov. All rights reserved.
//

import Foundation

//angle between vectors in radians
public func angle(_ a:Vector, _ b:Vector)->Double{
    return acos(a*b/b.norm/a.norm)
}

//Project "v" vector on space defined by "t" vector
public func project(_ v:Vector, on t:Vector)->Vector{
    return t*((v*t)/v.sqrNorm)
}

public func normalize(_ v:Vector)->Vector{
    return v/v.norm
}

//applies gram-schmidt orthogonalization process to create orthonormal basis from any basis
public func gramSchmidt(_ basis:[Vector])->[Vector]{
    var newBasis:[Vector]=[]
    for i in 0..<basis.count{
        var vector = basis[i]
        for j in 0..<newBasis.count{
            vector=vector-(vector*newBasis[j])*newBasis[j]
        }
        newBasis.append(normalize(vector))
    }
    return newBasis
}
