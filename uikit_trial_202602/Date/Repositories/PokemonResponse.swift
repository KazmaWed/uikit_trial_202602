//
//  PokemonResponse.swift
//  uikit_trial_202602
//
//  Created by Kazma Wed on 2026/02/18.
//

// MARK: - PokemonResponse

struct PokemonResponse: Decodable {
    let abilities: [PokemonAbility]
    let baseExperience: Int?
    let cries: Cries
    let forms: [NamedAPIResource]
    let gameIndices: [GameIndex]
    let height: Int
    let heldItems: [HeldItem]
    let id: Int
    let isDefault: Bool
    let locationAreaEncounters: String
    let moves: [PokemonMove]
    let name: String
    let order: Int
    let pastAbilities: [PastAbility]
    let pastTypes: [PastType]
    let species: NamedAPIResource
    let sprites: Sprites
    let stats: [PokemonStat]
    let types: [PokemonType]
    let weight: Int

    enum CodingKeys: String, CodingKey {
        case abilities, forms, height, id, moves, name, order, species, sprites, stats, types, weight
        case baseExperience = "base_experience"
        case cries
        case gameIndices = "game_indices"
        case heldItems = "held_items"
        case isDefault = "is_default"
        case locationAreaEncounters = "location_area_encounters"
        case pastAbilities = "past_abilities"
        case pastTypes = "past_types"
    }
}

// MARK: - NamedAPIResource

struct NamedAPIResource: Decodable {
    let name: String
    let url: String
}

// MARK: - Ability

struct PokemonAbility: Decodable {
    let ability: NamedAPIResource
    let isHidden: Bool
    let slot: Int

    enum CodingKeys: String, CodingKey {
        case ability, slot
        case isHidden = "is_hidden"
    }
}

// MARK: - Cries

struct Cries: Decodable {
    let latest: String?
    let legacy: String?
}

// MARK: - GameIndex

struct GameIndex: Decodable {
    let gameIndex: Int
    let version: NamedAPIResource

    enum CodingKeys: String, CodingKey {
        case version
        case gameIndex = "game_index"
    }
}

// MARK: - HeldItem

struct HeldItem: Decodable {
    let item: NamedAPIResource
    let versionDetails: [HeldItemVersionDetail]

    enum CodingKeys: String, CodingKey {
        case item
        case versionDetails = "version_details"
    }
}

struct HeldItemVersionDetail: Decodable {
    let rarity: Int
    let version: NamedAPIResource
}

// MARK: - Move

struct PokemonMove: Decodable {
    let move: NamedAPIResource
    let versionGroupDetails: [MoveVersionGroupDetail]

    enum CodingKeys: String, CodingKey {
        case move
        case versionGroupDetails = "version_group_details"
    }
}

struct MoveVersionGroupDetail: Decodable {
    let levelLearnedAt: Int
    let moveLearnMethod: NamedAPIResource
    let versionGroup: NamedAPIResource

    enum CodingKeys: String, CodingKey {
        case levelLearnedAt = "level_learned_at"
        case moveLearnMethod = "move_learn_method"
        case versionGroup = "version_group"
    }
}

// MARK: - PastAbility

struct PastAbility: Decodable {
    let abilities: [PokemonAbility]
    let generation: NamedAPIResource
}

// MARK: - PastType

struct PastType: Decodable {
    let generation: NamedAPIResource
    let types: [PokemonType]
}

// MARK: - Sprites

struct Sprites: Decodable {
    let backDefault: String?
    let backFemale: String?
    let backShiny: String?
    let backShinyFemale: String?
    let frontDefault: String?
    let frontFemale: String?
    let frontShiny: String?
    let frontShinyFemale: String?
    let other: SpritesOther?

    enum CodingKeys: String, CodingKey {
        case other
        case backDefault = "back_default"
        case backFemale = "back_female"
        case backShiny = "back_shiny"
        case backShinyFemale = "back_shiny_female"
        case frontDefault = "front_default"
        case frontFemale = "front_female"
        case frontShiny = "front_shiny"
        case frontShinyFemale = "front_shiny_female"
    }
}

struct SpritesOther: Decodable {
    let dreamWorld: SpriteSet?
    let home: SpriteSet?
    let officialArtwork: SpriteSet?
    let showdown: SpriteSet?

    enum CodingKeys: String, CodingKey {
        case home, showdown
        case dreamWorld = "dream_world"
        case officialArtwork = "official-artwork"
    }
}

struct SpriteSet: Decodable {
    let backDefault: String?
    let backFemale: String?
    let backShiny: String?
    let backShinyFemale: String?
    let frontDefault: String?
    let frontFemale: String?
    let frontShiny: String?
    let frontShinyFemale: String?

    enum CodingKeys: String, CodingKey {
        case backDefault = "back_default"
        case backFemale = "back_female"
        case backShiny = "back_shiny"
        case backShinyFemale = "back_shiny_female"
        case frontDefault = "front_default"
        case frontFemale = "front_female"
        case frontShiny = "front_shiny"
        case frontShinyFemale = "front_shiny_female"
    }
}

// MARK: - Stat

struct PokemonStat: Decodable {
    let baseStat: Int
    let effort: Int
    let stat: NamedAPIResource

    enum CodingKeys: String, CodingKey {
        case effort, stat
        case baseStat = "base_stat"
    }
}

// MARK: - Type

struct PokemonType: Decodable {
    let slot: Int
    let type: NamedAPIResource
}
