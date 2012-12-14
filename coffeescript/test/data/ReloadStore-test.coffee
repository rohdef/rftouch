buster.testCase "ReloadStore", {
  setUp: () ->
    proxyName = 'RfTouchTest.data.proxy.FailProxy'
    
    Ext.syncRequire proxyName
    this.testFailProxy = Ext.create proxyName
    
    this.reloadStore = Ext.create 'RfTouch.data.ReloadStore', {
      model: 'RfTouchTest.model.Person'
      proxy: this.testFailProxy
    }
  
  "ReloadStore can succeed in first try": (done) ->
    this.testFailProxy.setFailCount(0)
    this.reloadStore.on 'load', (store, records, successful, operation, opts) ->
      expect(successful).toEqual(true)
      done()
    
    this.reloadStore.load()
  
  "Bailout event is fired after 3 tries": (done) ->
    tries = 0
    
    this.reloadStore.on 'load', (store, records, successful, operation, opts) ->
      tries += 1
    
    this.reloadStore.on 'bailout', (store) ->
      expect(tries).toEqual(3)
      done()
    
    this.reloadStore.load()
  
  "Retrying on bailout will cause 3 new retries": (done) ->
    tries = 0
    
    this.testFailProxy.setFailCount(6)
    this.reloadStore.on 'load', (store, records, successful, operation, opts) ->
      tries += 1
    
    this.reloadStore.on 'bailout', (store) ->
      if (tries == 3)
        store.resetAndReload()
      else
        expect(tries).toEqual(6)
        done()
    
    this.reloadStore.load()
  
  "Store succeeds after 2 reload when failproxy is set to fail twice": (done) ->
    tries = 0
    this.testFailProxy.setFailCount(2)
    
    this.reloadStore.on 'load', (store, records, successful, operation, opts) ->
      tries += 1
      
      if (tries == 3)
        expect(successful).toEqual(true)
        done()
    
    this.reloadStore.load()
  
  "Store succeeds when retrying on bailout": (done) ->
    tries = 0
    
    this.reloadStore.on 'load', (store, records, successful, operation, opts) ->
      tries += 1
      
      if (tries == 4)
        expect(successful).toEqual(true)
        done()
    
    this.reloadStore.on 'bailout', (store) ->
      store.load()
    
    this.reloadStore.load()
  
  "Bailout event is fired every time when retries is set to 0": (done) ->
    tries = 0
    bailouts = 0
    
    this.testFailProxy.setFailCount(5)
    this.reloadStore.setRetries(0)
    
    this.reloadStore.on 'load', (store, records, successful, operation, opts) ->
      tries += 1
    
    this.reloadStore.on 'bailout', (store) ->
      bailouts += 1
      
      if (bailouts == 4)
        expect(tries).toEqual(4)
        done()
      else
        store.resetAndReload()
    
    this.reloadStore.load()
}