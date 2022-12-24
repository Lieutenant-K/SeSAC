//
//  TrendTableViewController.swift
//  TrendMedia
//
//  Created by 김윤수 on 2022/07/21.
//

import UIKit

class TrendTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    @IBAction func touchMovieMutton(_ sender: UIButton) {
        
        // 화면 전환: 1. 스토리보드 파일 2. 스토리보드 내 뷰 컨트롤러, 3. 화면 전환
        
        let storyBoard = UIStoryboard(name: "Trend", bundle: nil)
        
        // 뷰 컨트롤러 인스턴스화, 스토리보드 상에서 해당 뷰 컨트롤러 앞에 뭐가 붙었든 영향이 없음.
        let vc = storyBoard.instantiateViewController(withIdentifier: BucketListTableViewController.identifier) as! BucketListTableViewController
        
        vc.placeholder = "영화"
        present(vc, animated: true)
        
    }
    
    @IBAction func touchDramaButton(_ sender: UIButton) {
        
        let storyBoard = UIStoryboard(name: "Trend", bundle: nil)
        
        let vc = storyBoard.instantiateViewController(withIdentifier: BucketListTableViewController.identifier) as! BucketListTableViewController
        
        vc.placeholder = "드라마"
        
        // present 시 화면 전환 방식 설정
        vc.modalPresentationStyle = .fullScreen
        
        present(vc, animated: true)
        
    }
    @IBAction func touchBookButton(_ sender: UIButton) {
        
        let storyBoard = UIStoryboard(name: "Trend", bundle: nil)
        
        let vc = storyBoard.instantiateViewController(withIdentifier: BucketListTableViewController.identifier) as! BucketListTableViewController
        
        vc.placeholder = "도서"
        
        let navi = UINavigationController(rootViewController: vc)
        
        // present 시 화면 전환 방식 설정
        navi.modalPresentationStyle = .fullScreen
        
        // 네비게이션 컨트롤러로 화면 전환 (네비 바 생김)
        present(navi, animated: true)
        
    }
}
