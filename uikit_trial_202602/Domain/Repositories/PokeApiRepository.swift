//
//  NumberTipRepository.swift
//  uikit_trial_202602
//
//  Created by Kazma Wed on 2026/02/18.
//

protocol PokeApiRepository {
    func getPokedexData(_ number: Int) async throws -> PokedexData
}
