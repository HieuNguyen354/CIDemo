//
//  HomeTests.swift
//  MultipleModuleXCTests
//
//  Created by HieuNguyen on 24/2/25.
//

import XCTest
@testable import MultipleModule

final class HomeTests: XCTestCase {

	var homeModel: HomeModel!
	
	override func setUp() {
		super.setUp()
		homeModel = HomeModel(id: 1, name: "", localizedName: "", primaryAttr: "", attackType: "", roles: [])
	}
	override func tearDown() {
		super.tearDown()
		homeModel = nil
	}
	
	func testSportFasterThanJeep() {
	
		XCTAssertTrue(homeModel.localizedName == "")
	}
}
