//
//  WriteViewController.swift
//  SesacMemo
//
//  Created by 김윤수 on 2022/09/01.
//

import UIKit
import RxCocoa
import RxSwift

final class WriteViewController: BaseViewController {
    
    // MARK: - Properties
    
    let writeView = WriteViwe()
    
    private let disposeBag = DisposeBag()
    
    let viewModel: WriteViewModel
    
    lazy var completeButton = UIBarButtonItem(title: "완료", style: .plain, target: nil, action: nil)
    
    lazy var shareButton = UIBarButtonItem(image: .init(systemName: "square.and.arrow.up"), style: .plain, target: nil, action: nil)
    
    
    // MARK: - LifeCycle
    
    override func loadView() {
        view = writeView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        binding()
        
        self.navigationController?.setToolbarHidden(true, animated: true)
        
        writeView.textView.text = viewModel.currentMemo.content
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if writeView.textView.text.isEmpty {
            writeView.textView.becomeFirstResponder()
        }
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print(#function)
        
        viewModel.saveChanges(content: writeView.textView.text) {
            showAlert(title: "작업에 실패했습니다.", message: "다시 시도해주세요")
        }
        
        
    }
    
    // MARK: - Method
    
    func binding() {
        
        writeView.textView.rx.didBeginEditing
            .withUnretained(self)
            .bind { vc, _ in
                vc.navigationItem.setRightBarButtonItems([vc.completeButton, vc.shareButton], animated: true)
            }
            .disposed(by: disposeBag)
        
        completeButton.rx.tap
            .withUnretained(self)
            .bind { vc, _ in
                vc.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)
        
        shareButton.rx.tap
            .withUnretained(self)
            .bind { vc, _ in
                let activity = UIActivityViewController(activityItems: [vc.writeView.textView.text!], applicationActivities: nil)
                
                vc.present(activity, animated: true)
            }
            .disposed(by: disposeBag)
        
        
    }
    
    override func setNavigationItem() {
        
        navigationItem.largeTitleDisplayMode = .never
        
    }
    
    
    // MARK: - initialization
    
    
    init(memoData: Memo){
        viewModel = WriteViewModel(memo: memoData)
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    deinit {
        print(#function, "deinit")
    }
    
}
