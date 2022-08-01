//
//  LottoViewController.swift
//  NetworkBasic
//
//  Created by 김윤수 on 2022/07/28.
//

import UIKit

import Alamofire
import SwiftyJSON

class LottoViewController: UIViewController {
    
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var numberLabelStackView: UIStackView!
    
    //    @IBOutlet weak var pickView: UIPickerView!
    
    var pickerView = UIPickerView()
    
    let numberList: [Int] = Array(1...1026).reversed()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        numberTextField.inputView = pickerView
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        configureLottoLabel()
        
        requestLotto(number: 1026)
    }
    
    func configureLottoLabel() {
        
        for i in 0..<7 {
            
            if let label = self.numberLabelStackView.arrangedSubviews[i] as? UILabel {
                
                label.textAlignment = .center
                label.layer.cornerRadius = label.bounds.width/2
                label.clipsToBounds = true
            }
        }
        
    }
    
    func requestLotto(number: Int) {
        
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(number)"
        AF.request(url, method: .get).validate(statusCode: 200..<300).responseJSON { response in
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                
                for i in 1...7 {
                    
                    if let label = self.numberLabelStackView.arrangedSubviews[i-1] as? UILabel {
                        
                        label.text = String(json[i<7 ? "drwtNo\(i)" : "bnusNo"].intValue)
                        
                    }
                }
                
                self.numberTextField.text = json["drwNoDate"].stringValue
                
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
}

extension LottoViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 1026
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(numberList[row])회차"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        requestLotto(number: numberList[row])
    }
    
}


