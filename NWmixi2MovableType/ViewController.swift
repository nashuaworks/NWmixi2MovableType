//
//  ViewController.swift
//  NWmixi2MovableType
//
//  Created by M on 2019/10/08.
//  Copyright © 2019 M. All rights reserved.
//

import Cocoa
import Foundation
import AppKit


class ViewController: NSViewController {
    
    
    @IBOutlet weak var myPorgressBar: NSProgressIndicator!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        myPorgressBar.minValue = 0.0
        myPorgressBar.maxValue = 1.0
        myPorgressBar.doubleValue = 0.9
        
        let mixi2mt = NWmixi2MT()
        mixi2mt.mixi2mt()
        
        
        
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

