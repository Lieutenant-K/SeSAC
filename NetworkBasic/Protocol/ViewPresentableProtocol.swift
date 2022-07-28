//
//  ViewPresentableProtocol.swift
//  NetworkBasic
//
//  Created by 김윤수 on 2022/07/28.
//

import UIKit

// 프로토콜은 규약이자 필요한 요소를 명세만 할뿐, 실질적인 구현부는 작성하지 않는다.
// 실질적인 구현은 프로토콜을 채택, 준수하는 타입이 담당한다.
// 클래스, 구조체, 열거형, 익스텐션
// @objc optional -> 선택적 요청. (optional Requirement)

// 프로퍼티 프로토콜 : 연산 프로퍼티로 쓰던 저장 프로퍼티로 쓰던 구현만 하면 된다.
// 따라서 프로퍼티 프로토콜은 무조건 var로 선언해야 한다.
//
@objc protocol ViewPresentableProtocol {
    
    var newTitle: String { get set }
    var backgroundColor: UIColor { get }
    var identifier: String { get }
    
    func configureView()
    func configureLabel()
    
    @objc optional func configurTextFiedl()
}
