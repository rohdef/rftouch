buster.testCase "ConnectivityMap with maps loaded", {
  setUp: () ->
    window.google = {}
    window.google.maps = {}
    
    this.map = Ext.create 'RfTouch.ConnectivityMap'
  
  tearDown: () ->
    delete window.google.maps
    delete window.google
    this.map.destroy()
    
  "Map gets masked when offline event is fired": () ->
    map = this.map
    eventSimulation = () ->
      map.setOnline.call map, false
    
    this.stub map, "setMasked"
    eventSimulation()
    
    assert.calledOnce map.setMasked
    assert.calledWith map.setMasked, map.getOfflineMask()
 
  "Map gets unmasked when online is fired after offline": () ->
    map = this.map
    eventSimulation = () ->
      map.setOnline.call map, true
    
    this.stub map, "setMasked"
    eventSimulation()
    
    assert.calledOnce map.setMasked
    assert.calledWith map.setMasked, false
  
  "online calls setOnline with true": () ->
    map = this.map
    
    this.stub map, "setOnline"
    map.online()
    
    assert.calledOnce map.setOnline
    assert.calledWith map.setOnline, true
  
  "offline calls setOnline with false": () ->
    map = this.map
    
    this.stub map, "setOnline"
    map.offline()
    
    assert.calledOnce map.setOnline
    assert.calledWith map.setOnline, false
}


buster.testCase "ConnectivityMap with maps not loaded", {
  setUp: () ->
    this.map = Ext.create 'RfTouch.ConnectivityMap'
  
  tearDown: () ->
    this.map.destroy()
  
  "When going online the map loads Google maps": () ->
    map = this.map
    
    this.stub map, "loadMaps"
    this.stub map, "setMasked"
    map.online()
    
    assert.calledOnce map.loadMaps
    refute.called map.setMasked
    
  "When loadMaps is run it adds the google maps call to the head": () ->
    this.stub document.head, "appendChild"
    # Check that google maps html element is added
    
    assert.called(document.head.appendChild)

  "The callback is executed when the script is loaded": () ->
    this.stub window.rohdef.rftouch, "gmap_cb"
    # assert.calledOnce window.rohdef.rftouch.gmap_cb

  "The callback shows the map": () ->
    # Stub
}