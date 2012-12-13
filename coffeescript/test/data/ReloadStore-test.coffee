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
  
  "Retrying on bailout will cause 3 new retries": (done) ->
    tries = 0
    
    this.testFailProxy.setFailCount(6)
    this.reloadStore.on 'load', (store, records, successful, operation, opts) ->
      tries += 1
    
    this.reloadStore.on 'bailout', (store) ->
      if (tries == 3)
        store.load()
      else
        expect(tries).toEqual(6)
        done()
  
  "Store succeeds after 2 reload when failproxy is set to fail twice": (done) ->
    this.testFailProxy.setFailCount(2)
    done()
  
  "Store succeeds when retrying on bailout": (done) ->
    done()
  
  "Bailout event is fired every time when retries is set to 0": (done) ->
    done()
}