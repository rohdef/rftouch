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
    
    expect(map.setMasked).toHaveBeenCalledOnce()
    expect(map.setMasked).toHaveBeenCalledWith map.getOfflineMask()
 
  "Map gets unmasked when online is fired after offline": () ->
    map = this.map
    eventSimulation = () ->
      map.setOnline.call map, true
    
    this.stub map, "setMasked"
    eventSimulation()
    
    expect(map.setMasked).toHaveBeenCalledOnce()
    expect(map.setMasked).toHaveBeenCalledWith false
  
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
    
    expect(map.setOnline).toHaveBeenCalledOnce()
    expect(map.setOnline).toHaveBeenCalledWith false
}


buster.testCase "ConnectivityMap with maps not loaded", {
  setUp: () ->
    this.map = Ext.create 'RfTouch.ConnectivityMap'
    this.server = this.useFakeServer().create()
  
  tearDown: () ->
    this.map.destroy()
  
  "When going online the map loads Google maps": () ->
    map = this.map
    
    this.stub map, "loadMaps"
    this.stub map, "setMasked"
    map.online()
    
    expect(map.loadMaps).toHaveBeenCalledOnce()
    expect(map.setMasked).not.toHaveBeenCalled()
    
 # "When loadMaps is run it adds the google maps call to the head": () ->
    # Can this be made a little less implementation specific
    # this will depend on the element being added in head.
    
  #  this.stub document.head, "appendChild"
    
    
   # assert.called(document.head.appendChild)

  "The callback is executed when the script is loaded": (done) ->
    map = this.map
    this.stub(window.rohdef.rftouch, "gmap_cb")
    
    path = buster.env.contextPath+'/test-setup/res/google-maps-fake-response.js'
    map.setGoogleMapsApiPath path
    
    server = this.server
    window.rohdef.rftouch.resumeTest = ()->
      expect(window.rohdef.rftouch.gmap_cb).toHaveBeenCalledOnce()
      done()
    
    map.online()
    
  "The callback is called with an API key": (done) ->
    map = this.map
    this.stub(window.rohdef.rftouch, "gmap_cb")
    
    path = buster.env.contextPath+'/test-setup/res/google-maps-fake-response.js'
    map.setGoogleMapsApiPath path
    
    server = this.server
    window.rohdef.rftouch.resumeTest = ()->
      scriptTag = document.getElementById("")
      
      if (server.requests.length > 0) then
        # Do XHR test
      else if (scriptTag?) then
        # Get src
      
      if (url?)
        # Do test
      else
        console.warn "API key test can't be run. Either use XHR or give the script box the id: rohdef-test-gmap"
      
      done()
    
    map.online()
    
  #"The callback shows the map": () ->
    # Stub
}