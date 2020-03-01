//
//  AlgebraicAlgorithms.swift
//  LinearAlgebra
//
//  Created by Nikita on 28.02.2020.
//  Copyright © 2020 Nikita Kiselov. All rights reserved.
//

import Foundation

func abs(_ a:Matrix)->Matrix{
    let res = a.copy()
    for r in 0..<res.rowsCount{
        for c in 0..<res.rowsCount{
            res[r, c] = abs(res[r, c])
        }
    }
    return res
}
