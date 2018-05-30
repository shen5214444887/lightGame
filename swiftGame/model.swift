//
//  model.swift
//  swiftGame
//
//  Created by xiaobei on 2018/5/28.
//  Copyright © 2018年 xiaobei. All rights reserved.
//

import Foundation

/// 矩阵模型
struct Matrix {
    var rows: Int
    var columns: Int
}

struct LightSwitch {
    
    // 存放判断灯是否为 1 或 0 的数组
    var lights = [Int]()
    /// 存放谜题的二维数组
    private var puzzles: [[Int]]
    /// 存放答案的二维数组
    private var  press: [[Int]]
    /// 灯
    private var matrix: Matrix
    
    mutating func lightUp(index: Array<Any>.Index?) {
        
        guard let index = index else { return }
        
        var m = Matrix(rows: 0, columns: 0)
        
        // 行
        m.rows = index / matrix.columns + 1
        // 列
        m.columns = (index) % matrix.rows + 1
        
        print(m)
        puzzles[m.rows][m.columns] = puzzles[m.rows][m.columns] == 0 ? 1 : 0
        puzzles[m.rows + 1][m.columns] = puzzles[m.rows + 1][m.columns] == 0 ? 1 : 0
        puzzles[m.rows - 1][m.columns] = puzzles[m.rows - 1][m.columns] == 0 ? 1 : 0
        puzzles[m.rows][m.columns + 1] = puzzles[m.rows][m.columns + 1] == 0 ? 1 : 0
        puzzles[m.rows][m.columns - 1] = puzzles[m.rows][m.columns - 1] == 0 ? 1 : 0
        
        lights.removeAll()
        for r in 1..<matrix.rows + 1 {
            for c in 1..<matrix.columns + 1 {
                lights.append(puzzles[r][c])
            }
        }
    }
    
    init(matrix: Matrix) {
        self.matrix = matrix
        
        self.puzzles = [[Int]](repeating: [Int](repeating: 0, count: matrix.columns + 2), count: matrix.rows + 2)
        self.press = [[Int]](repeating: [Int](repeating: 0, count: matrix.columns + 2), count: matrix.rows + 2)
        
        self.setupLightStatus()
        
        enumerate()
        
        print("=====灯谜排列====")
        for r in 1..<matrix.rows + 1 {
            for c in 1..<matrix.columns + 1 {
                print(puzzles[r][c], terminator: "")
            }
            print()
        }
        print("==============")
        
        print("=====算法结果====")
        for r in 1..<matrix.rows + 1 {
            for c in 1..<matrix.columns + 1 {
                print(press[r][c], terminator: "")
            }
            print()
        }
        print("==============")
    }
}

extension LightSwitch {
    
    mutating private func setupLightStatus() {
        
        self.lights.removeAll()
        for r in 1..<matrix.rows + 1 {
            for c in 1..<matrix.columns + 1 {
                puzzles[r][c] = 2.arc4random
                self.lights.append(puzzles[r][c])
            }
        }
    }
    
    /// 计算结果，枚举第一行的所有可能
    mutating private func enumerate() {
        
        var c = 1
        while !guess() {
            press[1][1] += 1
            c = 1
            while press[1][c] > 1 {
                press[1][c] = 0
                c += 1
                press[1][c] += 1
                if c >= matrix.columns {
                    
                    // 当没有解的时候，重新生成灯数
                    press[1][c] = 1 // 最后一位置为 1
                    print("重新生成灯数")
                    self.setupLightStatus()
                    self.enumerate()
                    return
                }
            }
        }
    }
    
    /// 根据第一行枚举的可能，判断全部灯点亮
    mutating private func guess() -> Bool {
        
        // 根据 press 第一行和 puzzle 数组，计算 press 其他行的值
        for r in 1..<matrix.rows {
            for c in 1...matrix.columns {
                press[r + 1][c] = (puzzles[r][c] + press[r][c] + press[r - 1][c] + press[r][c - 1] + press[r][c + 1]) % 2
            }
        }
        
        // 判断所计算的 press 数组能否熄灭最后一行所有灯
        for c in 1...matrix.columns {
            if (press[matrix.rows][c - 1] + press[matrix.rows][c] + press[matrix.rows][c + 1] + press[matrix.rows - 1][c]) % 2 != puzzles[matrix.rows][c] {
                return false
            }
        }
        
        return true
    }
}
