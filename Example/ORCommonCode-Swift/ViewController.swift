//
//  ViewController.swift
//  ORCommonCode-Swift
//
//  Created by Maxim Soloviev on 04/11/2016.
//  Copyright (c) 2016 Maxim Soloviev. All rights reserved.
//

import UIKit
import ORCommonCode_Swift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let l = UILabel(frame: CGRect(x: 0, y: 44, width: 0, height: 0))
        view.addSubview(l)
        l.numberOfLines = 0
        l.font = UIFont.systemFont(ofSize: 12)
        let bcf = ByteCountFormatter()
        let appSizeStr = bcf.string(fromByteCount: Int64(ORAppInfo.size))
        l.text = "app name: \(ORAppInfo.name)\napp version: \(ORAppInfo.appVersion)\napp update date: \(ORAppInfo.updateDate)\n'Assets.car' update date: \(ORAppInfo.updateDate(fileName: "Assets.car"))\napp size: \(appSizeStr)"
        l.sizeToFit()
    }
}
