###*
  Simple frame for the ConnectivityMap
###
Ext.define "RfTouch.ConnectivityMap", {
  extend: 'Ext.Panel'
  
  
  config:
    ###*
      @cfg {Ext.Mask/Ext.LoadMaskObject/Boolean} offlineMask
      The mask to show when the map is offline. Usually this 
      would be a load mask with a message telling the user that 
      he needs to be online.
      
      Example:
        
        offlineMask: {
          xtype: 'loadmask',
          message: 'Please connect to the internet to use the map.'
        }
    ###
    offlineMask: {
      xtype: 'loadmask'
      message: 'Please connect to the internet to use the map.'
    }
    
    ###*
      @cfg {String} googleMapsApiPath
      The path where Google Maps is located, usually this don't need 
      to be modified.
    ###
    googleMapsApiPath: "https://maps.googleapis.com/maps/api/js?sensor=true"
  
  constructor: () ->
    if (!window.rohdef?)
      window.rohdef = {}
    if (!window.rohdef.rftouch?)
      window.rohdef.rftouch = {}
    if (!window.rohdef.rftouch.gmap_cb?())
      window.rohdef.rftouch.gmap_cb = this._defaultMapsApiCb
      
    this.callParent arguments
  
  ###*
    @private
    Helper method containing the implementation for the callback 
    to use with Google Maps
  ###
  _defaultMapsApiCb: () ->
    # stub
  
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
    googleMapsUrl = this.getGoogleMapsApiPath()
    #window.rohdef.rftouch.gmap_cb = this._defaultMapsApiCb
    
    script = document.createElement "script"
    script.type = "text/javascript"
    script.src = googleMapsUrl
    #script.src = 'http://maps.google.com/maps/api/js?key='
    #  + mobamb.configuration.google.maps.apiKey
    #  + '&sensor=true&region=dk&callback=window.mapInit';
    document.head.appendChild script
    
    ###
    request = new XMLHttpRequest();
    request.open('GET', path, false);
    request.send()
    
    resp = request.responseText
    eval resp
    ###
    
    # Stub
    # &key=??
}
