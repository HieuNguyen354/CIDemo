//
//  HomeResponseModel.swift
//  MultipleModule
//
//  Created by HieuNguyen on 12/11/24.
//

import Foundation
struct HeroesModel: Codable {
	let id: Int
	let name, localizedName, primaryAttr, attackType: String
	let roles: [String]

	enum CodingKeys: String, CodingKey {
		case id, name
		case localizedName = "localized_name"
		case primaryAttr = "primary_attr"
		case attackType = "attack_type"
		case roles
	}
}
