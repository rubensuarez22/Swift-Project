
import Foundation
import MapKit

class LocationsDataService {
    
    static let locations: [Location] = [
        Location(
            name: "Catedral de Puebla",
            cityName: "Puebla",
            coordinates: CLLocationCoordinate2D(latitude: 19.0428, longitude: -98.1982),
            description: "Como uno de los edificios más emblemáticos de la ciudad, la Catedral de Puebla es una parada obligatoria para cualquier visitante, siendo un impresionante ejemplo de arquitectura barroca.",
            imageNames: [
                "puebla-catedral-1",
                "puebla-catedral-2",
                "puebla-catedral-3",
            ],
            link: "https://es.wikipedia.org/wiki/Catedral_de_Puebla"),
        Location(
            name: "Pirámide de Cholula",
            cityName: "San Pedro Cholula",
            coordinates: CLLocationCoordinate2D(latitude: 19.0629, longitude: -98.3046),
            description: "La Gran Pirámide de Cholula, conocida también como Tlachihualtepetl, es el mayor monumento piramidal en volumen en el mundo, dedicado al dios Quetzalcóatl.",
            imageNames: [
                "sanpedrocholula-piramide-1",
            ],
            link: "https://es.wikipedia.org/wiki/Gran_Pir%C3%A1mide_de_Cholula"),
        Location(
            name: "Ex Convento Franciscano",
            cityName: "Atlixco",
            coordinates: CLLocationCoordinate2D(latitude: 18.9067, longitude: -98.4378),
            description: "El Ex Convento Franciscano en Atlixco es un hermoso ejemplo de la arquitectura religiosa de la época colonial en México.",
            imageNames: [
                "atlixco-exconventofranciscano-1",
            ],
            link: "https://es.wikipedia.org/wiki/Atlixco"),
        // Continúa agregando más ubicaciones según el patrón anterior
    ]
    
}

