//
//  CounterRepositoryImpl.swift
//  uikit_trial_202602
//

final class CounterRepositoryImpl: CounterRepository {

    private var value: Int = 1

    func increment() {
        value += 1
    }

    func decrement() {
        value = max(1, value - 1)
    }

    func reset() {
        value = 1
    }

    func getValue() -> Int {
        return value
    }
}
