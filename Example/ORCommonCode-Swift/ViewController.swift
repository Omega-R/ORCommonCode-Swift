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
        
        let appInfoLabel = UILabel(frame: CGRect(x: 0, y: 44, width: 0, height: 0))
        view.addSubview(appInfoLabel)
        appInfoLabel.numberOfLines = 0
        appInfoLabel.font = UIFont.systemFont(ofSize: 12)
        let bcf = ByteCountFormatter()
        let appSizeStr = bcf.string(fromByteCount: Int64(ORAppInfo.size))
        appInfoLabel.text = "app name: \(ORAppInfo.name)\napp version: \(ORAppInfo.appVersion)\napp update date: \(ORAppInfo.updateDate)\n'Assets.car' update date: \(ORAppInfo.updateDate(fileName: "Assets.car"))\napp size: \(appSizeStr)"
        appInfoLabel.sizeToFit()

        let avgLabel = UILabel(frame: CGRect(x: 0, y: 150, width: 0, height: 0))
        view.addSubview(avgLabel)
        avgLabel.numberOfLines = 0
        avgLabel.font = UIFont.systemFont(ofSize: 12)
        
        let values = [5, 10, 15]
        let avgCalc = ORMath.AverageValueCalculator()
        values.forEach({ avgCalc.addValue(Double($0)) })
        avgLabel.text = "values: \(values.map({ "\($0)" }).joined(separator: ", ")), avg value: \(avgCalc.avgValue)"
        avgLabel.sizeToFit()
    }
}
