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
    
    lazy var number: Int = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy-MM-dd"
        let date = formatter.date(from: "2002-12-07")!
        
        let number = Date().timeIntervalSince(date) / (7*60*60*24) + 1
        
        return Int(number)
    }()
    
    var numberList: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
        let date = Calendar.current.date(from: DateComponents(year:2020, month:12, day:27))!
        print(formatter.string(from: date))
        */
        
        numberList = Array(1...number).reversed()
        
        numberTextField.inputView = pickerView
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        configureLottoLabel()
        
        showLottoNumber(number: number)
    }
    
    func configureLottoLabel() {
        
        for label in self.numberLabelStackView.arrangedSubviews {
            if let label = label as? UILabel {
                label.textAlignment = .center
                label.layer.cornerRadius = label.bounds.width/2
                label.clipsToBounds = true
                label.text = ""
            }
        }
    }
    
    func displayLottoNumber(numbers: [Int]){
        for index in (0..<7) {
            if let label = self.numberLabelStackView.arrangedSubviews[index] as? UILabel {
                label.text = String(numbers[index])
            }
        }
    }
    
    func showLottoNumber(number: Int) {
        
        if let numbers = UserDefaults.standard.array(forKey: "\(number)") as? [Int] {
            print("데이터 재활용", numbers)
//            print("재활용")
            displayLottoNumber(numbers: numbers)
        } else { requestLotto(number: number) }
        
        
        
    }
    
    func requestLotto(number: Int) {
        
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(number)"
        
        AF.request(url, method: .get).validate(statusCode: 200..<300).responseJSON { response in
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                
                if json["returnValue"].stringValue == "fail" {
                    return
                }

                let lottoNumbers = (Array(1...6).map { json["drwtNo\($0)"].intValue }) + [json["bnusNo"].intValue]
                
                print("저장해라")
                UserDefaults.standard.set(lottoNumbers, forKey: "\(number)")
                
                self.displayLottoNumber(numbers: lottoNumbers)
                
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
        return number
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(numberList[row])회차"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        showLottoNumber(number: numberList[row])
    }
    
}


