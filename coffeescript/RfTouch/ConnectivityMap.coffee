###*
  Simple frame for the ConnectivityMap
###
Ext.define "RfTouch.ConnectivityMap", {
  extend: 'Ext.Panel'
  
  
  config:
    offlineMask: {
      xtype: 'loadmask'
      message: 'Please connect to the internet to use the map.'
    }
  
  setOnline: (online) ->
    if (online)
      if (window.google? and window.google.maps?)
        this.setMasked(false)    
      else
        this.loadMaps()
    else
      this.setMasked(this.getOfflineMask())
  
  online: () ->
    this.setOnline(true)
  
  offline: () ->
    this.setOnline(false)
  
  loadMaps: () ->
    # Stub
}
