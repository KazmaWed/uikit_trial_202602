//
//  NumberTipRepositoryImpl.swift
//  uikit_trial_202602
//
//  Created by Kazma Wed on 2026/02/18.
//

final class NumberTipRepositoryImpl: NumberTipRepository {
    func getNumberTip(_ number : Int) -> String {
        "Tip for \(number) is here: Xxx xxxx xxx...."
    }
}
