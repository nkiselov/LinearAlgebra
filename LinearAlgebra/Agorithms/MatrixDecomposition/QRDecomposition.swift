//
//  QRDecomposition.swift
//  LinearAlgebra
//
//  Created by Nikita on 28.02.2020.
//  Copyright © 2020 Nikita Kiselov. All rights reserved.
//

import Foundation

public class QRDecomposition:MatrixDecomposition{
    public var q:Matrix
    public var r:Matrix
    public required init(_ a: Matrix) {
        let aColumns = a.getColumns()
        let qColumns = gramSchmidt(aColumns)
        let r = Matrix(qColumns.count, a.columnsCount)
        for j in 0..<r.columnsCount{
            for i in 0..<j+1{
                r[i,j] = aColumns[j]*qColumns[i]
            }
        }
        q=Matrix(columns: qColumns)
        self.r=r
    }
}
