// Generated by CoffeeScript 1.3.3
/**
  ReloadStore is an Store for automatically retrying when store data fails to 
  load. A small primitive, yet useful tool.
  
      @example
      Ext.define('Project.store.MyStore', {
        extend: 'RfTouch.data.ReloadStore',
        // Configure model, proxy etc as with a normal Sencha Touch 2 store
        
        retries: 2
      });
*/

Ext.define('RfTouch.data.ReloadStore', {
  extend: 'Ext.data.Store',
  _tries: 0,
  config: {
    /**
      @cfg {Number} retries
      The amount of times it should keep retrying before presenting with the 
      fallback option.
    */

    retries: 2,
    listeners: {
      load: {
        fn: 'retryLoad',
        order: 'after'
      }
    }
  },
  /**
    Resets the retry counter and attempts to load it again.
    
    @param {RfTouch.data.ReloadStore} (optional) the store to reload, defaults 
    to this. Can be useful if you're having scoping problems.
  */

  resetAndReload: function(store) {
    if (store == null) {
      store = this;
    }
    store._tries = 0;
    return store.load();
  },
  /**
    @private
    Default handler for
  */

  retryLoad: function(store, records, success, operation, opts) {
    if (!success) {
      if (store._tries < store.getRetries()) {
        store._tries += 1;
        return store.load();
      } else {
        return store.fireBailoutEvent();
      }
    }
  },
  /**
    @private
    Fires the bailout event
  */

  fireBailoutEvent: function(store) {
    if (store == null) {
      store = this;
    }
    return store.fireEvent('bailout', store);
  }
});
