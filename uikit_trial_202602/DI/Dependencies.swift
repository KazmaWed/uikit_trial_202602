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

// MARK: - PokeApiRepository

private enum PokeApiRepositoryKey: DependencyKey {
    static let liveValue: any PokeApiRepository = PokeApiRepositoryImpl()
}

extension DependencyValues {
    var pokemonApiRepository: any PokeApiRepository {
        get { self[PokeApiRepositoryKey.self] }
        set { self[PokeApiRepositoryKey.self] = newValue }
    }
}
