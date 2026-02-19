//
//  NumberTipRepositoryImpl.swift
//  uikit_trial_202602
//
//  Created by Kazma Wed on 2026/02/18.
//

import Foundation

final class PokeApiRepositoryImpl: PokeApiRepository {
    func getPokedexData(_ number: Int) async throws -> PokedexData {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(number)") else {
            throw URLError(.badServerResponse)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        do {
            let response = try JSONDecoder().decode(PokedexData.self, from: data)
            return response
        } catch {
            debugPrint("❌ Decode error: \(error)")
            throw error
        }
    }
}
