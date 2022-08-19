//
//  PlacesList.swift
//  ex00
//
//  Created by Андрей Мотырев on 18.08.2022.
//

import Foundation

struct Place    {
    var name: String
}

class PlacesList    {
    var places: [Place] = []
    init()    {
        places.append(Place(name: "21 - Kazan Campus"))
        places.append(Place(name: "21 - Moscow Campus"))
        places.append(Place(name: "21 – Novosibirsk Campus"))
        places.append(Place(name: "42 – Paris Campus"))
    }
}
