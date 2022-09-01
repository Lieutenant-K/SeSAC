//
//  WriteViewController.swift
//  SesacMemo
//
//  Created by 김윤수 on 2022/09/01.
//

import UIKit

class WriteViewController: BaseViewController {
    
    let writeView = WriteViwe()
    
    let repository = MemoRealmRepository()
    
    var currentMemo: Memo?
    
    // MARK: - LifeCycle
    
    override func loadView() {
        view = writeView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.writeView.textView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setToolbarHidden(true, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        writeView.textView.becomeFirstResponder()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print(#function)
        
        let strings = splitString(text: writeView.textView.text)
        
        // 메모 수정
        if let memo = currentMemo {
            
            guard let memoContent = strings else {
                repository.deleteTask(task: memo)
                return
            }
            
            repository.updateTask {
                memo.title = memoContent.0
                memo.content = memoContent.1
            }
            
            
        } else {
            // 메모 생성
            
            guard let memoContent = strings else { return }
            
            repository.addTask(task: Memo(title: memoContent.0, content: memoContent.1))
        }
        
    }
    
    // MARK: - Method
    
    override func setNavigationItem() {
        
        let complete = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(touchCompleteButton(_:)))
        
        let share = UIBarButtonItem(image: .init(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(touchShareButton(_:)))
        
        navigationItem.rightBarButtonItems = [complete, share]
        
    }
    
    func splitString(text: String) -> (String, String)? {
        
        if text.isEmpty {
            return nil
        }
        
        let splitedText = text.split(maxSplits: 1, omittingEmptySubsequences: true) { $0 == "\n" }
        
        let title = splitedText[0]
        let content = splitedText.count > 1 ? splitedText[1] : ""
        
        return (String(title), String(content))
        
    }
    
    // MARK: - Action Method
    
    @objc func touchCompleteButton(_ sender: UIBarButtonItem) {
        
        navigationController?.popViewController(animated: true)
        
    }
    
    @objc func touchShareButton(_ sender: UIBarButtonItem) {
        
        let vc = UIActivityViewController(activityItems: [], applicationActivities: nil)
        
        present(vc, animated: true)
    }
}

extension WriteViewController: UITextViewDelegate {
    
    func textViewDidEndEditing(_ textView: UITextView) {
        print(#function)
        
        
        
    }
    
}
