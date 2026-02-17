//
//  CounterRepositoryImpl.swift
//  uikit_trial_202602
//

final class CounterRepositoryImpl: CounterRepository {

    private var value: Int = 0

    func increment() {
        value += 1
    }

    func decrement() {
        value -= 1
    }

    func reset() {
        value = 0
    }

    func getValue() -> Int {
        return value
    }
}
