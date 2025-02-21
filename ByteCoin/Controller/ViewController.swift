//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource {
    
    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        currencyPicker.dataSource = self
    }

    // 피커뷰의 열 개수 설정
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // 행 개수 설정
    let coinManager = CoinManager()
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    
}

