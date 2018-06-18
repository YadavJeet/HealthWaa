//
//  Models.swift
//  Flex
//
//  Created by Harendra Sharma on 25/05/18.
//  Copyright © 2018 Harendra Sharma. All rights reserved.
//

import UIKit

// MARK: EmergencyUser object
class EmergencyUser: NSObject {
    
    var activeStatus: String? = nil
    var createdAt: String? = nil
    var updatedAt: String? = nil
    var isOnOff: String? = nil
    var mobileNo: String? = nil
    var relationId: String? = nil
    var name: String? = nil
    var id: String? = nil
    var relationName: String? = nil
    var uniqueId: String? = nil
    var uniqueIdStatus: String? = nil 

}

// MARK: FamilyUser object
class familyUser: NSObject {
    var name: String? = nil
    var id: Int? = nil
    var birthPlaceName: String? = nil
    var images: String? = nil
    var birthPlaceLatLong: String? = nil
    var bodyTemp: String? = nil
    var bodyTempType: String? = nil
    var breastfeeding: String? = nil
    var createdAt: String? = nil
    var dob: String? = nil
    var height: String? = nil
    var heightType: String? = nil
    var operationType: String? = nil
    var paediaticName: String? = nil
    var placeTemp: String? = nil
    var placeTempType: String? = nil
    var relation: String? = nil
    var sex: String? = nil
    var status: String? = nil
    var time: String? = nil
    var trackeId: String? = nil
    var uniqueId: String? = nil
    var updateAt: String? = nil
    var weight: String? = nil
    var weightType: String? = nil
}
