//
//  NWGetFilePath.swift
//  NWmixi2MovableType
//
//  Created by M on 2019/10/08.
//  Copyright © 2019 M. All rights reserved.
//

import Foundation
import Cocoa

class NWGetFilePath {
    
    
    func getFilePath() -> URL{
        let openPanel = NSOpenPanel()
        openPanel.allowsMultipleSelection = true   //複数ファイルの選択
        openPanel.canChooseDirectories    = false   //フォルダの選択
        openPanel.canCreateDirectories    = false   //ディレクトリの作成
        openPanel.canChooseFiles          = true    //ファイルの選択
        openPanel.allowedFileTypes        = ["txt","csv"] //ファイルの種類

//        let fileURL: URL? = URL(string: "")
        let result = openPanel.runModal()
        if (result == NSApplication.ModalResponse.OK) {
            if let fileURL = openPanel.url {
                print("fileURL", fileURL)
                return fileURL
            } else {
                print("########:ERROR -11NWGetFilePath")
            }
        }
        return URL(string: "error")!
    }

        
    // 複数のファイルパスを返す
    func getFilePaths() -> Array<URL>{
        var fileContent: String = ""
        
        let openPanel = NSOpenPanel()
        openPanel.allowsMultipleSelection = true   //複数ファイルの選択
        openPanel.canChooseDirectories    = false   //フォルダの選択
        openPanel.canCreateDirectories    = false   //ディレクトリの作成
        openPanel.canChooseFiles          = true    //ファイルの選択
        openPanel.allowedFileTypes        = ["txt","csv","jpg","jpeg"] //ファイルの種類
        
        let reault = openPanel.runModal()
        if( reault == NSApplication.ModalResponse.OK ) {
            //            if let panelURL = openPanel.url {
            //                let path:String = panelURL.path
            //                print(path)
            //                //処理
            //            }
            // 複数ファイルを選択してそのファイルをチェック
            for fileURL in openPanel.urls {
                let filePath :String! = fileURL.path
                print(filePath as String)
            }
            
            // ファイルはひとつだけ
            if let fileURL = openPanel.url { //fileURLはユーザーが指定（＝合法的に取得）したパスなので、開ける。
                do {
                    //                   let fileContent:String = try String( contentsOf: fileURL, encoding: String.Encoding.utf8 )
                    fileContent = try String( contentsOf: fileURL, encoding: String.Encoding.utf8 )
                    print(fileContent) //読み込んだ内容
                } catch {
                    print("String:191", error)
                }
            }
        }
        
        var lineIndex: Int = 0
        fileContent.enumerateLines{
            line, stop in
            
            //下記に１行ごとに行いたい動作を記述
            print("\(lineIndex) : \(line)")
            lineIndex += 1
        }
        
        
        //       let a = [1, 2, 3]
        return openPanel.urls
    }

}
