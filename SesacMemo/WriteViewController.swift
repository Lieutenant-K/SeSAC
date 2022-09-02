//
//  WriteViewController.swift
//  SesacMemo
//
//  Created by 김윤수 on 2022/09/01.
//

import UIKit

final class WriteViewController: BaseViewController {
    
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
        
        self.navigationController?.setToolbarHidden(true, animated: true)
        
        if let memo = currentMemo {
            writeView.textView.text = [memo.title, memo.content].joined(separator: "\n")
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if currentMemo == nil {
            writeView.textView.becomeFirstResponder()
        }
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print(#function)
        
        saveChanges()
        
        
    }
    
    // MARK: - Method
    
    override func setNavigationItem() {
        
        let complete = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(touchCompleteButton(_:)))
        
        let share = UIBarButtonItem(image: .init(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(touchShareButton(_:)))
        
        navigationItem.rightBarButtonItems = [complete, share]
        
    }
    
    func saveChanges() {
        
        let memo = currentMemo == nil ? Memo(title: "", content: "") : currentMemo!
        
        do {
        try repository.updateTask(task: memo, dataIntoUpdate: splitString(text: writeView.textView.text))
        } catch {
            print(error)
        }
        
    }
    
    func splitString(text: String) -> [String] {
        
        text.split(maxSplits: 1, omittingEmptySubsequences: true) { $0 == "\n" }.map { String($0) }
        
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
