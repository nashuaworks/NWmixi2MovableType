//
//  NWReadFile.swift
//  NWmixi2MovableType
//
//  Created by M on 2019/10/09.
//  Copyright © 2019 M. All rights reserved.
//

import Foundation
import Cocoa

class NWReadFile {
    var withURL: URL
    init(withURL:URL) {
        self.withURL = withURL
    }

    func readTextFile() -> String{
        var fileContents: String = ""
        do {
            fileContents = try String( contentsOf: withURL, encoding: String.Encoding.utf8 )
//            print(fileContents) //読み込んだ内容
        } catch {
            print("NWReadFile:readTextFile", error)
        }
        
        return fileContents
    }

    
}
