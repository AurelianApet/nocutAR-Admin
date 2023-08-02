function initMap() {
    var map = new google.maps.Map(document.getElementById('map'), {
        zoom: 8,
        center: { lat: 40.731, lng: -73.997 }
    });
    var marker = new google.maps.Marker({
        position: { lat: 40.731, lng: -73.997 },
        map: map,
        draggable: true
    });
    var geocoder = new google.maps.Geocoder;
    var infowindow = new google.maps.InfoWindow;

    google.maps.event.addListener(marker, 'drag', function (evt) {
        document.getElementById('latlng').value = evt.latLng.lat().toFixed(3) + ',' + evt.latLng.lng().toFixed(3);
    });
}
