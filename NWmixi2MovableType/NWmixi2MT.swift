//
//  NWmixi2MT.swift
//  NWmixi2MovableType
//
//  Created by M on 2019/10/12.
//  Copyright © 2019 M. All rights reserved.
//

import Foundation
import Cocoa

class NWmixi2MT {

//    var withURL: URL
//    init(withURL:URL) {
//        self.withURL = withURL
//    }
    
    func mixi2mt() {
                
        // ファイルパスを得る
        let getFilePath = NWGetFilePath()
        let fileURL = getFilePath.getFilePath()
        print (fileURL)
        
        // ファイルパスで指定されたファイルを読み込み
        let readFile = NWReadFile(withURL: fileURL)
        let fileContents = readFile.readTextFile()
        
        // 読み込んだファイルの中身を１行づつ取り出して、必要な行のみにする
        var lineIndex: Int = 0
        var outString: String = ""
        var inTitleAndDate = false
        var inBodyText = false
        fileContents.enumerateLines{
            line, stop in
            //下記に１行ごとに行いたい動作を記述
            //            print("\(lineIndex) : \(line)")
            lineIndex += 1
            
            // 日付とタイトルの行を取り出して以下の２行にする
            // TITLE: タイトル
            // DATE: 06/06/2010 21:18:00
            //
            if (!inTitleAndDate) {
                if (line.hasPrefix("<div class=\"listDiaryTitle\">")) {
                    print("\(lineIndex) : \(line)")
                    inTitleAndDate = true
                }
            }
            
            if (inTitleAndDate) {
                if (line.hasPrefix("<dt>")) {
                    print("\(lineIndex) : \(line)")
                    outString = outString + line
                }
                if (line.hasPrefix("<dd class=\"date\">")) {
                    print("\(lineIndex) : \(line)")
                    outString = outString + line
                }
                if (line.hasPrefix("</div>")) {
                    inTitleAndDate = false
                }
            }
            
            // ボディ取り出し
            if (!inBodyText) {
                if (line.hasPrefix("<div id=\"diary_body\" class=\"FANCYURL_EMBED widget\"")) {
                    print("\(lineIndex) : \(line)")
                    outString = outString + line
                    inBodyText = true
                }
            }
            if (inBodyText) {
                print("\(lineIndex) : \(line)")
                if (line.hasPrefix("</div>")) {
                    inBodyText = false
                }
                outString = outString + line
            }
            
        }
        //        print ("outString:", outString)
        
        // 加工データを書き込み
        var outFileURL = fileURL.deletingPathExtension()
        print("\(outFileURL)")
        outFileURL = outFileURL.appendingPathExtension("MT")
        print("\(outFileURL)")
        
        // You don’t have permission to save the file が出たら、
        // TARGETS の Setting & Capabilities の
        // App Sandbox の File Access Type を "Read/Write" にすると解決。
        /*
         
         do {
         //            try outString.write(to: outFileURL, atomically: false, encoding: String.Encoding.utf8)
         //            try outString.write(toFile: "/Users/nagamatu/Documents/mixi_export/log2/200606/a.www", atomically: false, encoding: String.Encoding.utf8)
         try outString.write(toFile: "/Users/nagamatu/Documents/mixi_export/log2/200606/a.txt", atomically: false, encoding: String.Encoding.utf8)
         } catch {
         print("ViewController:outString.write", error)
         }
         
         */
        
        let savePanel = NSSavePanel()
        savePanel.canCreateDirectories = true
        savePanel.showsTagField = false
        savePanel.nameFieldStringValue = "a.www"
        
        let result = savePanel.runModal()
        if (result == NSApplication.ModalResponse.OK) {
            if let fileURL = savePanel.url {
                print("fileURL", fileURL)
                // ここでファイルに書き込む
                do {
                    try outString.write(to: fileURL, atomically: false, encoding: String.Encoding.utf8)
                } catch {
                    print("ViewController:outString.write", error)
                }
                
            } else {
                print("########:ERROR -11NWGetFilePath")
            }
        }
        
        //        savePanel.begin { (result) in
        //            if result.rawValue == NSApplication.ModalResponse.OK.rawValue {
        //                guard let outFileURL = savePanel.url else {
        //                    print("ViewController:savePanel.url")
        //                    return
        //                }
        //            }
        //        }

    }
        
}
