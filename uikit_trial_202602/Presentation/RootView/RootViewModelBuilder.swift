//
//  RootViewModelBuilder.swift
//  uikit_trial_202602
//
//  Created by Kazma Wed on 2026/02/18.
//

import Dependencies

/// RootViewModelを構築するBuilder
///
/// # 概要
/// Builderパターンを用いて`RootViewModel`の依存性を外部から注入できます。
/// 本番コードではデフォルト値が使われ、テストコードでは任意のモックを渡せます。
///
/// # 利用例（本番）
/// ```swift
/// let viewModel = RootViewModelBuilder().build()
/// ```
///
/// # 利用例（テスト時に依存性を差し替え）
/// ```swift
/// let viewModel = RootViewModelBuilder()
///     .set(counterRepository: MockCounterRepository())
///     .build()
/// ```
final class RootViewModelBuilder {

    // MARK: - Properties

    private var counterRepository: (any CounterRepository)?

    // MARK: - Builder Methods

    /// CounterRepositoryを差し替える
    ///
    /// 省略した場合は Dependencies フレームワークの liveValue が使われます。
    @discardableResult
    func set(counterRepository: any CounterRepository) -> Self {
        self.counterRepository = counterRepository
        return self
    }

    // MARK: - Build

    func build() -> RootViewModel {
        if let counterRepository {
            return withDependencies {
                $0.counterRepository = counterRepository
            } operation: {
                RootViewModel()
            }
        } else {
            return RootViewModel()
        }
    }
}
