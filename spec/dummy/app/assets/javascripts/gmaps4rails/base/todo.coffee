#@Gmaps4Rails.BaseMethods =

  # updateBoundsWithPolygons: ()->
  #   for polygon in @polygons
  #     polygon_points = polygon.serviceObject.latLngs.getArray()[0].getArray()
  #     for point in polygon_points
  #       @boundsObject.extend point

  # updateBoundsWithCircles: ()->
  #   for circle in @circles
  #     @boundsObject.extend(circle.serviceObject.getBounds().getNorthEast())
  #     @boundsObject.extend(circle.serviceObject.getBounds().getSouthWest())

  #////////////////////////////////////////////////////
  #//////////////////// DIRECTIONS ////////////////////
  #////////////////////////////////////////////////////

  # create_direction : ->
  #   directionsDisplay = new google.maps.DirectionsRenderer()
  #   directionsService = new google.maps.DirectionsService()

  #   directionsDisplay.setMap(@serviceObject)
  #   #display panel only if required
  #   if @direction_conf.display_panel
  #     directionsDisplay.setPanel(document.getElementById(@direction_conf.panel_id))

  #   directionsDisplay.setOptions
  #     suppressMarkers:     false
  #     suppressInfoWindows: false
  #     suppressPolylines:   false

  #   request =
  #     origin:             @direction_conf.origin
  #     destination:        @direction_conf.destination
  #     waypoints:          @direction_conf.waypoints
  #     optimizeWaypoints:  @direction_conf.optimizeWaypoints
  #     unitSystem:         google.maps.DirectionsUnitSystem[@direction_conf.unitSystem]
  #     avoidHighways:      @direction_conf.avoidHighways
  #     avoidTolls:         @direction_conf.avoidTolls
  #     region:             @direction_conf.region
  #     travelMode:         google.maps.DirectionsTravelMode[@direction_conf.travelMode]
  #     language:           "en"

  #   directionsService.route request, (response, status) ->
  #     if (status == google.maps.DirectionsStatus.OK)
  #       directionsDisplay.setDirections(response)

  #////////////////////////////////////////////////////
  #///////////////////// CIRCLES //////////////////////
  #////////////////////////////////////////////////////

  #Loops through all circles
  #Loops through all circles and draws them
  # create_circles : ->
  #   for circle in @circles
  #     @create_circle circle

  # create_circle : (circle) ->
  #   #by convention, default style configuration could be integrated in the first element
  #   if circle == @circles[0]
  #     @circles_conf.strokeColor   = circle.strokeColor   if circle.strokeColor?
  #     @circles_conf.strokeOpacity = circle.strokeOpacity if circle.strokeOpacity?
  #     @circles_conf.strokeWeight  = circle.strokeWeight  if circle.strokeWeight?
  #     @circles_conf.fillColor     = circle.fillColor     if circle.fillColor?
  #     @circles_conf.fillOpacity   = circle.fillOpacity   if circle.fillOpacity?

  #   if circle.lat? and circle.lng?
  #     # always check if a config is given, if not, use defaults
  #     # NOTE: is there a cleaner way to do this? Maybe a hash merge of some sort?
  #     newCircle = new google.maps.Circle
  #       center:        @createLatLng(circle.lat, circle.lng)
  #       strokeColor:   circle.strokeColor   || @circles_conf.strokeColor
  #       strokeOpacity: circle.strokeOpacity || @circles_conf.strokeOpacity
  #       strokeWeight:  circle.strokeWeight  || @circles_conf.strokeWeight
  #       fillOpacity:   circle.fillOpacity   || @circles_conf.fillOpacity
  #       fillColor:     circle.fillColor     || @circles_conf.fillColor
  #       clickable:     circle.clickable     || @circles_conf.clickable
  #       zIndex:        circle.zIndex        || @circles_conf.zIndex
  #       radius:        circle.radius

  #     circle.serviceObject = newCircle
  #     newCircle.setMap(@serviceObject)

  # # clear circles
  # clear_circles : ->
  #   for circle in @circles
  #     @clear_circle circle

  # clear_circle : (circle) ->
  #   circle.serviceObject.setMap(null)

  # hide_circles : ->
  #   for circle in @circles
  #     @hide_circle circle

  # hide_circle : (circle) ->
  #   circle.serviceObject.setMap(null)

  # show_circles : ->
  #   for circle in @circles
  #     @show_circle @circle

  # show_circle : (circle) ->
  #   circle.serviceObject.setMap(@serviceObject)

  # #////////////////////////////////////////////////////
  # #///////////////////// POLYGONS /////////////////////
  # #////////////////////////////////////////////////////

  # #polygons is an array of arrays. It loops.
  # create_polygons : ->
  #   for polygon in @polygons
  #     @create_polygon(polygon)

  # #creates a single polygon, triggered by create_polygons
  # create_polygon : (polygon) ->
  #   polygon_coordinates = []

  #   #Polygon points are in an Array, that's why looping is necessary
  #   for point in polygon
  #     latlng = @createLatLng(point.lat, point.lng)
  #     polygon_coordinates.push(latlng)
  #     #first element of an Array could contain specific configuration for this particular polygon. If no config given, use default
  #     if point == polygon[0]
  #       strokeColor   = point.strokeColor   || @polygons_conf.strokeColor
  #       strokeOpacity = point.strokeOpacity || @polygons_conf.strokeOpacity
  #       strokeWeight  = point.strokeWeight  || @polygons_conf.strokeWeight
  #       fillColor     = point.fillColor     || @polygons_conf.fillColor
  #       fillOpacity   = point.fillOpacity   || @polygons_conf.fillOpacity
  #       clickable     = point.clickable     || @polygons_conf.clickable
        
  #   #Construct the polygon
  #   new_poly = new google.maps.Polygon
  #     paths:          polygon_coordinates
  #     strokeColor:    strokeColor
  #     strokeOpacity:  strokeOpacity
  #     strokeWeight:   strokeWeight
  #     fillColor:      fillColor
  #     fillOpacity:    fillOpacity
  #     clickable:      clickable
  #     map:            @serviceObject

  #   #save polygon in list
  #   polygon.serviceObject = new_poly

  
  # #Polyline Styling
  # polylines_conf:         #default style for polylines
  #   strokeColor: "#FF0000"
  #   strokeOpacity: 1
  #   strokeWeight: 2
  #   clickable: false
  #   zIndex: null


  #replace old markers with new markers on an existing map
  # replacePolylines : (new_polylines) ->
  #   #reset previous polylines and kill them from map
  #   @destroy_polylines()
  #   #set new polylines
  #   @polylines = new_polylines
  #   #create
  #   @create_polylines()
  #   #.... and adjust map boundaries
  #   @adjustMapToBounds()

  # destroy_polylines : ->
  #   for polyline in @polylines
  #     #delete polylines from map
  #     polyline.serviceObject.setMap(null)
  #   #empty array
  #   @polylines = []

  # #polylines is an array of arrays. It loops.
  # create_polylines : ->
  #   for polyline in @polylines
  #     @create_polyline polyline