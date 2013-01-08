buster.testCase "ConnectivityMap", {
  setUp: () ->
    this.map = Ext.create 'RfTouch.ConnectivityMap'
  
  "Map gets masked when offline event is fired": () ->
    map = this.map
    eventSimulation = () ->
      map.setOnline.call(map, false)
    
    this.stub(map, "setMasked")
    eventSimulation()
    
    assert.calledOnce(map.setMasked)
    assert.calledWith(map.setMasked, map.getOfflineMask())
 
  "Map gets unmasked when online is fired after offline": () ->
    map = this.map
    eventSimulation = () ->
      map.setOnline.call(map, true)
    
    this.stub(map, "setMasked")
    eventSimulation()
    
    assert.calledOnce(map.setMasked)
    assert.calledWith(map.setMasked, false)
  
  "online calls setOnline with true": () ->
    # Stub
  
  "offline calls setOnline with false": () ->
    # Stub
}
