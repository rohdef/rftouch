###*
  ReloadStore is an Store for automatically retrying when store data fails to 
  load. A small primitive, yet useful tool.
  
      @example
      Ext.define('Project.store.MyStore', {
        extend: 'RfTouch.data.ReloadStore',
        // Configure model, proxy etc as with a normal Sencha Touch 2 store
        
        retries: 2
      });
###

Ext.define 'RfTouch.data.ReloadStore', {
  extend: 'Ext.data.Store'
  
  _tries: 0

  config:
    ###*
      @cfg {Number} retries
      The amount of times it should keep retrying before presenting with the 
      fallback option.
    ###
    retries: 3
    
    listeners:
      load: 'retryLoad'
      bailout: 'defaultBailoutHandle'
    
  retryLoad: (store, records, success, operation, opts) ->
    if not success
      if store._tries >= store.getRetries()
        #store.load()
        store._tries += 1
      else
        store.fireBailoutEvent()
  
  ###*
    Resets the retry counter and attempts to load it again.
    
    @param {RfTouch.data.ReloadStore} (optional) the store to reload, defaults 
    to this. Can be useful if you're having scoping problems.
  ###
  resetAndReload: (store=this) ->
    store._tries = 0
    store.load()
  
  ###*
    @private
  ###
  fireBailoutEvent: (store = this) ->
    store.fireEvent('bailout', store)
  
  ###*
    @private
  ###
  defaultBailoutHandle: (store) ->
    Ext.Msg.alert('Loading data failed',
              'Press ok to try again.',
              store.resetAndReload, store);
}
