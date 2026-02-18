//
//  Dependencies.swift
//  uikit_trial_202602
//
//  Created by Kazma Wed on 2026/02/17.
//

import Dependencies

// MARK: - CounterRepository

private enum CounterRepositoryKey: DependencyKey {
    static let liveValue: any CounterRepository = CounterRepositoryImpl()
}

extension DependencyValues {
    var counterRepository: any CounterRepository {
        get { self[CounterRepositoryKey.self] }
        set { self[CounterRepositoryKey.self] = newValue }
    }
}

// MARK: - NumberTipRepository

private enum NumberTipRepositoryKey: DependencyKey {
    static let liveValue: any NumberTipRepository = NumberTipRepositoryImpl()
}

extension DependencyValues {
    var numberTipRepository: any NumberTipRepository {
        get { self[NumberTipRepositoryKey.self] }
        set { self[NumberTipRepositoryKey.self] = newValue }
    }
}
