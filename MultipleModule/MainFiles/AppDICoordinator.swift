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
		container.register(TabBarCoordinator.self) { (r, tabBarController: BaseTabBarController) in
			TabBarCoordinator(resolver: r, tabBarController: tabBarController)
		}.inObjectScope(.container)
		
		container.register(AppCoordinator.self) { r, window in
			AppCoordinator(container: r, window: window)
		}
		
		container.register(HomeCoordinator.self) { (r, navigationController: BaseNavigationController) in
			HomeCoordinator(navigationController: navigationController, resolve: r)
		}
		
		container.register(OrderCoordinator.self) { (r, navigationController: BaseNavigationController) in
			OrderCoordinator(navigationController: navigationController, resolve: r)
		}
	}
	
	private func registerViewModel() {
		// - MARK: HomeViewModel
		container.register(HomeViewModel.self) { r in
			HomeViewModel(fetchHomeUseCase: r.resolve(FetchHomeUseCase.self)!)
		}
		
		container.register(HomeDetailViewModel.self) { (_, text: String) in
			HomeDetailViewModel(text: text)
		}
		
		// - MARK: OrderViewModel
		container.register(OrderViewModel.self) { r in
			OrderViewModel(fetchOrderUseCase: r.resolve(FetchOrderUseCase.self)!)
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
