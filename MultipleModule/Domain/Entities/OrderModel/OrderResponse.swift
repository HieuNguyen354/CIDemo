//
//  OrderResponse.swift
//  MultipleModule
//
//  Created by HieuNguyen on 18/2/25.
//

import Foundation

typealias OrderResponse = [OrderResponseElement]

struct OrderResponseElement: Codable, Equatable {
	let accountID: Int
	let steamid: String?
	let avatar, avatarmedium, avatarfull: String?
	let profileurl: String?
	let personaname, lastLogin, fullHistoryTime: String?
	let cheese: Int?
	let fhUnavailable: Bool?
	let loccountrycode, lastMatchTime: String?
	let plus: Bool?
	let name, countryCode: String
	let fantasyRole, teamID: Int
	let teamName, teamTag: String
	let isLocked, isPro: Bool
	
	enum CodingKeys: String, CodingKey {
		case accountID = "account_id"
		case steamid, avatar, avatarmedium, avatarfull, profileurl, personaname
		case lastLogin = "last_login"
		case fullHistoryTime = "full_history_time"
		case cheese
		case fhUnavailable = "fh_unavailable"
		case loccountrycode
		case lastMatchTime = "last_match_time"
		case plus, name
		case countryCode = "country_code"
		case fantasyRole = "fantasy_role"
		case teamID = "team_id"
		case teamName = "team_name"
		case teamTag = "team_tag"
		case isLocked = "is_locked"
		case isPro = "is_pro"
	}
	
	static func ==(lhs: OrderResponseElement, rhs: OrderResponseElement) -> Bool {
		return lhs.accountID == rhs.accountID
	}
}
