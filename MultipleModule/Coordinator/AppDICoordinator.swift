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
			HomeViewModel(fetchHeroesUseCase: resolver.resolve(FetchHeroesUseCase.self)!)
		}
		
		container.register(HomeDetailViewModel.self) { (_, text: String) in
			HomeDetailViewModel(text: text)
		}
	}
	
	private func registerUseCase() {
		container.register(HeroesResponsitory.self) { resolver in
			DefaultHeroesResponsitory(remote: resolver.resolve(HeroesRemoteDataSource.self)!,
									  local: resolver.resolve(HeroesLocalDataSource.self)!)
		}.inObjectScope(.container)
		
		container.register(HeroesRemoteDataSource.self) { _ in HeroesRemoteDataSource() }
		
		container.register(HeroesLocalDataSource.self) { _ in HeroesLocalDataSource() }
		
		container.register(FetchHeroesUseCase.self) { resolver in
			DefaultFetchHeroesUseCase(resonsitory: resolver.resolve(HeroesResponsitory.self)!)
		}
	}
	
}
