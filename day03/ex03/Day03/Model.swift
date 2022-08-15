//
//  ViewController.swift
//  ex03
//
//  Created by Андрей Мотырев on 14.08.2022.
//

import Foundation

class Model {
	static let images: [URL?] = [
		URL(string: "https://mars.nasa.gov/system/resources/detail_files/26895_PIA25326-web.jpg"),
		URL(string: "https://mars.nasa.gov/system/resources/detail_files/26715_PIA25233-web.jpg"),
		URL(string: "https://mars.nasa.gov/system/resources/detail_files/26717_PIA25234-web.jpg"),
		URL(string: "https://www.nasa.gov/sites/default/files/thumbnails/image/hubble_hh505_potw2232a.jpg"),
		URL(string: "https://mars.nasa.gov/system/resources/detail_files/26694_1-PIA25219-web.jpg"),
		URL(string: "https://mars.nasa.gov/system/resources/detail_files/26617_PIA25171-web.jpg"),
        URL(string: "https://www.nasa.gov/sites/default/files/thumbnails/image/florence.jpeg"),
        URL(string: "https://www.nasa.gov/sites/default/files/thumbnails/image/45025340661_7b9f8f9402_k.jpg"),
        URL(string: "https://www.nasa.gov/sites/default/files/thumbnails/image/8.22-396o5017lane.jpg")
	]

	static let errorUrl: URL? = URL(string: "https://www.google.com/images/errors/robot.png")
}
