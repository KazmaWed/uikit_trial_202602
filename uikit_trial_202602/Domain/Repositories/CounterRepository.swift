//
//  CounterRepository.swift
//  uikit_trial_202602
//

protocol CounterRepository {
    func increment()
    func decrement()
    func reset()
    func getValue() -> Int
}
