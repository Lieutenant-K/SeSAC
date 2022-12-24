//
//  WriteViewModel.swift
//  SesacMemo
//
//  Created by 김윤수 on 2022/10/28.
//

import Foundation
import RxCocoa
import RxSwift

final class WriteViewModel {
    
    private let repository = MemoRealmRepository()
    
    let currentMemo: Memo
    
    private func splitTextAndGetContent(text: String) -> MemoContent? {
        
        let strings = text.split(separator: "\n").map { $0.trimmingCharacters(in: .whitespaces) }
        
        if strings.count > 0 {
            let withoutSpace = strings.filter { !$0.isEmpty }
            let title = withoutSpace.count > 0 ? withoutSpace[0] : ""
            let subtitle = withoutSpace.count > 1 ? withoutSpace[1] : ""
            return MemoContent(title: title, subtitle: subtitle, content: text)
        }
        
        return nil
        
    }
    
    func saveChanges(content: String, failureHandler: () -> ()) {
        
        do {
            try repository.updateTaskWithData(task: currentMemo, dataToUpdate: splitTextAndGetContent(text: content))
        } catch {
            failureHandler()
        }
        
    }
    
    init(memo: Memo) {
        self.currentMemo = memo
    }
    
}
