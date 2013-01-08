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
      this.setMasked(false)    
    else
      this.setMasked(this.getOfflineMask())    
}
