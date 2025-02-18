//
//  AppDICoordinator.swift
//  MultipleModule
//
//  Created by HieuNguyen on 15/2/25.
//

import Swinject

class AppDICoordinator {
	
	static let shared = AppDICoordinator()
	let container: Container
	
	private init() {
		container = Container()
		
		// Register Coordinators
		registerCoordinator()
		
		// Register UseCase
		registerUseCase()
		
		// Register ViewModels
		registerViewModel()
	}
	
	private func registerCoordinator() {
		container.register(TabBarCoordinator.self) { (resolver, tabBarController: BaseTabBarController) in
			TabBarCoordinator(resolver: resolver, tabBarController: tabBarController)
		}.inObjectScope(.container)
		
		container.register(AppCoordinator.self) { resolver, window in
			AppCoordinator(container: resolver, window: window)
		}
		
		container.register(HomeCoordinator.self) { (resolver, navigationController: BaseNavigationController) in
			HomeCoordinator(navigationController: navigationController, resolve: resolver)
		}
		
		container.register(OrderCoordinator.self) { (resolver, navigationController: BaseNavigationController) in
			OrderCoordinator(navigationController: navigationController, resolve: resolver)
		}
	}
	
	private func registerViewModel() {
		container.register(HomeViewModel.self) { resolver in
			HomeViewModel(fetchHeroesUseCase: resolver.resolve(FetchHomeUseCase.self)!)
		}
		
		container.register(HomeDetailViewModel.self) { (_, text: String) in
			HomeDetailViewModel(text: text)
		}
	}
	
	private func registerUseCase() {
		
		// - MARK: Home UseCase
		container.register(HomeRepository.self) { r in
			DefaultHomeRepository(remoteDataSource: r.resolve(HomeRemoteDataSource.self)!,
									localDataSource: r.resolve(HomeLocalDataSource.self)!)
		}.inObjectScope(.container)
		
		container.register(HomeRemoteDataSource.self) { _ in HomeRemoteDataSource() }
		
		container.register(HomeLocalDataSource.self) { _ in HomeLocalDataSource() }
		
		container.register(FetchHomeUseCase.self) { r in
			DefaultFetchHomeUseCase(repository: r.resolve(HomeRepository.self)!)
		}
		
		// - MARK: Order Usecase
		container.register(OrderRepository.self) { r in
			DefaultOrderRepository(remoteDataSource: r.resolve(OrderRemoteDataSource.self)!)
		}.inObjectScope(.container)
		
		container.register(OrderRemoteDataSource.self) { _ in OrderRemoteDataSource() }
		
		container.register(FetchOrderUseCase.self) { r in
			DefaultFetchOrderUseCase(repository: r.resolve(OrderRepository.self)!)
		}
	}
	
}
