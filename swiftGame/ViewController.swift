//
//  ViewController.swift
//  swiftGame
//
//  Created by xiaobei on 2018/5/28.
//  Copyright © 2018年 xiaobei. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet var lights: [UIButton]!
    
    @IBAction func lightUp(_ sender: UIButton) {
        
        switchs?.lightUp(index: lights.index(of: sender))
        setLightStatus()
        
        if Set(switchs!.lights).count == 1 {
            
            let alert = UIAlertController(title: "Congratulation", message: "You made all light up successfully", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "again", style: .default, handler: { [weak self] _ in
                self?.restart()
            }))
            present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func restart(_ sender: UIButton? = nil) {
        
        switchs = LightSwitch(matrix: Matrix(rows: 5, columns: 5))
        setLightStatus()
    }
    
    var switchs: LightSwitch?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        restart()
    }

}

private extension ViewController {
    
    func setLightStatus() {
        
        for (index, light) in self.lights.enumerated() {
            light.isSelected = self.switchs?.lights[index] == 1 ? true : false
        }
    }
    
    func setupUI() {
        
        for light in self.lights {
            light.setBackgroundImage(UIColor.black.toImage, for: [])
            light.setBackgroundImage(UIColor.yellow.toImage, for: .selected)
        }
    }
}

