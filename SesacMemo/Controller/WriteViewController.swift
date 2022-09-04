//
//  WriteViewController.swift
//  SesacMemo
//
//  Created by 김윤수 on 2022/09/01.
//

import UIKit

final class WriteViewController: BaseViewController {
    
    // MARK: - Properties
    
    let writeView = WriteViwe()
    
    let repository = MemoRealmRepository()
    
    let currentMemo: Memo
    
    lazy var completeButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(touchCompleteButton(_:)))
    
    lazy var shareButton = UIBarButtonItem(image: .init(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(touchShareButton(_:)))
    
    
    // MARK: - LifeCycle
    
    override func loadView() {
        view = writeView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.writeView.textView.delegate = self
        
        self.navigationController?.setToolbarHidden(true, animated: true)
        
        writeView.textView.text = currentMemo.content
        
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
        
        saveChanges()
        
        
    }
    
    // MARK: - Method
    
    override func setNavigationItem() {
        
        navigationItem.largeTitleDisplayMode = .never
        
    }
    
    func saveChanges() {
        
        do {
            try repository.updateTaskWithData(task: currentMemo, dataToUpdate: splitTextAndGetContent(text: writeView.textView.text))
        } catch {
            print(error)
        }
        
    }
    
    func splitTextAndGetContent(text: String) -> MemoContent? {
        
        let strings = text.split(separator: "\n").map { $0.trimmingCharacters(in: .whitespaces) }
        
        if strings.count > 0 {
            let withoutSpace = strings.filter { !$0.isEmpty }
            let title = withoutSpace.count > 0 ? withoutSpace[0] : ""
            let subtitle = withoutSpace.count > 1 ? withoutSpace[1] : ""
            return MemoContent(title: title, subtitle: subtitle, content: text)
        }
        
        return nil
        
    }
    
    // MARK: - Action Method
    
    @objc func touchCompleteButton(_ sender: UIBarButtonItem) {
        
        navigationController?.popViewController(animated: true)
        
    }
    
    @objc func touchShareButton(_ sender: UIBarButtonItem) {
        
        let vc = UIActivityViewController(activityItems: [writeView.textView.text!], applicationActivities: nil)
        
        present(vc, animated: true)
        
    }
    
    // MARK: - initialization
    
    
    init(memoData: Memo){
        currentMemo = memoData
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}

// MARK: - UITextViewDelegate

extension WriteViewController: UITextViewDelegate {
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
//        navigationItem.setRightBarButtonItems([], animated: true)
        
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        navigationItem.setRightBarButtonItems([completeButton, shareButton], animated: true)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        guard let text = textView.text else { return }
        
//        print(text.components(separatedBy: [" ", "\n"]), separator: " ")
        
        print(text.split(separator: "\n").map{ $0.trimmingCharacters(in: .whitespaces)
        }.filter { !$0.isEmpty })
    }
    
}
