
import Foundation
import MapKit

class LocationsDataService {
    
    static let locations: [Location] = [
        Location(
            name: "Limpieza de la comunidad",
            cityName: "Puebla",
            coordinates: CLLocationCoordinate2D(latitude: 19.0430, longitude: -98.1980),
            description: "Unete a tu comunidad para limpiar la plaza principal. Una oportunidad para contribuir al bienestar de nuestro entorno.",
            imageNames: ["reciclaje"],
            link: ""),
        Location(
            name: "Reforestación",
            cityName: "San Pedro Cholula",
            coordinates: CLLocationCoordinate2D(latitude: 19.0630, longitude: -98.3050),
            description: "Ayuda a replantar árboles en áreas afectadas. Participa en la restauración de nuestros espacios verdes.",
            imageNames: ["arbol"],
            link: ""),
        Location(
            name: "Conservación del agua",
            cityName: "Atlixco",
            coordinates: CLLocationCoordinate2D(latitude: 18.9070, longitude: -98.4380),
            description: "Promueve el uso responsable del agua en tu comunidad. Cada gota cuenta en la lucha contra la escasez de agua.",
            imageNames: ["agua"],
            link: ""),
        Location(
            name: "Reducción de residuos",
            cityName: "Puebla",
            coordinates: CLLocationCoordinate2D(latitude: 19.0420, longitude: -98.1990),
            description: "Aprende y enseña cómo generar menos basura en casa. Pequeñas acciones pueden hacer una gran diferencia.",
            imageNames: ["basura"],
            link: ""),
        Location(
            name: "Donación de ropa",
            cityName: "San Pedro Cholula",
            coordinates: CLLocationCoordinate2D(latitude: 19.0620, longitude: -98.3040),
            description: "Dona ropa que ya no uses a un albergue local. Tu contribución puede cambiar vidas.",
            imageNames: ["donacion"],
            link: ""),
        Location(
            name: "Huertos urbanos",
            cityName: "Atlixco",
            coordinates: CLLocationCoordinate2D(latitude: 18.9060, longitude: -98.4370),
            description: "Cultiva tus propios alimentos en un espacio verde comunitario. Una iniciativa para un futuro más sostenible.",
            imageNames: ["huerto"],
            link: ""),
        Location(
            name: "Transporte sostenible",
            cityName: "Puebla",
            coordinates: CLLocationCoordinate2D(latitude: 19.0430, longitude: -98.1970),
            description: "Utiliza medios de transporte ecológicos como la bicicleta o el transporte público. Hacia una movilidad más limpia y eficiente.",
            imageNames: ["bicicleta"],
            link: ""),
        Location(
            name: "Reciclaje y compostaje",
            cityName: "San Pedro Cholula",
            coordinates: CLLocationCoordinate2D(latitude: 19.0630, longitude: -98.3060),
            description: "Separa tus residuos y aprende a compostar los orgánicos. Un paso esencial para un planeta más saludable.",
            imageNames: ["compostaje"],
            link: ""),
        Location(
            name: "Protección de la fauna marina",
            cityName: "Atlixco",
            coordinates: CLLocationCoordinate2D(latitude: 18.9050, longitude: -98.4360),
            description: "Reduce el uso de plástico y participa en limpiezas de playas. Cada acción cuenta en la protección de nuestros mares.",
            imageNames: ["tortuga"],
            link: ""),
        Location(
            name: "Consumo responsable",
            cityName: "Puebla",
            coordinates: CLLocationCoordinate2D(latitude: 19.0410, longitude: -98.2000),
            description: "Compra productos locales y ecológicos, y evita el consumo excesivo. Apoya a la economía local y al medio ambiente.",
            imageNames: ["consumo"],
            link: ""),
        Location(
            name: "Educación ambiental",
            cityName: "San Pedro Cholula",
            coordinates: CLLocationCoordinate2D(latitude: 19.0610, longitude: -98.3030),
            description: "Difunde información sobre la importancia de cuidar el medio ambiente. El conocimiento es clave para el cambio.",
            imageNames: ["educacion"],
            link: ""),
        // Puedes continuar agregando más campañas siguiendo el patrón anterior
    ]
    
}

