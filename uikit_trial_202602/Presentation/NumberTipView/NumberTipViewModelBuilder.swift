//
//  NumberTipViewModelBuilder.swift
//  uikit_trial_202602
//
//  Created by Kazma Wed on 2026/02/18.
//

final class NumberTipViewModelBuilder {
    func build(with number: Int) -> NumberTipViewModel {
        NumberTipViewModel(number: number)
    }
}
