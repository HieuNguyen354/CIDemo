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
		registerDependencies()
	}
	
	private func registerCoordinator() {
		container.register(TabBarCoordinator.self) { (r, tabBarController: BaseTabBarController) in
			TabBarCoordinator(resolver: r,
							  tabBarController: tabBarController)
		}.inObjectScope(.container)
		
		container.register(AppCoordinator.self) { r, window in
			AppCoordinator(container: r,
						   window: window)
		}
		
		container.register(HomeCoordinator.self) { (r, navigationController: BaseNavigationController) in
			HomeCoordinator(resolve: r,
							navigationController: navigationController)
		}
		
		container.register(OrderCoordinator.self) { (r, navigationController: BaseNavigationController) in
			OrderCoordinator(resolve: r,
							 navigationController: navigationController)
		}
	}
	
	private func registerViewController() {
		// - MARK: HomeViewController
		container.register(HomeViewController.self) { r in
			let viewModel = r.resolve(HomeViewModel.self)!
			let vc = HomeViewController(viewModel: viewModel)
			return vc
		}
		
		container.register(HomeDetailViewController.self) { (r, model: HomeDetailElement) in
			let viewModel = r.resolve(HomeDetailViewModel.self,
									  argument: model)!
			let vc = HomeDetailViewController(viewModel: viewModel)
			return vc
		}
		
		container.register(HomePresentViewController.self) { _ in
			HomePresentViewController()
		}
		
		// - MARK: OrderViewController
		container.register(OrderViewController.self) { r in
			let viewModel = r.resolve(OrderViewModel.self)!
			let vc = OrderViewController(viewModel: viewModel)
			return vc
		}
	}
	
	private func registerViewModel() {
		// - MARK: HomeViewModel
		container.register(HomeViewModel.self) { r in
			HomeViewModel(fetchHomeUseCase: r.resolve(FetchHomeUseCase.self)!)
		}
				
		container.register(HomeDetailViewModel.self) { (_, model: HomeDetailElement) in
			HomeDetailViewModel(model: model)
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
	
	private func registerDependencies() {
		registerCoordinator()
		registerViewController()
		registerViewModel()
		registerUseCase()
	}
}
