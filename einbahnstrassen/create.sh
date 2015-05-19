#!/bin/bash
wget http://www.hamburg.adfc.de/verkehr/themen-a-z/einbahnstrassen/bestandsaufnahme-einbahnstrassen-in-hamburg/liste-der-echten-einbahnstrassen/ -O einbahn.html
wget http://www.hamburg.adfc.de/verkehr/themen-a-z/einbahnstrassen/bestandsaufnahme-einbahnstrassen-in-hamburg/liste-der-freigegebenen-einbahnstrassen/ -O frei.html
wget 'http://overpass-api.de/api/interpreter?data=%2F*%0AThis%20has%20been%20generated%20by%20the%20overpass-turbo%20wizard.%0AThe%20original%20search%20was%3A%0A%E2%80%9Chighway%3D*%20and%20oneway%3D*%20in%20Hamburg%E2%80%9D%0A*%2F%0A%5Bout%3Ajson%5D%5Btimeout%3A100%5D%3B%0A%2F%2F%20fetch%20area%20%E2%80%9CHamburg%E2%80%9D%20to%20search%20in%0Aarea%283602618040%29-%3E.searchArea%3B%0A%2F%2F%20gather%20results%0A%28%0A%20%20%2F%2F%20query%20part%20for%3A%20%E2%80%9Chighway%3D*%20and%20oneway%3D*%E2%80%9D%0A%20%20way%5B%22highway%22%5D%5B%22oneway%22%5D%5B%22highway%22%21%3D%22motorway%22%5D%5B%22highway%22%21%3D%22proposed%22%5D%5B%22highway%22%21%3D%22service%22%5D%5B%22highway%22%21%3D%22motorway_link%22%5D%5B%22highway%22%21%3D%22cycleway%22%5D%5B%22oneway%22%21%3D%22no%22%5D%5B%22oneway%3Abicycle%22%3D%22no%22%5D%28area.searchArea%29%3B%0A%29%3B%0A%2F%2F%20print%20results%0Aout%20body%20center%3B%0A' -O freigegeben_in_osm.json
wget 'http://overpass-api.de/api/interpreter?data=%2F*%0AThis%20has%20been%20generated%20by%20the%20overpass-turbo%20wizard.%0AThe%20original%20search%20was%3A%0A%E2%80%9Chighway%3D*%20and%20oneway%3D*%20in%20Hamburg%E2%80%9D%0A*%2F%0A%5Bout%3Ajson%5D%5Btimeout%3A100%5D%3B%0A%2F%2F%20fetch%20area%20%E2%80%9CHamburg%E2%80%9D%20to%20search%20in%0Aarea%283602618040%29-%3E.searchArea%3B%0A%2F%2F%20gather%20results%0A%28%0A%20%20%2F%2F%20query%20part%20for%3A%20%E2%80%9Chighway%3D*%20and%20oneway%3D*%E2%80%9D%0A%20%20way%5B%22highway%22%5D%5B%22oneway%22%5D%5B%22highway%22%21%3D%22motorway%22%5D%5B%22highway%22%21%3D%22motorway_link%22%5D%5B%22oneway%22%21%3D%22no%22%5D%28area.searchArea%29%3B%0A%29%3B%0A%2F%2F%20print%20results%0Aout%20body%20center%3B%0A' -O overpass.json
perl parse-website.pl
perl freigegeben_auswertung.pl >data/freigegeben_ausertung1.txt
 wget 'http://overpass-api.de/api/interpreter?data=%2F*%20einfach%20auf%20overpass-turbo.eu%20eingeben%20*%2F%0A%5Bout%3Ajson%5D%5Btimeout%3A300%5D%3B%0A%2F%2F%20fetch%20area%20%E2%80%9CHamburg%E2%80%9D%20to%20search%20in%0Aarea%283602618040%29-%3E.searchArea%3B%0A%2F%2F%20gather%20results%0A%28%0A%20%20way%5B%22highway%22%5D%5B%22name%22%5D%5B%22highway%22%21%3D%22motorway%22%5D%5B%22highway%22%21%3D%22proposed%22%5D%5B%22highway%22%21%3D%22service%22%5D%5B%22highway%22%21%3D%22motorway_link%22%5D%5B%22highway%22%21%3D%22cycleway%22%5D%28area.searchArea%29%3B%0A%29%3B%0A%2F%2F%20print%20results%0Aout%20body%20center%3B%0A' -O strassenliste.json
